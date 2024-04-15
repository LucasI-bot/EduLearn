document.addEventListener('turbolinks:load', function() {
    var courseHeaderHeight = document.getElementById('course-header').offsetHeight;
    document.getElementById('course-information').style.marginTop = courseHeaderHeight - 50 + 'px';
});