package com.fuzevpn.build;

import java.nio.file.Files;
import java.nio.file.Path;

public final class AndroidManifestPolicyTest {
    public static void main(String[] args) throws Exception {
        Path manifest = Files.createTempFile("fuzevpn-merged-manifest-", ".xml");
        String start = "<manifest xmlns:android=\"http://schemas.android.com/apk/res/android\">";
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
        System.out.println("AndroidManifestPolicy: " + passed + " checks passed.");
    }
}
