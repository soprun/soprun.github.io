(document => {
    // console.log("run: scripts.js");

    // document.addEventListener('DOMContentLoaded', (event) => {
    // });

    document.querySelectorAll('link').forEach((link) => {
        if (link.rel === "preload") {
            console.debug(link.href);

            link.rel = "stylesheet"
            link.onload = null
        }
    });

    window.addEventListener('load', (event) => {
        // console.log("All resources finished loading!");
        // document.querySelector('body').className = 'loaded';

        document.querySelectorAll('pre.highlight code').forEach((el) => {
            hljs.highlightElement(el);
        });
    });
})(document);
