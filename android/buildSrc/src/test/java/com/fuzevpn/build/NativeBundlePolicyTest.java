package com.fuzevpn.build;

import java.nio.file.Files;
import java.nio.file.Path;

/** JDK-only positive/negative checks; mutations are confined to temporary fixtures. */
public final class NativeBundlePolicyTest {
    private static int passed;

    public static void main(String[] args) throws Exception {
        Path temporary = Files.createTempDirectory("fuzevpn-native-integrity-");
        Path root = Files.createDirectories(temporary.resolve("bundle"));
        Path file = root.resolve("lib.a");
        Files.writeString(file, "reviewed archive");
        Path manifest = temporary.resolve("bundle.sha256");
        Files.writeString(manifest, NativeBundlePolicy.sha256(file) + "  lib.a\n");
        String trusted = NativeBundlePolicy.sha256(manifest);
        accepts("valid fixture", () -> NativeBundlePolicy.verifyAgainst(root, manifest, trusted, ""));
        Files.writeString(file, "changed archive");
        rejects("changed archive after a successful warm verification", "NATIVE_FILE_HASH",
                () -> NativeBundlePolicy.verifyAgainst(root, manifest, trusted, ""));
        Files.delete(file);
        rejects("missing archive", "NATIVE_FILE_MISSING",
                () -> NativeBundlePolicy.verifyAgainst(root, manifest, trusted, ""));
        Files.writeString(file, "reviewed archive");
        Path extra = Files.writeString(root.resolve("unexpected.h"), "unreviewed header");
        rejects("unexpected compile input", "NATIVE_FILE_UNEXPECTED",
                () -> NativeBundlePolicy.verifyAgainst(root, manifest, trusted, ""));
        Files.delete(extra);
        Files.writeString(manifest, NativeBundlePolicy.sha256(file) + "  lib.a\n\n");
        rejects("changed manifest cannot bless input changes", "NATIVE_MANIFEST_HASH",
                () -> NativeBundlePolicy.verifyAgainst(root, manifest, trusted, ""));
        for (String relative : new String[]{"../outside.a", "/outside.a", "C:/outside.a", "sub/../../outside.a",
                "sub\\outside.a", "sub//outside.a", "sub/./outside.a", "lib.a ", "lib.a."}) {
            Files.writeString(manifest, NativeBundlePolicy.sha256(file) + "  " + relative + "\n");
            String hash = NativeBundlePolicy.sha256(manifest);
            rejects("unsafe path " + relative, "NATIVE_PATH",
                    () -> NativeBundlePolicy.verifyAgainst(root, manifest, hash, ""));
        }
        Files.writeString(manifest, NativeBundlePolicy.sha256(file) + "  lib.a\n" + NativeBundlePolicy.sha256(file) + "  LIB.A\n");
        String duplicate = NativeBundlePolicy.sha256(manifest);
        rejects("duplicate including case aliases", "NATIVE_DUPLICATE",
                () -> NativeBundlePolicy.verifyAgainst(root, manifest, duplicate, ""));
        Files.writeString(manifest, "invalid line\n");
        String malformed = NativeBundlePolicy.sha256(manifest);
        rejects("malformed manifest", "NATIVE_MANIFEST_FORMAT",
                () -> NativeBundlePolicy.verifyAgainst(root, manifest, malformed, ""));
        rejects("missing manifest", "NATIVE_MANIFEST_MISSING",
                () -> NativeBundlePolicy.verifyAgainst(root, temporary.resolve("absent.sha256"), trusted, ""));
        Files.writeString(manifest, NativeBundlePolicy.sha256(file) + "  lib.a\n");
        try {
            Path link = root.resolve("link.a");
            Files.createSymbolicLink(link, file);
            Files.writeString(manifest, NativeBundlePolicy.sha256(file) + "  lib.a\n" + NativeBundlePolicy.sha256(file) + "  link.a\n");
            String linked = NativeBundlePolicy.sha256(manifest);
            rejects("symlink cannot substitute a native input", "NATIVE_LINK",
                    () -> NativeBundlePolicy.verifyAgainst(root, manifest, linked, ""));
        } catch (java.nio.file.FileSystemException | UnsupportedOperationException denied) {
            System.out.println("SKIP: symlink creation unavailable on this host: " + denied.getClass().getSimpleName());
        }
        if (args.length == 2) {
            accepts("all reviewed native inputs", () -> NativeBundlePolicy.verify(Path.of(args[0]), Path.of(args[1])));
            accepts("OpenSSL import component", () -> NativeBundlePolicy.verifyComponent(Path.of(args[0]).resolve("openssl"), Path.of(args[1]), "openssl"));
            accepts("deps import component", () -> NativeBundlePolicy.verifyComponent(Path.of(args[0]).resolve("deps"), Path.of(args[1]), "deps"));
        }
        System.out.println("NativeBundlePolicy: " + passed + " checks passed; fixtures: " + temporary);
    }

    private static void accepts(String label, Runnable run) {
        run.run();
        passed++;
        System.out.println("PASS: " + label);
    }

    private static void rejects(String label, String code, Runnable run) {
        try { run.run(); } catch (IllegalStateException expected) {
            if (!expected.getMessage().startsWith(code + ":")) throw expected;
            passed++;
            System.out.println("PASS: " + label);
            return;
        }
        throw new AssertionError("Accepted invalid fixture: " + label);
    }
}
