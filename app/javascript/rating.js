document.addEventListener('turbolinks:load', function() {
    var starInputs = document.querySelectorAll('.star');

    // Add click event listener to each star input
    starInputs.forEach(function(input) {
        input.addEventListener('click', function() {
            // Get the value of the clicked star
            var clickedStarValue = input.value;
            
            // Update the value of the hidden field #prev_rating
            document.getElementById('rating').value = clickedStarValue;
        });
    });
});