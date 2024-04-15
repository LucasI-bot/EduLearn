document.addEventListener("turbolinks:load", function() {
    const imagePreview = document.getElementById('form-image-preview');
    const fileInput = document.getElementById('file-input');
  
    imagePreview.addEventListener('click', function() {
        fileInput.click();
    });
  });