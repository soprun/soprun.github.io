// https://developers.cloudflare.com/pages/platform/functions/examples/cors-headers/

// Access-Control-Allow-Origin: * *.sentry.io
// Access-Control-Allow-Credentials: true
// Access-Control-Allow-Methods: GET, OPTIONS, HEAD
// Access-Control-Max-Age: 86400

let Access_Control_Allow_Origin = "* *.sentry.io"
let Access_Control_Allow_Headers = '*'
let Access_Control_Allow_Methods = 'GET, OPTIONS, HEAD'
let Access_Control_Allow_Credentials = 'true'
let Access_Control_Max_Age = '86400';

// Respond to OPTIONS method
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

// Set CORS to all /api responses
export const onRequest: PagesFunction = async ({ next }) => {
    const response = await next();
    response.headers.set('Access-Control-Allow-Origin', Access_Control_Allow_Origin);
    response.headers.set('Access-Control-Allow-Headers', Access_Control_Allow_Headers);
    response.headers.set('Access-Control-Allow-Methods', Access_Control_Allow_Methods);
    response.headers.set('Access-Control-Allow-Credentials', Access_Control_Allow_Credentials);
    response.headers.set('Access-Control-Max-Age', Access_Control_Max_Age);

    // Set-Cookie: id=a3fWa; Expires=Thu, 21 Oct 2021 07:28:00 GMT; Secure; HttpOnly; SameSite=Strict

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
// Vary: Accept-Encoding, Origin
// Referrer-Policy: strict-origin-when-cross-origin
// Strict-Transport-Security: "max-age=16070400; includeSubDomains" always
// Permissions-Policy: document-domain=()
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
