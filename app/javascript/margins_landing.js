document.addEventListener('turbolinks:load', function() {
    var landing1Height = document.getElementById('landing1').offsetHeight;
    var landing2Height = document.getElementById('landing2').offsetHeight;
    document.getElementById('landing3').style.marginTop = landing2Height + 'px';
});