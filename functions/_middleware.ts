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
