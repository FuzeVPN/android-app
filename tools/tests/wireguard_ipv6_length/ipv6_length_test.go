// SPDX-License-Identifier: Apache-2.0

// Package wgipv6length checks A17-supply-chain-02 against the real
// golang.zx2c4.com/wireguard device package of the version pinned by
// android/third_party/wireguard-android/tunnel/tools/libwg-go/go.mod.
//
// Two in-process devices (bindtest channel binds, tuntest channel TUNs) run a
// real Noise handshake. dev1 sends IPv6 packets through the tunnel and dev0's
// RoutineSequentialReceiver validates them (device/receive.go). Before
// upstream b3bc704ef0ee the IPv6 total length was computed in a uint16, so a
// Payload Length of 0xFFFF or 0xFFD8 wrapped below the real packet size and
// the packet reached the TUN. tools/tests/test_wireguard_ipv6_length.py runs
// this test offline, from the reviewed source distribution only.
package wgipv6length

import (
	"bufio"
	"crypto/ecdh"
	"crypto/rand"
	"encoding/binary"
	"encoding/hex"
	"fmt"
	"net/netip"
	"strings"
	"testing"
	"time"

	"golang.zx2c4.com/wireguard/conn/bindtest"
	"golang.zx2c4.com/wireguard/device"
	"golang.zx2c4.com/wireguard/tun/tuntest"
)

var (
	addr0 = netip.MustParseAddr("fd00::1") // receiver (dev0)
	addr1 = netip.MustParseAddr("fd00::2") // sender (dev1)
)

type pair struct {
	tuns [2]*tuntest.ChannelTUN
	devs [2]*device.Device
}

func listenPort(t *testing.T, d *device.Device) string {
	t.Helper()
	cfg, err := d.IpcGet()
	if err != nil {
		t.Fatal(err)
	}
	s := bufio.NewScanner(strings.NewReader(cfg))
	for s.Scan() {
		if v, ok := strings.CutPrefix(s.Text(), "listen_port="); ok {
			return v
		}
	}
	t.Fatal("listen_port missing")
	return ""
}

func newPair(t *testing.T) *pair {
	t.Helper()
	var priv [2]*ecdh.PrivateKey
	for i := range priv {
		k, err := ecdh.X25519().GenerateKey(rand.Reader)
		if err != nil {
			t.Fatal(err)
		}
		priv[i] = k
	}
	allowed := [2]netip.Addr{addr1, addr0} // dev0 accepts fd00::2 from dev1, dev1 accepts fd00::1
	binds := bindtest.NewChannelBinds()
	p := &pair{}
	for i := 0; i < 2; i++ {
		p.tuns[i] = tuntest.NewChannelTUN()
		p.devs[i] = device.NewDevice(p.tuns[i].TUN(), binds[i], device.NewLogger(device.LogLevelError, fmt.Sprintf("dev%d: ", i)))
		cfg := fmt.Sprintf("private_key=%s\nlisten_port=0\nreplace_peers=true\npublic_key=%s\nprotocol_version=1\nreplace_allowed_ips=true\nallowed_ip=%s/128\n",
			hex.EncodeToString(priv[i].Bytes()), hex.EncodeToString(priv[i^1].PublicKey().Bytes()), allowed[i])
		if err := p.devs[i].IpcSet(cfg); err != nil {
			t.Fatal(err)
		}
		if err := p.devs[i].Up(); err != nil {
			t.Fatal(err)
		}
		t.Cleanup(p.devs[i].Close)
	}
	for i := 0; i < 2; i++ {
		other := listenPort(t, p.devs[i^1])
		cfg := fmt.Sprintf("public_key=%s\nendpoint=127.0.0.1:%s\n", hex.EncodeToString(priv[i^1].PublicKey().Bytes()), other)
		if err := p.devs[i].IpcSet(cfg); err != nil {
			t.Fatal(err)
		}
	}
	return p
}

// ipv6 builds a 48-byte IPv6 packet (40-byte header + 8 payload bytes) whose
// Payload Length field is declaredPayload; the real payload is always 8 bytes.
func ipv6(declaredPayload uint16) []byte {
	pkt := make([]byte, 48)
	pkt[0] = 6 << 4
	binary.BigEndian.PutUint16(pkt[4:6], declaredPayload)
	pkt[6] = 59 // No Next Header
	pkt[7] = 64
	copy(pkt[8:24], addr1.AsSlice())
	copy(pkt[24:40], addr0.AsSlice())
	copy(pkt[40:], []byte("A17-PROB"))
	return pkt
}

// sendAndObserve sends from dev1's TUN and returns what dev0 writes to its TUN.
func sendAndObserve(p *pair, pkt []byte, wait time.Duration) ([]byte, bool) {
	p.tuns[1].Outbound <- pkt
	select {
	case got := <-p.tuns[0].Inbound:
		return got, true
	case <-time.After(wait):
		return nil, false
	}
}

func TestWrappedIPv6PayloadLengthIsDropped(t *testing.T) {
	p := newPair(t)

	// Control: a well-formed packet traverses unchanged (and completes the handshake).
	valid := ipv6(8)
	got, ok := sendAndObserve(p, valid, 10*time.Second)
	if !ok || string(got) != string(valid) {
		t.Fatalf("control: valid IPv6 packet did not traverse unchanged (ok=%v len=%d)", ok, len(got))
	}

	// Control: an overstated length that does not wrap is dropped.
	if got, ok := sendAndObserve(p, ipv6(100), 2*time.Second); ok {
		t.Fatalf("control: overstated payload length 100 was delivered (%d bytes)", len(got))
	}

	// 0xFFFF + 40 and 0xFFD8 + 40 wrap to 39 and 0 in a uint16.
	for _, declared := range []uint16{0xFFFF, 0xFFD8} {
		if got, ok := sendAndObserve(p, ipv6(declared), 2*time.Second); ok {
			t.Errorf("payloadLength=0x%04X needs %d bytes but only 48 are present: dev0 wrote a %d-byte packet to its TUN: %x",
				declared, uint32(declared)+40, len(got), got)
		}
	}
}
