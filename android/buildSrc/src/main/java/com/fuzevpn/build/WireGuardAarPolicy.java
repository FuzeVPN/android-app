package com.fuzevpn.build;

import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.HexFormat;
import java.util.Map;
import java.util.zip.ZipFile;
import java.util.zip.ZipInputStream;

/** Distribution policy. The approved digest is code, never read from mutable artifact metadata. */
public final class WireGuardAarPolicy {
    public static final String APPROVED_SHA256 =
            "bf96422b21e086cf371154613f5250c8101568538ab40acb4ccbad09394e4811";
    private static final String BACKEND = "com/wireguard/android/backend/GoBackend";
    private static final String PROTECTED_START_SYMBOL = "Java_com_wireguard_android_backend_GoBackend_wgSetConfig";
    private static final String UAPI_SOCKET_DIRECTORY = "/data/data/com.fuzevpn/cache/wireguard";

    private WireGuardAarPolicy() {}

    public static void verify(String buildType, boolean patchedRequested, Path aar) {
        if (!patchedRequested) {
            if (!"debug".equals(buildType)) {
                throw new IllegalStateException("WG_PATCH_REQUIRED: " + buildType
                        + " requires -Pfuzevpn.usePatchedWireGuardAar=true. "
                        + "The official Maven runtime is allowed only in debug.");
            }
            return;
        }
        if (!Files.isRegularFile(aar)) {
            throw new IllegalStateException("WG_AAR_MISSING: audited WireGuard AAR missing: " + aar);
        }
        try {
            String actual = HexFormat.of().formatHex(
                    MessageDigest.getInstance("SHA-256").digest(Files.readAllBytes(aar)));
            if (!APPROVED_SHA256.equals(actual)) {
                throw new IllegalStateException("WG_AAR_HASH: unapproved WireGuard AAR. Expected "
                        + APPROVED_SHA256 + ", got " + actual + ". See docs/NATIVE_DEPENDENCIES.md.");
            }
            verifyApi(aar);
        } catch (IOException | NoSuchAlgorithmException error) {
            throw new IllegalStateException("WG_AAR_UNREADABLE: cannot verify WireGuard AAR", error);
        }
    }

    // Inspect method descriptors without loading Android classes or running third-party code.
    static void verifyApi(Path aar) throws IOException {
        Map<String, byte[]> classes = new HashMap<>();
        try (ZipFile archive = new ZipFile(aar.toFile())) {
            var jar = archive.getEntry("classes.jar");
            if (jar == null) throw apiFailure("classes.jar missing");
            try (ZipInputStream entries = new ZipInputStream(archive.getInputStream(jar))) {
                for (var entry = entries.getNextEntry(); entry != null; entry = entries.getNextEntry()) {
                    if (entry.getName().equals(BACKEND + ".class")
                            || entry.getName().equals(BACKEND + "$ForegroundNotificationFactory.class")
                            || entry.getName().equals(BACKEND + "$HostLifecycleListener.class")
                            || entry.getName().equals(BACKEND + "$VpnService.class")) {
                        classes.put(entry.getName(), entries.readAllBytes());
                    }
                }
            }
        }
        requireMethod(classes, BACKEND, "setForegroundNotificationFactory",
                "(L" + BACKEND + "$ForegroundNotificationFactory;)V", 0x0009, false);
        requireMethod(classes, BACKEND, "setHostLifecycleListener",
                "(L" + BACKEND + "$HostLifecycleListener;)V", 0x0009, false);
        requireMethod(classes, BACKEND, "startHost", "(Landroid/content/Context;)Z", 0x0009, false);
        requireMethod(classes, BACKEND, "getActiveHost",
                "()L" + BACKEND + "$VpnService;", 0x0009, false);
        requireMethod(classes, BACKEND, "stopHost", "()V", 0x0009, false);
        requireMethod(classes, BACKEND, "wgSetConfig", "(ILjava/lang/String;)I", 0x010A, false);
        requireMethod(classes, BACKEND + "$ForegroundNotificationFactory", "create",
                "(Landroid/content/Context;)Landroid/app/Notification;", 0x0401, true);
        for (String method : new String[]{"onSystemStart", "onHostRevoked", "onHostDestroyed"}) {
            requireMethod(classes, BACKEND + "$HostLifecycleListener", method, "()V", 0x0401, true);
        }
        requireMethod(classes, BACKEND + "$VpnService", "getBuilder",
                "()Landroid/net/VpnService$Builder;", 0x0001, false);
        requireMethod(classes, BACKEND + "$VpnService", "refreshForegroundNotification", "()V", 0x0009, false);
        // The Java/native pair is mandatory on every packaged ABI: an older
        // native library would fail only when peers are installed on a device.
        try (ZipFile archive = new ZipFile(aar.toFile())) {
            for (String abi : new String[]{"arm64-v8a", "armeabi-v7a", "x86", "x86_64"}) {
                var library = archive.getEntry("jni/" + abi + "/libwg-go.so");
                if (library == null) throw apiFailure("protected-start native library missing: " + abi);
                byte[] bytes;
                try (var stream = archive.getInputStream(library)) { bytes = stream.readAllBytes(); }
                String binary = new String(bytes, StandardCharsets.ISO_8859_1);
                if (bytes.length < 4 || bytes[0] != 0x7F || bytes[1] != 'E' || bytes[2] != 'L' || bytes[3] != 'F'
                        || !binary.contains(PROTECTED_START_SYMBOL)) {
                    throw apiFailure("protected-start JNI missing: " + abi);
                }
                if (!binary.contains(UAPI_SOCKET_DIRECTORY)) {
                    throw apiFailure("application UAPI socket directory missing: " + abi);
                }
            }
        }
    }

    private static void requireMethod(Map<String, byte[]> classes, String name, String method,
            String descriptor, int requiredFlags, boolean requireInterface) throws IOException {
        byte[] bytes = classes.get(name + ".class");
        if (bytes == null) throw apiFailure(name + " missing");
        try (DataInputStream input = new DataInputStream(new ByteArrayInputStream(bytes))) {
            if (input.readInt() != 0xCAFEBABE) throw apiFailure("invalid class " + name);
            input.skipNBytes(4); // minor / major version
            String[] utf8 = new String[input.readUnsignedShort()];
            for (int i = 1; i < utf8.length; i++) {
                int tag = input.readUnsignedByte();
                switch (tag) {
                    case 1 -> utf8[i] = input.readUTF();
                    case 3, 4, 9, 10, 11, 12, 17, 18 -> input.skipNBytes(4);
                    case 5, 6 -> { input.skipNBytes(8); i++; }
                    case 7, 8, 16, 19, 20 -> input.skipNBytes(2);
                    case 15 -> input.skipNBytes(3);
                    default -> throw apiFailure("unknown class constant " + tag);
                }
            }
            int classFlags = input.readUnsignedShort();
            if ((classFlags & 0x0001) == 0 || (requireInterface && (classFlags & 0x0200) == 0)) {
                throw apiFailure("inaccessible class/interface " + name);
            }
            input.skipNBytes(4); // this / super
            input.skipNBytes(2L * input.readUnsignedShort()); // interfaces
            int fields = input.readUnsignedShort();
            for (int i = 0; i < fields; i++) {
                input.skipNBytes(6);
                skipAttributes(input);
            }
            int methods = input.readUnsignedShort();
            for (int i = 0; i < methods; i++) {
                int flags = input.readUnsignedShort();
                String methodName = utf8[input.readUnsignedShort()];
                String methodDescriptor = utf8[input.readUnsignedShort()];
                skipAttributes(input);
                if (method.equals(methodName) && descriptor.equals(methodDescriptor)
                        && (flags & requiredFlags) == requiredFlags) return;
            }
        }
        throw apiFailure(name + "." + method + descriptor + " missing or incompatible");
    }

    private static void skipAttributes(DataInputStream input) throws IOException {
        int count = input.readUnsignedShort();
        for (int i = 0; i < count; i++) {
            input.skipNBytes(2);
            input.skipNBytes(Integer.toUnsignedLong(input.readInt()));
        }
    }

    private static IllegalStateException apiFailure(String detail) {
        return new IllegalStateException("WG_AAR_API: " + detail);
    }
}
