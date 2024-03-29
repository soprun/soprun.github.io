// import sentryPlugin from "@cloudflare/pages-plugin-sentry"

// https://developers.cloudflare.com/pages/platform/functions/examples/cors-headers/
// https://infosec.mozilla.org/guidelines/web_security#referrer-policy
// https://developers.cloudflare.com/pages/platform/functions/examples/cors-headers/

// interface Env {
//     KV: KVNamespace
//     // ENV: KVNamespace;
//     // SITE_URL: KVNamespace;
//     // SENTRY_DSN: KVNamespace;
// }

// import {KVNamespace} from "@cloudflare/workers-types";

// interface Env {
//     JEKYLL_ENV: string
//     SITE_URL: string
//     CF_PAGES_COMMIT_SHA: string
//     CF_PAGES_URL: string
// }

// export interface Env {
//     KV: KVNamespace

// Example binding to KV. Learn more at https://developers.cloudflare.com/workers/runtime-apis/kv/
// ENTRY_DSN: KVNamespace;

// Example binding to Durable Object. Learn more at https://developers.cloudflare.com/workers/runtime-apis/durable-objects/
// MY_DURABLE_OBJECT: DurableObjectNamespace;

// Example binding to R2. Learn more at https://developers.cloudflare.com/workers/runtime-apis/r2/
// MY_BUCKET: R2Bucket;

// Example binding to a Service. Learn more at https://developers.cloudflare.com/workers/runtime-apis/service-bindings/
// MY_SERVICE: Fetcher;
// }

let Accept_Language = 'ru';
let Access_Control_Allow_Origin = 'https://soprun.com *.sentry.io *.cloudflareinsights.com *.yandex.ru';
let Access_Control_Allow_Headers = 'Content-Type';
let Access_Control_Allow_Methods = 'GET, OPTIONS, HEAD';
let Access_Control_Allow_Credentials = 'true';
let Access_Control_Max_Age = '86400';
let Strict_Transport_Security = 'max-age=63072000; includeSubDomains; preload';
let Referrer_Policy = 'strict-origin-when-cross-origin';
let Content_Security_Policy = "" +
    "default-src https:;" +
    "script-src 'self' 'unsafe-inline' https: cdnjs.cloudflare.com;" +
    "style-src 'self' 'unsafe-inline' https:;" +
    "object-src https:;" +
    "connect-src https: *.sentry.io cloudflareinsights.com;" +
    "font-src https: data: fonts.gstatic.com;" +
    "frame-src https:;" +
    "img-src 'self' https: data: images.unsplash.com en.gravatar.com;" +
    "manifest-src https:;" +
    "media-src https:;" +
    "report-uri https://o364305.ingest.sentry.io/api/6291966/security/?sentry_key=5943bcec0a2e4787882cbb988fd0aabc;";
let Expect_CT = 'max-age=604800, enforce, ' +
    'report-uri=https://o364305.ingest.sentry.io/api/6291966/security/?sentry_key=5943bcec0a2e4787882cbb988fd0aabc;';
let PublicKeyPins = "" +
    'pin-sha256="cUPcTAZWKaASuYWhhneDttWpY3oBAkE3h2+soZS7sWs="; ' +
    'pin-sha256="M8HztCzM3elUxkcjR2S5P4hhyBNf6lHkmjAHKhpGPWE="; ' +
    'max-age=5184000; includeSubDomains; ' +
    'report-uri="https://o364305.ingest.sentry.io/api/6291966/security/?sentry_key=5943bcec0a2e4787882cbb988fd0aabc"';
let Vary = 'Accept, Accept-Encoding, Origin, Cookie';
let Origin = 'https://soprun.com';
let Cache_Control = 'public, max-age=0, must-revalidate';

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

// export const onRequest: PagesFunction<Env> = async (context) => {
//     return sentryPlugin({dsn: await context.env.KV.get("SENTRY_DSN")})(context);
// };

// export const onRequest = [errorHandling, authentication];

export const onRequest: PagesFunction = async ({ next }) => {
    // const sentry = sentryPlugin({
    //     dsn: await context.env.KV.get("SENTRY_DSN")
    // })(context);

    const response = await next();
    // const site_url = response.env.get('SITE_URL');
    //
    // console.log(
    //     "response.url" + response.url + "\n" +
    //     "site_url" + site_url
    // );

    // TODO: Сломается при релизе!
    // const env = await context.env.get('JEKYLL_ENV');

    // const sentry_reporting = await context.env.KV.get('SENTRY_REPORTING');
    // const sentry_dsn = await context.env.KV.get('SENTRY_DSN');

    // const CF_PAGES_UR = await context.env.CF_PAGES_UR
    // const CF_PAGES_COMMIT_SHA = await context.env.CF_PAGES_COMMIT_SHA
    //
    // console.log("CF_PAGES_URL" + CF_PAGES_UR)
    // console.info("CF_PAGES_URL" + CF_PAGES_COMMIT_SHA)
    //
    // return new Response(env + " " + site_url + " " + response.url, {
    //     status: 200
    // });


    // const value = await context.env.KV.get('example');
    // env: Env,
    // const value = await env.NAMESPACE.get("SITE_URL");
    // let value = await TODO.get("to-do:123");

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

    response.headers.set('Accept-Language', Accept_Language);
    response.headers.set('X-Frame-Options', 'DENY');
    response.headers.set('X-XSS-Protection', '1; mode=block');
    response.headers.set('X-Content-Type-Options', 'nosniff');

    // https://soprun.sentry.io/settings/projects/soprun/security-headers/hpkp/
    response.headers.set('Content-Security-Policy', Content_Security_Policy);
    // response.headers.set('Content-Security-Policy-Report-Only', Content_Security_Policy);

    // https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Permissions-Policy
    response.headers.set('Permissions-Policy', 'document-domain');
    response.headers.set('Vary', Vary);
    // https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Origin
    response.headers.set('Origin', Origin);
    response.headers.set('Cache-Control', Cache_Control);

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


// import sentryPlugin from "@cloudflare/pages-plugin-sentry";

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
