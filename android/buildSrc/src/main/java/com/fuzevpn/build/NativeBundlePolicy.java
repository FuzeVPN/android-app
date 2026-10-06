package com.fuzevpn.build;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.LinkOption;
import java.nio.file.Path;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.HexFormat;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

/** One offline integrity policy shared by Gradle, CMake and the native importer. */
public final class NativeBundlePolicy {
    // This locks the reviewed source, archives, headers AND their provenance records.
    // It is deliberately not obtained from the mutable imported bundle.
    public static final String APPROVED_MANIFEST_SHA256 =
            "d225d522ad87e0db9f548c91d040f03d3866ed59697bada3d148656e3d0ad1c8";
    private static final Pattern LINE = Pattern.compile("([a-f0-9]{64})  (.+)");

    private NativeBundlePolicy() {}

    public static void verify(Path root, Path manifest) {
        verifyAgainst(root, manifest, APPROVED_MANIFEST_SHA256, "");
    }

    public static void verifyComponent(Path root, Path manifest, String component) {
        if (!Set.of("openssl", "deps", "openvpn3-core").contains(component)) {
            throw failure("NATIVE_COMPONENT", component);
        }
        verifyAgainst(root, manifest, APPROVED_MANIFEST_SHA256, component + "/");
    }

    static void verifyAgainst(Path root, Path manifest, String expectedManifestHash, String prefix) {
        try {
            if (!Files.isRegularFile(manifest, LinkOption.NOFOLLOW_LINKS)) {
                throw failure("NATIVE_MANIFEST_MISSING", manifest.toString());
            }
            if (!sha256(manifest).equals(expectedManifestHash)) {
                throw failure("NATIVE_MANIFEST_HASH", manifest.toString());
            }
            Path base = root.toAbsolutePath().normalize();
            if (!Files.isDirectory(base, LinkOption.NOFOLLOW_LINKS)) {
                throw failure("NATIVE_ROOT_MISSING", base.toString());
            }
            if (!base.toRealPath().equals(base)) throw failure("NATIVE_LINK", base.toString());
            Map<String, String> expected = new HashMap<>();
            Set<String> allNames = new HashSet<>();
            for (String line : Files.readAllLines(manifest, StandardCharsets.UTF_8)) {
                var match = LINE.matcher(line);
                if (!match.matches()) throw failure("NATIVE_MANIFEST_FORMAT", line);
                String relative = match.group(2);
                requireRelativePath(relative);
                if (!allNames.add(relative.toLowerCase(Locale.ROOT))) {
                    throw failure("NATIVE_DUPLICATE", relative);
                }
                if (relative.startsWith(prefix)) {
                    String selected = relative.substring(prefix.length());
                    requireRelativePath(selected);
                    expected.put(selected, match.group(1));
                }
            }
            if (expected.isEmpty()) throw failure("NATIVE_MANIFEST_EMPTY", prefix);
            // Check every expected entry before traversing actual files. No links or
            // path escapes may turn a manifest entry into a read outside the prefix.
            for (var entry : expected.entrySet()) {
                Path target = base.resolve(entry.getKey()).normalize();
                if (!target.startsWith(base)) throw failure("NATIVE_PATH", entry.getKey());
                Path parent = target;
                while (!parent.equals(base)) {
                    if (Files.isSymbolicLink(parent) ||
                            (Files.exists(parent, LinkOption.NOFOLLOW_LINKS) && !parent.toRealPath().equals(parent))) {
                        throw failure("NATIVE_LINK", entry.getKey());
                    }
                    parent = parent.getParent();
                }
                if (!Files.isRegularFile(target, LinkOption.NOFOLLOW_LINKS)) {
                    throw failure("NATIVE_FILE_MISSING", entry.getKey());
                }
                if (!sha256(target).equals(entry.getValue())) {
                    throw failure("NATIVE_FILE_HASH", entry.getKey());
                }
            }
            // Unexpected headers, source files or archives are also rejected; adding
            // a file must not silently change compilation without a reviewed lock.
            try (var paths = Files.walk(base)) {
                for (Path file : paths.toList()) {
                    if (!file.toRealPath().equals(file) || Files.isSymbolicLink(file)) {
                        throw failure("NATIVE_LINK", file.toString());
                    }
                    if (Files.isDirectory(file, LinkOption.NOFOLLOW_LINKS)) continue;
                    String relative = base.relativize(file).toString().replace('\\', '/');
                    if (!Files.isRegularFile(file, LinkOption.NOFOLLOW_LINKS) || !expected.containsKey(relative)) {
                        throw failure("NATIVE_FILE_UNEXPECTED", relative);
                    }
                }
            }
        } catch (IOException error) {
            throw new IllegalStateException("NATIVE_BUNDLE_UNREADABLE: " + root, error);
        }
    }

    private static void requireRelativePath(String relative) {
        if (relative.isEmpty() || relative.startsWith("/") || relative.contains("\\") ||
                relative.contains(":") || relative.chars().anyMatch(c -> c < 32 || c == 127)) {
            throw failure("NATIVE_PATH", relative);
        }
        for (String segment : relative.split("/", -1)) {
            if (segment.isEmpty() || segment.equals(".") || segment.equals("..") ||
                    segment.endsWith(".") || segment.endsWith(" ")) throw failure("NATIVE_PATH", relative);
        }
    }

    static String sha256(Path path) throws IOException {
        try {
            var digest = MessageDigest.getInstance("SHA-256");
            try (var input = Files.newInputStream(path)) {
                byte[] buffer = new byte[65536];
                for (int count; (count = input.read(buffer)) != -1;) digest.update(buffer, 0, count);
            }
            return HexFormat.of().formatHex(digest.digest());
        } catch (NoSuchAlgorithmException error) {
            throw new AssertionError(error);
        }
    }

    private static IllegalStateException failure(String code, String detail) {
        return new IllegalStateException(code + ": " + detail);
    }

    // Java source-file launching lets offline PowerShell/CMake reuse this policy
    // without building Gradle or maintaining a second verifier implementation.
    public static void main(String[] args) {
        if (args.length == 3 && args[0].equals("bundle")) {
            verify(Path.of(args[1]), Path.of(args[2]));
        } else if (args.length == 4 && args[0].equals("component")) {
            verifyComponent(Path.of(args[1]), Path.of(args[2]), args[3]);
        } else {
            throw new IllegalArgumentException("bundle ROOT MANIFEST | component ROOT MANIFEST COMPONENT");
        }
        System.out.println("Native bundle integrity verified.");
    }
}
