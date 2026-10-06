package com.fuzevpn.android

import com.wireguard.config.Config
import com.wireguard.config.InetNetwork
import com.wireguard.crypto.Key
import com.wireguard.crypto.KeyPair
import org.junit.Assert.*
import org.junit.Test
import java.lang.reflect.InvocationTargetException

/**
 * Executes the production configuration writer and WireGuard AAR parser.
 * These are configuration tests: they do not simulate a successful handshake
 * or claim to verify Android socket protection, TUN setup, or a remote peer.
 */
class WireGuardConfigurationTest {
    private val client = KeyPair(Key.fromBytes(ByteArray(32) { (it + 1).toByte() }))
    private val server = KeyPair(Key.fromBytes(ByteArray(32) { (it + 65).toByte() }))
    private val address4 = "10.10.0.6/32"
    private val address6 = "fd0d:295d:995b:1::11/128"
    private val endpoint = "198.51.100.1:51820"
    private val dns = listOf("1.1.1.1", "1.0.0.1")

    @Test fun ipv4ConfigurationUsesTheRealParserAndPreservesTransportIdentity() {
        val config = configuration(request())

        assertEquals(setOf(InetNetwork.parse(address4)), config.`interface`.addresses)
        assertEquals(dns.toSet(), config.`interface`.dnsServers.map { it.hostAddress }.toSet())
        assertEquals(client.publicKey, config.`interface`.keyPair.publicKey)
        assertEquals(1, config.peers.size)
        val peer = config.peers.single()
        assertEquals(server.publicKey, peer.publicKey)
        assertEquals(setOf(InetNetwork.parse("0.0.0.0/0")), peer.allowedIps)
        assertEquals(endpoint, peer.endpoint.get().toString())
        assertEquals(peer.endpoint.get(), peer.endpoint.get().resolved.get())
        assertEquals(25, peer.persistentKeepalive.get())
        assertTrue(config.`interface`.excludedApplications.isEmpty())
        assertTrue(config.`interface`.includedApplications.isEmpty())
    }

    @Test fun dualStackConfigurationContainsBothAddressesAndDefaultRoutes() {
        val config = configuration(request(address6))

        assertEquals(
            setOf(InetNetwork.parse(address4), InetNetwork.parse(address6)),
            config.`interface`.addresses,
        )
        assertEquals(
            setOf(InetNetwork.parse("0.0.0.0/0"), InetNetwork.parse("::/0")),
            config.peers.single().allowedIps,
        )
        assertEquals(dns.toSet(), config.`interface`.dnsServers.map { it.hostAddress }.toSet())
        assertEquals(endpoint, config.peers.single().endpoint.get().toString())
        assertEquals(client.publicKey, config.`interface`.keyPair.publicKey)
        assertEquals(server.publicKey, config.peers.single().publicKey)
        assertEquals(25, config.peers.single().persistentKeepalive.get())
    }

    @Test fun changingOnlyInnerIpv6DoesNotChangeUserspaceHandshakeConfiguration() {
        val matchingAddress = configuration(request(address6))
        val otherNodeAddress = configuration(request("fd0d:295d:995b:3::11/128"))

        assertNotEquals(matchingAddress.`interface`.addresses, otherNodeAddress.`interface`.addresses)
        // Inner addresses are applied to Android's TUN. They are not inputs
        // to the WireGuard handshake protocol or peer transport endpoint.
        assertEquals(matchingAddress.peers, otherNodeAddress.peers)
        assertEquals(matchingAddress.toWgUserspaceString(), otherNodeAddress.toWgUserspaceString())
    }

    @Test fun optingIntoIpv6AddsOnlyTheIpv6RouteToUserspaceSettings() {
        val ipv4 = configuration(request()).toWgUserspaceString().lineSequence().toList()
        val dual = configuration(request(address6)).toWgUserspaceString().lineSequence().toList()
        val ipv6Route = "allowed_ip=${InetNetwork.parse("::/0")}"

        assertEquals(1, dual.count { it == ipv6Route })
        assertEquals(ipv4, dual.filterNot { it == ipv6Route })
    }

    @Test fun partialDualStackAndConflictingRequestRoutesAreRejectedBeforeParsing() {
        val complete = networkValues(address6)
        for (missing in listOf("addresses", "ip_families", "allowed_ips")) {
            assertThrows(IllegalArgumentException::class.java) {
                TunnelNetworkSpec.from(complete.filterKeys { it != missing })
            }
        }
        assertThrows(IllegalArgumentException::class.java) {
            TunnelNetworkSpec.from(complete + ("addresses" to listOf(address4)))
        }
        assertThrows(IllegalArgumentException::class.java) {
            TunnelNetworkSpec.from(complete + ("allowed_ips" to listOf("0.0.0.0/0")))
        }
        assertThrows(IllegalArgumentException::class.java) {
            request(address6).copy(allowedIps = listOf("0.0.0.0/0"))
        }
        assertThrows(IllegalArgumentException::class.java) {
            request(address6).copy(endpoint = "[2001:db8::1]:51820")
        }
    }

    @Test fun productionWriterRejectsAnInjectedPeerDirective() {
        val failure = assertThrows(VpnNativeException::class.java) {
            configuration(request(address6).copy(serverPublicKey = "${server.publicKey.toBase64()}\nEndpoint = 198.51.100.2:51820"))
        }
        assertEquals("wireguard_configuration_invalid", failure.code)
    }

    private fun networkValues(ipv6: String) = mapOf<String, Any?>(
        "address" to address4,
        "addresses" to listOf(address4, ipv6),
        "ip_families" to listOf("ipv4", "ipv6"),
        "allowed_ips" to listOf("0.0.0.0/0", "::/0"),
    )

    private fun request(ipv6: String? = null): WireGuardRequest {
        val network = if (ipv6 == null) {
            TunnelNetworkSpec.ipv4(address4, listOf("0.0.0.0/0"))
        } else {
            TunnelNetworkSpec.from(networkValues(ipv6))
        }
        return WireGuardRequest(
            accountId = "configuration-test-account",
            deviceId = "configuration-test-device",
            locationId = "frankfurt-01",
            locationName = "Frankfurt 1",
            address = address4,
            dns = dns,
            serverPublicKey = server.publicKey.toBase64(),
            endpoint = endpoint,
            allowedIps = network.allowedIps,
            network = network,
        )
    }

    private fun configuration(request: WireGuardRequest): Config {
        // The private writer is pure but lives on a controller whose constructor
        // starts Android backend setup. Allocate only for this method so the test
        // executes production code without replacing it or loading native code.
        val unsafeClass = Class.forName("sun.misc.Unsafe")
        val unsafeField = unsafeClass.getDeclaredField("theUnsafe").apply { isAccessible = true }
        val controller = unsafeClass.getMethod("allocateInstance", Class::class.java)
            .invoke(unsafeField.get(null), WireGuardController::class.java)
        val writer = WireGuardController::class.java.getDeclaredMethod(
            "buildConfiguration", WireGuardRequest::class.java, String::class.java,
        ).apply { isAccessible = true }
        return try {
            writer.invoke(controller, request, client.privateKey.toBase64()) as Config
        } catch (error: InvocationTargetException) {
            throw error.targetException
        }
    }
}
