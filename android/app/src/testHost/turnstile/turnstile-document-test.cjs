const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');
const assert = require('node:assert/strict');
const directory = process.argv[2];
const html = fs.readFileSync(path.join(directory, 'turnstile-document.fixture.html'), 'utf8');
const take = fs.readFileSync(path.join(directory, 'turnstile-poll.fixture.js'), 'utf8');
const inline = html.match(/<script nonce="[A-Za-z0-9_-]+">([\s\S]*?)<\/script>/)[1];
// What a browser exposes for the provider tag: the resolved src, entities decoded.
const provider = { tagName: 'SCRIPT', src: html.match(/<script nonce="[A-Za-z0-9_-]+" src="([^"]+)"/)[1].replace(/&amp;/g, '&') };
let cases = 0;
const failures = [];
function instance(loaded = true, render) {
  let options;
  let renders = 0;
  const listeners = [];
  const window = { location: { href: 'https://app.fuzevpn.com/' },
    addEventListener(type, listener, capture) { listeners.push({ type, listener, capture }); } };
  window.top = window;
  const context = vm.createContext({ window, turnstile: { render(selector, value) {
    assert.equal(selector, '#challenge'); options = value; renders++;
    if (render) render(value);
  } } });
  vm.runInContext(inline, context, { timeout: 1000 });
  if (loaded) window.__fuzeTurnstileReady();
  return { window, get options() { return options; }, get renders() { return renders; },
    take: () => JSON.parse(vm.runInContext(take, context, { timeout: 1000 })),
    // A script that fails to load fires a non-bubbling error event: only capturing listeners see it.
    fail: (target) => listeners.filter((entry) => entry.type === 'error' &&
      (entry.capture === true || entry.capture?.capture === true)).forEach((entry) => entry.listener({ type: 'error', target })) };
}
function scenario(name, body) {
  try { body(); cases++; } catch (error) { failures.push(`${name}: ${error.message}`); }
}
{
  const current = instance();
  assert.equal(current.options.sitekey, '0x4AAAAAAE-cdqxPJMG4iuq4');
  assert.equal(current.options.action, 'signup');
  assert.equal(current.options.size, 'compact');
  assert.equal(current.options['response-field'], false);
  assert.ok(html.indexOf('<div id="challenge">') < html.indexOf('src="https://challenges.cloudflare.com/turnstile/v0/api.js'));
  cases++;
}
scenario('an initialized provider reports readiness until its read-once outcome', () => {
  const current = instance();
  assert.deepEqual(current.take(), { kind: 'ready' });
  current.options.callback('synthetic-token-one');
  assert.deepEqual(current.take(), { kind: 'token', token: 'synthetic-token-one' });
  assert.equal(current.take(), null);
});
{
  const current = instance();
  current.options.callback('a'.repeat(2048));
  assert.equal(current.take().token.length, 2048);
  cases++;
}
for (const token of ['', 'a'.repeat(2049), 'two words', 'line\n', 'é', 7, null]) {
  const current = instance();
  current.options.callback(token);
  assert.deepEqual(current.take(), { kind: 'error' });
  cases++;
}
{
  const current = instance();
  current.options.callback('first-token-fixture');
  current.options.callback('second-token-fixture');
  current.options['error-callback']('provider-message-fixture');
  assert.deepEqual(current.take(), { kind: 'token', token: 'first-token-fixture' });
  assert.equal(current.take(), null);
  cases++;
}
{
  const current = instance();
  current.options['expired-callback']();
  current.options.callback('late-token-fixture');
  assert.deepEqual(current.take(), { kind: 'expired' });
  cases++;
}
{
  const current = instance();
  current.options.callback('synthetic-token');
  current.window.location.href = 'https://app.fuzevpn.com/?other';
  assert.deepEqual(current.take(), { kind: 'error' });
  cases++;
}
{
  const current = instance();
  current.options.callback('synthetic-token');
  current.window.top = {};
  assert.deepEqual(current.take(), { kind: 'error' });
  cases++;
}
{
  const current = instance();
  const descriptor = Object.getOwnPropertyDescriptor(current.window, '__fuzeTurnstileTake');
  assert.equal(descriptor.configurable, false);
  assert.equal(descriptor.writable, false);
  current.options['error-callback']('remote-detail-fixture');
  assert.deepEqual(current.take(), { kind: 'error' });
  cases++;
}
// A06-turnstile-01: offline, DNS, HTTP error or refused provider script.
scenario('provider script load failure is terminal before initialization', () => {
  const current = instance(false);
  assert.equal(current.take(), null);
  assert.ok(!/<script[^>]*\son[a-z]+\s*=/i.test(html), 'CSP blocks inline handler attributes');
  current.fail(provider);
  assert.deepEqual(current.take(), { kind: 'error' });
  assert.equal(current.take(), null);
  current.window.__fuzeTurnstileReady();
  assert.equal(current.renders, 0);
  assert.equal(current.take(), null);
});
// A provider that never initializes never reports readiness: the native startup bound applies.
scenario('readiness is reported only after initialization and never consumes the outcome', () => {
  const current = instance(false);
  for (let i = 0; i < 1000; i++) assert.equal(current.take(), null);
  current.window.__fuzeTurnstileReady();
  assert.equal(current.renders, 1);
  for (let i = 0; i < 3; i++) assert.deepEqual(current.take(), { kind: 'ready' });
  current.options.callback('synthetic-token-ready');
  assert.deepEqual(current.take(), { kind: 'token', token: 'synthetic-token-ready' });
  assert.equal(current.take(), null);
});
scenario('other resource, runtime and post-initialization errors are ignored', () => {
  const current = instance(false);
  for (const target of [undefined, null, current.window, { tagName: 'IMG', src: provider.src }, { tagName: 'SCRIPT', src: 7 },
    { tagName: 'SCRIPT', src: 'https://challenges.cloudflare.com/turnstile/v0/other.js' },
    { tagName: 'SCRIPT', src: provider.src.replace('/api.js?', '/api.jsx?') }]) current.fail(target);
  assert.equal(current.take(), null);
  current.window.__fuzeTurnstileReady();
  current.fail(provider);
  assert.deepEqual(current.take(), { kind: 'ready' });
});
scenario('a repeated provider callback renders once and keeps the first outcome', () => {
  const current = instance();
  current.window.__fuzeTurnstileReady();
  assert.equal(current.renders, 1);
  current.options.callback('synthetic-token-once');
  current.window.__fuzeTurnstileReady();
  assert.equal(current.renders, 1);
  assert.deepEqual(current.take(), { kind: 'token', token: 'synthetic-token-once' });
  assert.equal(current.take(), null);
});
scenario('a render failure after initialization is terminal', () => {
  const current = instance(true, () => { throw new Error('render-fixture'); });
  assert.deepEqual(current.take(), { kind: 'error' });
  assert.equal(current.take(), null);
});
if (failures.length > 0) {
  for (const failure of failures) console.error(`FAIL ${failure}`);
  console.error(`Generated HTML/JavaScript: FAIL (${failures.length} of ${cases + failures.length} scenarios)`);
  process.exitCode = 1;
} else console.log(`Generated HTML/JavaScript: PASS (${cases} scenarios, no network)`);
