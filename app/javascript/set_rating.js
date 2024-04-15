document.addEventListener('turbolinks:load', function() {
    // Get the hidden field value
    var hiddenFieldValue = document.getElementById('rating').value;

    // Get all the input elements with the class .star
    var starInputs = document.querySelectorAll('.star');

    // Loop through each input element
    starInputs.forEach(function(input) {
        // Check if the input value matches the hidden field value
        if (input.value === hiddenFieldValue) {
            input.checked = true; // If matched, check the input
        } else {
            input.checked = false; // If not matched, uncheck the input
        }
    });
});