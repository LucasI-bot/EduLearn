document.addEventListener('turbolinks:load', function() {
    $('#open-rating-modal').click(function() {
      $('#rating-modal').modal('show');
    });
});