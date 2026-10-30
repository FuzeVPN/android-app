package com.fuzevpn.build;

import java.nio.file.Files;
import java.nio.file.Path;

public final class AndroidManifestPolicyTest {
    public static void main(String[] args) throws Exception {
        Path manifest = Files.createTempFile("fuzevpn-merged-manifest-", ".xml");
        String start = "<manifest xmlns:android=\"http://schemas.android.com/apk/res/android\" package=\"com.fuzevpn\">";
        Files.writeString(manifest, start + "<uses-permission android:name=\"android.permission.INTERNET\"/></manifest>");
        AndroidManifestPolicy.verify(manifest);
        int passed = 1;
        for (String tag : new String[]{"uses-permission", "uses-permission-sdk-23"}) {
            Files.writeString(manifest, start + "<" + tag
                    + " android:name=\"com.android.vending.BILLING\"/></manifest>");
            AndroidManifestPolicy.verify(manifest);
            passed++;
            Files.writeString(manifest, start + "<" + tag
                    + " android:name=\"com.fuzevpn.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION\"/></manifest>");
            AndroidManifestPolicy.verify(manifest);
            passed++;
            Files.writeString(manifest, start + "<" + tag
                    + " android:name=\"com.fuzevpn.android.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION\"/></manifest>");
            boolean previousPermissionRejected = false;
            try { AndroidManifestPolicy.verify(manifest); }
            catch (IllegalStateException expected) {
                if (!expected.getMessage().startsWith("ANDROID_PERMISSION_UNREVIEWED:")) throw expected;
                previousPermissionRejected = true;
            }
            if (!previousPermissionRejected) {
                throw new AssertionError("Previous application ID permission accepted");
            }
            passed++;
            for (String permission : new String[]{"READ_PHONE_STATE", "READ_EXTERNAL_STORAGE", "WRITE_EXTERNAL_STORAGE", "READ_CONTACTS"}) {
                Files.writeString(manifest, start + "<" + tag + " android:name=\"android.permission." + permission + "\"/></manifest>");
                try { AndroidManifestPolicy.verify(manifest); }
                catch (IllegalStateException expected) {
                    if (!expected.getMessage().startsWith("ANDROID_PERMISSION_UNREVIEWED:")) throw expected;
                    passed++;
                    continue;
                }
                throw new AssertionError("Unexpected permission accepted: " + permission);
            }
        }
        for (String expected : new String[]{"com.fuzevpn", "com.fuzevpn.recoverytest"}) {
            for (String declared : new String[]{"com.fuzevpn", "com.fuzevpn.recoverytest", "com.fuzevpn.unreviewed"}) {
                for (String permissionOwner : new String[]{"com.fuzevpn", "com.fuzevpn.recoverytest"}) {
                    Files.writeString(manifest, start.replace("package=\"com.fuzevpn\"", "package=\"" + declared + "\"")
                            + "<uses-permission android:name=\"" + permissionOwner + ".DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION\"/></manifest>");
                    boolean shouldPass = expected.equals(declared) && expected.equals(permissionOwner);
                    try {
                        AndroidManifestPolicy.verify(manifest, expected);
                        if (!shouldPass) throw new AssertionError("Cross-package manifest/permission accepted");
                    } catch (IllegalStateException rejected) {
                        if (shouldPass) throw rejected;
                    }
                    passed++;
                }
            }
        }
        Files.writeString(manifest, start + "</manifest>");
        try {
            AndroidManifestPolicy.verify(manifest, "com.fuzevpn.unreviewed");
            throw new AssertionError("Unreviewed expected package accepted");
        } catch (IllegalStateException expected) {
            if (!expected.getMessage().startsWith("ANDROID_APPLICATION_ID_UNREVIEWED:")) throw expected;
            passed++;
        }
        System.out.println("AndroidManifestPolicy: " + passed + " checks passed.");
    }
}
