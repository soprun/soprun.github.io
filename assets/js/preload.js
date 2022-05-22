(function (document) {

    console.log("run: preload.js");

    document.addEventListener('DOMContentLoaded', (event) => {
        document.querySelectorAll('link').forEach((link) => {
            if (link.rel === "preload") {
                link.rel = "stylesheet"
            }
        });
    });

    window.addEventListener('load', (event) => {
        console.log("All resources finished loading!");

        // document.querySelector('body').className = 'loaded';
    });
})(document);
