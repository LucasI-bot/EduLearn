function previewImage(input) {
    var preview = document.getElementById('form-image-preview');
    var file = input.files[0];
    var reader = new FileReader();
  
    reader.onload = function() {
      preview.src = reader.result;
      preview.style.display = 'block';
    }
  
    if (file) {
      reader.readAsDataURL(file);
    }
  }
  