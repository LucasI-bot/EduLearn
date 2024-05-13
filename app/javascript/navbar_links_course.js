window.addEventListener('scroll', function() {
    var navbar = document.getElementById('navbar');
    var sections = document.querySelectorAll('.course-section');
    var courseHeaderHeight = document.getElementById('course-header').offsetHeight;

    // Show navbar when scrolled below
    if (window.scrollY > courseHeaderHeight + 20 ) { // Adjust 100 to your desired value
      navbar.classList.add('show');
    } else {
      navbar.classList.remove('show');
    }
    
    // Highlight navbar links based on scroll position
    sections.forEach(function(section, index) {
      var top = section.offsetTop - navbar.offsetHeight; // Offset to account for navbar height
      
      if (window.scrollY >= top && window.scrollY  < top + section.offsetHeight) {
        navbar.querySelector('.nav-link.active').classList.remove('active');
        navbar.querySelectorAll('.nav-link')[index].classList.add('active');
      }
    });
  });