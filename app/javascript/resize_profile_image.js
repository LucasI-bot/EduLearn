window.addEventListener("turbolinks:load", function() {
    var image = document.querySelector('.img-framed');
    var frame = document.querySelector('.circular-frame');
    
    // Function to adjust image size based on aspect ratio
    function adjustImageSize() {
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
    
    // Call adjustImageSize function initially and on window resize
    adjustImageSize();
    window.addEventListener('resize', adjustImageSize);
  });