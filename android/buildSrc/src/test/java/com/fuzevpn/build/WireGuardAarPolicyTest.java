package com.fuzevpn.build;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/** Executable JDK-only regression tests: no repository/network dependency. */
public final class WireGuardAarPolicyTest {
    private static int passed;
    private static final String BACKEND = "com/wireguard/android/backend/GoBackend";

    public static void main(String[] args) throws Exception {
        Path approved = Path.of(args[0]);
        Path temporary = Files.createTempDirectory("wireguard-policy-");
        try {
            Path missing = temporary.resolve("missing.aar");
            accepts("debug fallback does not require a local AAR",
                    () -> WireGuardAarPolicy.verify("debug", false, missing));
            for (String type : new String[]{"release", "profile", "staging"}) {
                rejects(type + " rejects absent/false opt-in", "WG_PATCH_REQUIRED",
                        () -> WireGuardAarPolicy.verify(type, false, approved));
            }
            for (String type : new String[]{"debug", "release", "profile", "staging"}) {
                accepts(type + " accepts the approved AAR", () -> WireGuardAarPolicy.verify(type, true, approved));
                rejects(type + " rejects a missing AAR", "WG_AAR_MISSING",
                        () -> WireGuardAarPolicy.verify(type, true, missing));
            }
            Path changed = temporary.resolve("changed.aar");
            byte[] bytes = Files.readAllBytes(approved);
            bytes[bytes.length - 1] ^= 1;
            Files.write(changed, bytes);
            rejects("a modified artifact is rejected", "WG_AAR_HASH",
                    () -> WireGuardAarPolicy.verify("release", true, changed));
            accepts("the approved API is compatible", () -> WireGuardAarPolicy.verifyApi(approved));
            Path compatible = fixture(temporary, "compatible", true, true, "()V", 0x0109, true);
            accepts("API descriptors and visibility are recognized", () -> WireGuardAarPolicy.verifyApi(compatible));
            Path noNative = fixture(temporary, "no-native", true, true, "()V", 0x0109, true, true, false);
            rejects("native protected-start contract is required on every ABI", "WG_AAR_API",
                    () -> WireGuardAarPolicy.verifyApi(noNative));
            Path previousPackage = fixture(temporary, "previous-package", true, true, "()V", 0x0109,
                    true, true, true, "/data/data/com.fuzevpn.android/cache/wireguard");
            rejects("native IPC must use the installed application ID", "WG_AAR_API",
                    () -> WireGuardAarPolicy.verifyApi(previousPackage));
            rejects("compatible API alone cannot bypass the digest pin", "WG_AAR_HASH",
                    () -> WireGuardAarPolicy.verify("release", true, compatible));
            Path noJar = fixture(temporary, "no-jar", false, true, "()V", 0x0109, true);
            rejects("classes.jar is required", "WG_AAR_API", () -> WireGuardAarPolicy.verifyApi(noJar));
            Path noFactory = fixture(temporary, "no-factory", true, false, "()V", 0x0109, true);
            rejects("the notification factory is required", "WG_AAR_API", () -> WireGuardAarPolicy.verifyApi(noFactory));
            Path noHost = fixture(temporary, "no-host", true, true, "()V", 0x0109, true, false);
            rejects("the shared VPN host API is required", "WG_AAR_API", () -> WireGuardAarPolicy.verifyApi(noHost));
            Path wrongReturn = fixture(temporary, "wrong-return", true, true, "()I", 0x0109, true);
            rejects("method return types are checked", "WG_AAR_API", () -> WireGuardAarPolicy.verifyApi(wrongReturn));
            Path noStatic = fixture(temporary, "no-static", true, true, "()V", 0x0101, true);
            rejects("refresh must be static", "WG_AAR_API", () -> WireGuardAarPolicy.verifyApi(noStatic));
            Path noPublic = fixture(temporary, "no-public", true, true, "()V", 0x0108, true);
            rejects("refresh must be public", "WG_AAR_API", () -> WireGuardAarPolicy.verifyApi(noPublic));
            Path noInterface = fixture(temporary, "no-interface", true, true, "()V", 0x0109, false);
            rejects("the factory must be an interface", "WG_AAR_API", () -> WireGuardAarPolicy.verifyApi(noInterface));
            // Verification has no remembered result: changing the file after success must fail.
            Files.copy(approved, changed, java.nio.file.StandardCopyOption.REPLACE_EXISTING);
            accepts("a fresh valid file is accepted", () -> WireGuardAarPolicy.verify("release", true, changed));
            Files.writeString(changed, "replaced after verification");
            rejects("verification re-reads the file", "WG_AAR_HASH",
                    () -> WireGuardAarPolicy.verify("release", true, changed));
            System.out.println("WireGuard AAR policy: " + passed + " tests passed");
        } finally {
            try (var paths = Files.walk(temporary)) {
                for (Path path : paths.sorted(java.util.Comparator.reverseOrder()).toList()) Files.delete(path);
            }
        }
    }

    private static Path fixture(Path directory, String name, boolean includeJar, boolean includeFactory,
            String refreshDescriptor, int refreshFlags, boolean factoryInterface) throws Exception {
        return fixture(directory, name, includeJar, includeFactory, refreshDescriptor, refreshFlags,
                factoryInterface, true);
    }

    private static Path fixture(Path directory, String name, boolean includeJar, boolean includeFactory,
            String refreshDescriptor, int refreshFlags, boolean factoryInterface, boolean includeHost) throws Exception {
        return fixture(directory, name, includeJar, includeFactory, refreshDescriptor, refreshFlags,
                factoryInterface, includeHost, true);
    }

    private static Path fixture(Path directory, String name, boolean includeJar, boolean includeFactory,
            String refreshDescriptor, int refreshFlags, boolean factoryInterface, boolean includeHost,
            boolean includeNative) throws Exception {
        return fixture(directory, name, includeJar, includeFactory, refreshDescriptor, refreshFlags,
                factoryInterface, includeHost, includeNative, "/data/data/com.fuzevpn/cache/wireguard");
    }

    private static Path fixture(Path directory, String name, boolean includeJar, boolean includeFactory,
            String refreshDescriptor, int refreshFlags, boolean factoryInterface, boolean includeHost,
            boolean includeNative, String socketDirectory) throws Exception {
        Path path = directory.resolve(name + ".aar");
        try (ZipOutputStream aar = new ZipOutputStream(Files.newOutputStream(path))) {
            if (includeJar) {
                ByteArrayOutputStream jarBytes = new ByteArrayOutputStream();
                try (ZipOutputStream jar = new ZipOutputStream(jarBytes)) {
                    addClass(jar, BACKEND, false,
                            includeHost
                                    ? new String[]{"setForegroundNotificationFactory", "setHostLifecycleListener", "startHost", "getActiveHost", "stopHost", "wgSetConfig"}
                                    : new String[]{"setForegroundNotificationFactory"},
                            includeHost
                                    ? new String[]{"(L" + BACKEND + "$ForegroundNotificationFactory;)V", "(L" + BACKEND + "$HostLifecycleListener;)V", "(Landroid/content/Context;)Z", "()L" + BACKEND + "$VpnService;", "()V", "(ILjava/lang/String;)I"}
                                    : new String[]{"(L" + BACKEND + "$ForegroundNotificationFactory;)V"},
                            includeHost ? new int[]{0x0109, 0x0109, 0x0109, 0x0109, 0x0109, 0x010A} : new int[]{0x0109});
                    addClass(jar, BACKEND + "$VpnService", false,
                            new String[]{"refreshForegroundNotification", "getBuilder"},
                            new String[]{refreshDescriptor, "()Landroid/net/VpnService$Builder;"},
                            new int[]{refreshFlags, 0x0101});
                    if (includeHost) addClass(jar, BACKEND + "$HostLifecycleListener", true,
                            new String[]{"onSystemStart", "onHostRevoked", "onHostDestroyed"},
                            new String[]{"()V", "()V", "()V"}, new int[]{0x0401, 0x0401, 0x0401});
                    if (includeFactory) addClass(jar, BACKEND + "$ForegroundNotificationFactory", factoryInterface,
                            new String[]{"create"}, new String[]{"(Landroid/content/Context;)Landroid/app/Notification;"},
                            new int[]{0x0401});
                }
                aar.putNextEntry(new ZipEntry("classes.jar"));
                aar.write(jarBytes.toByteArray());
                aar.closeEntry();
            }
            if (includeNative) {
                for (String abi : new String[]{"arm64-v8a", "armeabi-v7a", "x86", "x86_64"}) {
                    aar.putNextEntry(new ZipEntry("jni/" + abi + "/libwg-go.so"));
                    aar.write("\u007FELFJava_com_wireguard_android_backend_GoBackend_wgSetConfig"
                            .getBytes(java.nio.charset.StandardCharsets.ISO_8859_1));
                    aar.write(socketDirectory.getBytes(java.nio.charset.StandardCharsets.ISO_8859_1));
                    aar.closeEntry();
                }
            }
        }
        return path;
    }

    private static void addClass(ZipOutputStream jar, String name, boolean isInterface,
            String[] methods, String[] descriptors, int[] methodFlags) throws Exception {
        ByteArrayOutputStream bytes = new ByteArrayOutputStream();
        DataOutputStream out = new DataOutputStream(bytes);
        out.writeInt(0xCAFEBABE);
        out.writeShort(0); out.writeShort(61); out.writeShort(5 + methods.length * 2);
        out.writeByte(1); out.writeUTF(name);
        out.writeByte(7); out.writeShort(1);
        out.writeByte(1); out.writeUTF("java/lang/Object");
        out.writeByte(7); out.writeShort(3);
        for (int i = 0; i < methods.length; i++) {
            out.writeByte(1); out.writeUTF(methods[i]);
            out.writeByte(1); out.writeUTF(descriptors[i]);
        }
        out.writeShort(isInterface ? 0x0601 : 0x0021);
        out.writeShort(2); out.writeShort(4);
        out.writeShort(0); out.writeShort(0); out.writeShort(methods.length);
        for (int i = 0; i < methods.length; i++) {
            out.writeShort(methodFlags[i]); out.writeShort(5 + i * 2); out.writeShort(6 + i * 2);
            out.writeShort(0);
        }
        jar.putNextEntry(new ZipEntry(name + ".class"));
        jar.write(bytes.toByteArray());
        jar.closeEntry();
    }

    private static void accepts(String name, Checked action) throws Exception {
        action.run();
        System.out.println("PASS " + name);
        passed++;
    }

    private static void rejects(String name, String code, Checked action) throws Exception {
        try {
            action.run();
        } catch (IllegalStateException expected) {
            if (!expected.getMessage().startsWith(code + ":")) throw expected;
            System.out.println("PASS " + name);
            passed++;
            return;
        }
        throw new AssertionError(name + " should fail with " + code);
    }

    @FunctionalInterface private interface Checked { void run() throws Exception; }
}
