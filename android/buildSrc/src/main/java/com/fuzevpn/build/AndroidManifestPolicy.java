package com.fuzevpn.build;

import java.nio.file.Path;
import java.util.Set;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Element;

/** Checks the merged app manifest, including permissions inferred from library SDKs. */
public final class AndroidManifestPolicy {
    private static final String ANDROID = "http://schemas.android.com/apk/res/android";
    private static final Set<String> PERMISSIONS = Set.of(
            "android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE",
            "android.permission.FOREGROUND_SERVICE", "android.permission.FOREGROUND_SERVICE_SPECIAL_USE",
            "android.permission.POST_NOTIFICATIONS",
            "com.android.vending.BILLING",
            "com.fuzevpn.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION");

    private AndroidManifestPolicy() {}

    public static void verify(Path manifest) {
        try {
            var factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);
            factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
            factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD, "");
            factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_SCHEMA, "");
            var document = factory.newDocumentBuilder().parse(manifest.toFile());
            for (String tag : new String[]{"uses-permission", "uses-permission-sdk-23"}) {
                var permissions = document.getElementsByTagName(tag);
                for (int i = 0; i < permissions.getLength(); i++) {
                    String name = ((Element) permissions.item(i)).getAttributeNS(ANDROID, "name");
                    if (!PERMISSIONS.contains(name)) {
                        throw new IllegalStateException("ANDROID_PERMISSION_UNREVIEWED: " + name);
                    }
                }
            }
        } catch (IllegalStateException error) {
            throw error;
        } catch (Exception error) {
            throw new IllegalStateException("ANDROID_MANIFEST_UNREADABLE: " + manifest, error);
        }
    }
}
