(function (document) {
    document.addEventListener('DOMContentLoaded', (event) => {
        document.querySelectorAll('pre.highlight code').forEach((el) => {
            hljs.highlightElement(el);
        });
    });
})(document);
