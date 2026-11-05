package com.fuzevpn.android

/** Fixed-origin HTML. No channel argument, account data or request id enters it. */
internal object TurnstileDocument {
    private val noncePattern = Regex("[A-Za-z0-9_-]{24,128}")

    fun html(nonce: String): String {
        require(noncePattern.matches(nonce))
        return """
            <!doctype html>
            <html><head><meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <meta http-equiv="Content-Security-Policy" content="default-src 'none'; script-src 'nonce-$nonce' 'strict-dynamic' https://challenges.cloudflare.com; style-src 'nonce-$nonce'; style-src-attr 'unsafe-inline'; frame-src 'self' about: https://challenges.cloudflare.com; connect-src https://challenges.cloudflare.com; img-src data: https://challenges.cloudflare.com; base-uri 'none'; form-action 'none'; object-src 'none'">
            <title>FuzeVPN</title>
            <style nonce="$nonce">html,body{margin:0;min-height:100%;background:transparent}body{display:flex;align-items:center;justify-content:center}#challenge{margin:20px auto}</style>
            <script nonce="$nonce">
            (function(){
              'use strict';
              var outcome = null;
              var settled = false;
              var ready = false;
              function finish(value) { if (!settled) { settled = true; outcome = value; } }
              // Readiness is explicit: without it the bridge bounds the provider startup.
              Object.defineProperty(window, '__fuzeTurnstileTake', {
                configurable: false, writable: false,
                value: function() { if (outcome === null) return ready && !settled ? {kind:'ready'} : null; var value = outcome; outcome = null; return value; }
              });
              // Load errors do not bubble and CSP blocks inline handlers: capture the provider script failure.
              window.addEventListener('error', function(event) {
                var source = event && event.target;
                if (!ready && source && source.tagName === 'SCRIPT' && typeof source.src === 'string' &&
                    source.src.indexOf('${TurnstilePolicy.SCRIPT_URL}?') === 0) { finish({kind:'error'}); }
              }, true);
              window.__fuzeTurnstileReady = function() {
                if (ready || settled) return;
                ready = true;
                try {
                  turnstile.render('#challenge', {
                    sitekey: '${TurnstilePolicy.SITE_KEY}', action: '${TurnstilePolicy.ACTION}',
                    size: 'compact',
                    'response-field': false,
                    callback: function(token) {
                      if (typeof token === 'string' && token.length > 0 && token.length <= 2048 && token.split('').every(function(character) { var code = character.charCodeAt(0); return code >= 33 && code <= 126; })) {
                        finish({kind:'token', token:token});
                      } else { finish({kind:'error'}); }
                    },
                    'error-callback': function() { finish({kind:'error'}); },
                    'expired-callback': function() { finish({kind:'expired'}); },
                    'timeout-callback': function() { finish({kind:'error'}); }
                  });
                } catch (_) { finish({kind:'error'}); }
              };
            })();
            </script>
            </head><body><div id="challenge"></div>
            <script nonce="$nonce" src="${TurnstilePolicy.SCRIPT_URL}?onload=__fuzeTurnstileReady&amp;render=explicit" async defer></script>
            </body></html>
        """.trimIndent()
    }

    /** Called only via evaluateJavascript, which evaluates in the main frame. */
    val takeResultScript: String = """
        (function(){
          if (window !== window.top || window.location.href !== '${TurnstilePolicy.BASE_URL}') {
            return JSON.stringify({kind:'error'});
          }
          if (typeof window.__fuzeTurnstileTake !== 'function') return JSON.stringify(null);
          return JSON.stringify(window.__fuzeTurnstileTake());
        })()
    """.trimIndent()
}
