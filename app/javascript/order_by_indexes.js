$(document).on('turbolinks:load', function() {
    // Listen for changes to the select box
    $('.order_by_select').change(function() {
      // Get the selected value
      var selectedValue = $(this).val();
      
      // Update the URL with the new parameter value
      var url = new URL(window.location.href);
      url.searchParams.set('order_by', selectedValue);
      
      // Redirect to the updated URL
      window.location.href = url.toString();
    });
  });