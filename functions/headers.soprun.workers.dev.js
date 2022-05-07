addEventListener('fetch', event => {
    event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
    const response = await fetch(request);

    // Clone the response so that it's no longer immutable
    const newResponse = new Response(response.body, response);

    // Adjust the value for an existing header
    // newResponse.headers.set('Access-Control-Allow-Origin', 'https://soprun.com');
    // newResponse.headers.set('Access-Control-Allow-Credentials', 'true');
    // newResponse.headers.set('Access-Control-Allow-Methods', 'GET, OPTIONS, HEAD');
    // newResponse.headers.set('Vary', 'Origin');

    newResponse.headers.set('X-Frame-Options', 'DENY');
    newResponse.headers.set('X-XSS-Protection', '1; mode=block');
    newResponse.headers.set('X-Content-Type-Options', 'nosniff');

    newResponse.headers.set('Strict-Transport-Security', 'max-age=63072000; includeSubDomains; preload');

    // https://github.com/w3c/webappsec-permissions-policy/blob/main/permissions-policy-explainer.md
    newResponse.headers.set('Permissions-Policy', 'document-domain=()');

    newResponse.headers.set('Expect-CT', 'max-age=604800, enforce, report-uri="https://o364305.ingest.sentry.io/api/6291966/security/?sentry_key=5943bcec0a2e4787882cbb988fd0aabc"');
    // newResponse.headers.set('Expect-Staple', 'max-age=3600; report-uri="https://soprun.report-uri.com/r/d/staple/enforce"');
    // newResponse.headers.set('Report-To', '{"group":"default","max_age":31536000,"endpoints":[{"url":"https://soprun.report-uri.com/a/d/g"}],"include_subdomains":true}');
    // newResponse.headers.set('NEL', '{"report_to":"default","max_age":31536000,"include_subdomains":true}');

    // newResponse.headers.set('Content-Security-Policy', "" +
    //     "default-src 'self' https:; " +
    //     "connect-src 'self' mc.yandex.ru cloudflareinsights.com *.sentry.io; " +
    //     "script-src 'self' 'unsafe-inline' mc.yandex.ru static.cloudflareinsights.com browser.sentry-cdn.com cdnjs.cloudflare.com; " +
    //     "style-src 'self' 'unsafe-inline' fonts.googleapis.com cdnjs.cloudflare.com; " +
    //     "font-src 'self' fonts.gstatic.com cdnjs.cloudflare.com; " +
    //     "img-src 'self' images.unsplash.com mc.yandex.ru; " +
    //     "report-uri https://soprun.report-uri.com/r/d/csp/enforce; " +
    //     "worker-src 'self';" +
    //     "");

    newResponse.headers.set('Content-Security-Policy-Report-Only', "" +
        "frame-ancestors 'self';" +
        "block-all-mixed-content;" +
        "default-src 'self' https:;" +
        "script-src 'self' 'unsafe-inline' 'report-sample' https: https://*.sentry.io https://browser.sentry-cdn.com https://cdnjs.cloudflare.com https://js.sentry-cdn.com https://mc.yandex.ru https://static.cloudflareinsights.com;" +
        "style-src 'self' 'unsafe-inline' cdnjs.cloudflare.com fonts.googleapis.com;" +
        "object-src 'none';" +
        "frame-src 'self';" +
        "child-src 'self';" +
        "img-src 'self' data: cdnjs.cloudflare.com fonts.gstatic.com images.unsplash.com;" +
        "font-src 'self' cdnjs.cloudflare.com fonts.googleapis.com fonts.gstatic.com;" +
        "connect-src 'self' *.sentry.io cdnjs.cloudflare.com cloudflareinsights.com fonts.googleapis.com fonts.gstatic.com mc.yandex.ru;" +
        "manifest-src 'self';" +
        "base-uri 'self';" +
        "form-action 'self';" +
        "media-src 'self';" +
        "prefetch-src 'self';" +
        "worker-src 'self';" +
        "script-src-elem 'self';" +
        "report-uri https://o364305.ingest.sentry.io/api/6291966/security/?sentry_key=5943bcec0a2e4787882cbb988fd0aabc;" +
        "");

    // newResponse.headers.set('Content-Security-Policy-Report-Only', "policy");

    // https://web.dev/i18n/ru/referrer-best-practices/
    // newResponse.headers.set('Referrer-Policy', "origin-when-cross-origin");
    newResponse.headers.set('Referrer-Policy', "no-referrer");

    // newResponse.headers.set('Feature-Policy', "origin");
    // newResponse.headers.set('Cross-Origin-Resource-Policy', "same-origin");

    return newResponse;
}
