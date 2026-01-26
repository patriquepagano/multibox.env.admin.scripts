<!-- Javascript Libraries -->
<script src="/js/jquery.js"></script>
<script>
var throttledFunctionId = null;
function resizeThrottler() {
    if (throttledFunctionId !== null) {
        window.clearTimeout(throttledFunctionId);
        throttledFunctionId = null;
    }

    window.setTimeout(function() {
        var navbar = $('#navigation-bar');
        $('body').css('padding-top', (navbar.height() + 20) + 'px');
        throttledFunctionId = null;
    }, 100)
}
window.addEventListener('resize', resizeThrottler);
</script>
