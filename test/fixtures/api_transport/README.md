The certificate and matching private key embedded in synthetic_tls_fixture.dart
are public, synthetic test fixtures. They authenticate only loopback test
servers and must never be used by a deployed server. The certificate includes
localhost and 127.0.0.1.

The TLS regression adds this certificate to the test isolate's default trust
context. Application sources never load these files or change platform trust.
