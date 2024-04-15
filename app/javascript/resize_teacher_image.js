window.addEventListener("turbolinks:load", function() {
    var images = document.querySelectorAll('.img-framed-card');
    var frames = document.querySelectorAll('.circular-card-frame');
    
    // Function to adjust image size based on aspect ratio
    function adjustImageSize(image, frame) {
      var frameWidth = frame.offsetWidth;
      var frameHeight = frame.offsetHeight;
      var imageWidth = image.naturalWidth;
      var imageHeight = image.naturalHeight;
      var aspectRatio = imageWidth / imageHeight;
      
      if (aspectRatio >= 1) {
        // Image is wider than tall
        image.style.height = '100%';
        image.style.width = 'auto';
      } else {
        // Image is taller than wide
        image.style.width = '100%';
        image.style.height = 'auto';
      }
    }
    
    // Call adjustImageSize function for each image and frame pair
    images.forEach(function(image, index) {
      adjustImageSize(image, frames[index]);
    });
  
    // Call adjustImageSize function on window resize
    window.addEventListener('resize', function() {
      images.forEach(function(image, index) {
        adjustImageSize(image, frames[index]);
      });
    });
  });