package com.fuzevpn.android

import java.nio.file.Files
import java.nio.file.Path

/** Public constants and synthetic CSP nonce only; no network or real token. */
fun main(arguments: Array<String>) {
    val directory = Path.of(arguments.single())
    Files.writeString(directory.resolve("turnstile-document.fixture.html"),
        TurnstileDocument.html("fixture_012345678901234567890123456789"))
    Files.writeString(directory.resolve("turnstile-poll.fixture.js"), TurnstileDocument.takeResultScript)
}
