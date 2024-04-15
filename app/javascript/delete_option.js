document.addEventListener('turbolinks:load', function() {
  
    // Handle click event for delete buttons
    document.querySelectorAll('.delete-option').forEach(function(button) {
      button.addEventListener('click', function() {
        button.parentNode.nextSibling.nextSibling.remove()
        button.parentNode.remove()
      });
    });
  });