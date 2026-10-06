package com.fuzevpn.android

import android.content.Context
import android.content.res.Configuration
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.Assert.assertEquals
import org.junit.Test
import org.junit.runner.RunWith
import java.util.Locale

@RunWith(AndroidJUnit4::class)
class VpnNotificationLocalizationInstrumentedTest {
    @Test
    fun notificationResourcesCoverTheFourSupportedLanguages() {
        assertEquals("Connexion VPN", localized("fr").getString(R.string.vpn_notification_channel))
        assertEquals("VPN connection", localized("en").getString(R.string.vpn_notification_channel))
        assertEquals("Conexión VPN", localized("es").getString(R.string.vpn_notification_channel))
        assertEquals("VPN-Verbindung", localized("de").getString(R.string.vpn_notification_channel))
        assertEquals("Prêt · WireGuard · Frankfurt 01", localized("fr").getString(R.string.vpn_tile_ready, "WireGuard", "Frankfurt 01"))
        assertEquals("Ready · WireGuard · Frankfurt 01", localized("en").getString(R.string.vpn_tile_ready, "WireGuard", "Frankfurt 01"))
        assertEquals("Listo · WireGuard · Frankfurt 01", localized("es").getString(R.string.vpn_tile_ready, "WireGuard", "Frankfurt 01"))
        assertEquals("Bereit · WireGuard · Frankfurt 01", localized("de").getString(R.string.vpn_tile_ready, "WireGuard", "Frankfurt 01"))
    }

    private fun localized(language: String): Context {
        val app = ApplicationProvider.getApplicationContext<Context>()
        val configuration = Configuration(app.resources.configuration)
        configuration.setLocale(Locale.forLanguageTag(language))
        return app.createConfigurationContext(configuration)
    }
}
