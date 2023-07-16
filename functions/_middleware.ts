// https://developers.cloudflare.com/pages/platform/functions/examples/cors-headers/
// https://infosec.mozilla.org/guidelines/web_security#referrer-policy
// https://developers.cloudflare.com/pages/platform/functions/examples/cors-headers/

// interface Env {
//     ENVIRONMENT: string;
// }

export interface Env {
    // Example binding to KV. Learn more at https://developers.cloudflare.com/workers/runtime-apis/kv/
    // SENTRY_DSN: KVNamespace;

    // Example binding to Durable Object. Learn more at https://developers.cloudflare.com/workers/runtime-apis/durable-objects/
    // MY_DURABLE_OBJECT: DurableObjectNamespace;

    // Example binding to R2. Learn more at https://developers.cloudflare.com/workers/runtime-apis/r2/
    // MY_BUCKET: R2Bucket;

    // Example binding to a Service. Learn more at https://developers.cloudflare.com/workers/runtime-apis/service-bindings/
    // MY_SERVICE: Fetcher;
}

let Access_Control_Allow_Origin = 'https://soprun.com *.sentry.io *.cloudflareinsights.com *.yandex.ru';
let Access_Control_Allow_Headers = 'Content-Type';
let Access_Control_Allow_Methods = 'GET, OPTIONS, HEAD';
let Access_Control_Allow_Credentials = 'true';
let Access_Control_Max_Age = '86400';
let Strict_Transport_Security = 'max-age=63072000; includeSubDomains; preload';
let Referrer_Policy = 'strict-origin-when-cross-origin';

let PublicKeyPins =
    'pin-sha256="cUPcTAZWKaASuYWhhneDttWpY3oBAkE3h2+soZS7sWs="; ' +
    'pin-sha256="M8HztCzM3elUxkcjR2S5P4hhyBNf6lHkmjAHKhpGPWE="; ' +
    'max-age=5184000; includeSubDomains; ' +
    'report-uri="https://o364305.ingest.sentry.io/api/6291966/security/?sentry_key=5943bcec0a2e4787882cbb988fd0aabc"';

export const onRequestOptions: PagesFunction = async () => {
    return new Response(null, {
        status: 204,
        headers: {
            'Access-Control-Allow-Origin': Access_Control_Allow_Origin,
            'Access-Control-Allow-Headers': Access_Control_Allow_Headers,
            'Access-Control-Allow-Methods': Access_Control_Allow_Methods,
            'Access-Control-Allow-Credentials': Access_Control_Allow_Credentials,
            'Access-Control-Max-Age': Access_Control_Max_Age
        },
    });
};

export const onRequest: PagesFunction = async ({next}) => {
    const response = await next();

    response.headers.set('Access-Control-Allow-Origin', Access_Control_Allow_Origin);
    response.headers.set('Access-Control-Allow-Headers', Access_Control_Allow_Headers);
    response.headers.set('Access-Control-Allow-Methods', Access_Control_Allow_Methods);
    response.headers.set('Access-Control-Allow-Credentials', Access_Control_Allow_Credentials);
    response.headers.set('Access-Control-Max-Age', Access_Control_Max_Age);

    // Cookies
    // https://infosec.mozilla.org/guidelines/web_security#cookies

    // Set-Cookie: id=a3fWa; Expires=Thu, 21 Oct 2021 07:28:00 GMT; Secure; HttpOnly; SameSite=Strict
    // Set-Cookie: __Host-sess=123; Domain=example.com; Path=/; Secure
    // Set-Cookie: __Host-sess=123; path=/; Secure; HttpOnly; SameSite=Lax

    // # Session identifier used for a secure site, such as bugzilla.mozilla.org. It isn't sent from cross-origin
    // # requests, nor is it sent when navigating to bugzilla.mozilla.org from another site. Used in conjunction with
    // # other anti-CSRF measures, this is a very strong way to defend your site against CSRF attacks.

    // Set-Cookie: __Host-BMOSESSIONID=YnVnemlsbGE=; Max-Age=2592000; Path=/; Secure; HttpOnly; SameSite=Strict


    // https://docs.sentry.io/product/security-policy-reporting/

    // Content-Security-Policy-Report-Only: ...; report-uri https://o364305.ingest.sentry.io/api/6291966/security/?sentry_key=5943bcec0a2e4787882cbb988fd0aabc
    // Expect-CT: max-age=86400, enforce, report-uri="https://o364305.ingest.sentry.io/api/6291966/security/?sentry_key=5943bcec0a2e4787882cbb988fd0aabc"
    // Public-Key-Pins: ...; report-uri="https://o364305.ingest.sentry.io/api/6291966/security/?sentry_key=5943bcec0a2e4787882cbb988fd0aabc"


    // Прозрачность сертификатов
    // https://soprun.sentry.io/settings/projects/soprun/security-headers/expect-ct/
    let Expect_CT = 'max-age=604800, enforce, report-uri=https://o364305.ingest.sentry.io/api/6291966/security/?sentry_key=5943bcec0a2e4787882cbb988fd0aabc;';

    response.headers.set('Expect-CT', Expect_CT);

    // https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/SourceMap
    // SourceMap: <url>


    // Строгая транспортная безопасность
    // https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security
    // https://hstspreload.org/?domain=soprun.com
    response.headers.set('Strict-Transport-Security', Strict_Transport_Security);


    // Referrer Policy
    // https://infosec.mozilla.org/guidelines/web_security#referrer-policy
    // Отправлять только сокращенный реферер на иностранный источник, полный реферер на локальный хост
    response.headers.set('Referrer-Policy', Referrer_Policy);

    // Feature-Policy
    //
    // https://en.wikipedia.org/wiki/Public-key_cryptography
    response.headers.set('Public-Key-Pins-Report-Only', PublicKeyPins);


    // Accept-Language: fr

    response.headers.set('Vary', 'Origin,Accept-Encoding,Cookie');

    response.headers.set('X-Frame-Options', 'DENY');
    response.headers.set('X-XSS-Protection', '1; mode=block');
    response.headers.set('X-Content-Type-Options', 'nosniff');

    // response.headers.set('X-Download-Options', 'noopen');


    // let Content_Security_Policy = "default-src https:; connect-src https:; font-src https: data:; frame-src https: " +
    //     "twitter:; img-src https: data:; media-src https:; object-src https:; " +
    //     "script-src 'unsafe-inline' 'unsafe-eval' https:; " +
    //     "style-src 'unsafe-inline' https:; " +
    //     "report-uri https://o364305.ingest.sentry.io/api/6291966/security/?sentry_key=5943bcec0a2e4787882cbb988fd0aabc;";


    // ";connect-src: *.sentry.io" +
    // ";script-src: https://browser.sentry-cdn.com https://js.sentry-cdn.com" +

    // let Content_Security_Policy = "" +
    //     "default-src 'self' 'unsafe-inline' *.sentry.io" +
    //     ";img-src https: data: *" +
    //     ";script-src: *" +
    //     ";script-src-elem: *" +
    //     ";font-src *" +
    //     ";style-src 'self'" +
    //     ";connect-src *.sentry.io" +
    //     ";child-src blob: https://mc.yandex.ru" +
    //     ";frame-src blob: https://mc.yandex.ru" +
    //     ";object-src 'none'" +
    //     ";report-uri https://o364305.ingest.sentry.io/api/6291966/security/?sentry_key=5943bcec0a2e4787882cbb988fd0aabc";


    let Content_Security_Policy = "" +
        "default-src https:;" +
        "script-src 'self' 'unsafe-inline' https: cdnjs.cloudflare.com;" +
        "style-src 'self' 'unsafe-inline' https:;" +
        "object-src https:;" +
        "connect-src https: *.sentry.io cloudflareinsights.com;" +
        "font-src https: data: fonts.gstatic.com;" +
        "frame-src https:;" +
        "img-src 'self' https: images.unsplash.com en.gravatar.com;" +
        "manifest-src https:;" +
        "media-src https:;" +
        "report-uri https://o364305.ingest.sentry.io/api/6291966/security/?sentry_key=5943bcec0a2e4787882cbb988fd0aabc;";

    response.headers.set('Content-Security-Policy', Content_Security_Policy);
    // response.headers.set('Content-Security-Policy-Report-Only', Content_Security_Policy);

    // https://soprun.sentry.io/settings/projects/soprun/security-headers/hpkp/

    // Public-Key-Pins-Report-Only: pin-sha256="<pin-value>";
    // max-age=<expire-time>;
    // includeSubDomains;
    // report-uri="<uri>"

    // Public-Key-Pins-Report-Only:
    // pin-sha256 = "dOFcREXWKaEVoYWhhneDttWpY3oDEkE5g6+soQD7xXz=";
    // pin-sha256 = "N7SgtCzM3elUxkcjR2S5P4hhyBNf6lHkmjAHKhpGPXO="; includeSubDomains;
    // report-uri = ”https://www.sample.org/hpkp-report”


    // Access-Control-Allow-Headers: sentry-trace
    // Access-Control-Allow-Headers: baggage


    // https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Permissions-Policy
    response.headers.set('Permissions-Policy', 'document-domain');


    response.headers.set('Vary', 'Accept-Encoding, Origin');

    return response;
};

// Cache-Control: public, no-transform
// X-Frame-Options: DENY
// X-Content-Type-Options: nosniff always
// X-XSS-Protection: 1; mode=block
// Timing-Allow-Origin: *
// Access-Control-Allow-Origin: * *.sentry.io
// Access-Control-Allow-Credentials: true
// Access-Control-Allow-Methods: GET, OPTIONS, HEAD
// Access-Control-Max-Age: 86400
// Referrer-Policy: strict-origin-when-cross-origin
// Strict-Transport-Security: "max-age=16070400; includeSubDomains" always
// Expect-CT: max-age=604800, report-uri="https://o364305.ingest.sentry.io/api/6291966/security/?sentry_key=5943bcec0a2e4787882cbb988fd0aabc"
// Content-Security-Policy-Report-Only: default-src 'self' 'unsafe-inline' https://*.sentry.io; img-src https://mc.yandex.ru; script-src  https://mc.yandex.ru https://yastatic.net https://browser.sentry-cdn.com; style-src 'self' https://cdnjs.cloudflare.com https://fonts.googleapis.com; connect-src 'self' *.sentry.io sentry.io https://mc.yandex.ru; child-src blob: https://mc.yandex.ru; frame-src blob: https://mc.yandex.ru; object-src 'none'; report-uri https://o364305.ingest.sentry.io/api/6291966/security/?sentry_key=5943bcec0a2e4787882cbb988fd0aabc;


// https://developers.cloudflare.com/pages/platform/functions/plugins/sentry/


import sentryPlugin from "@cloudflare/pages-plugin-sentry";

// export const onRequest: PagesFunction<{
//     KV: KVNamespace;
// }> = async (context) => {
//     return sentryPlugin({ dsn: await context.env.KV.get("SENTRY_DSN") })(context);
// };


// const hello = async ({ next }) => {
//     const response = await next();
//     response.headers.set("X-Hello", "Hello from functions Middleware!");
//     return response;
// };
//
//
// export const onRequest: PagesFunction[] = [
//     twindPlugin({
//         darkMode: "class"
//     }),
//     hello
// ];


// Script And Style Hasher for CSP
// https://report-uri.com/home/hash
// sha256-kvD0A6jG3+h5INcjwy2Y9iJYVjecobUhwAYecpqfg0U=
