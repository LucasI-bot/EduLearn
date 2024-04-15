document.addEventListener("turbolinks:load", function() {
    // Get the table element
    var table = document.getElementById("teacher-admin-table");
  
    // Get all table headers
    var headers = table.getElementsByTagName("th");

    for (var i = 0; i < headers.length; i++) {
      headers[i].addEventListener("click", function() {
        var column = this.getAttribute("id");

        var url = new URL(window.location.href);

        // Add a new parameter to the URL
        if (url.searchParams.get('order') == 'asc' && url.searchParams.get('order_by') == column){
            url.searchParams.set('order', 'desc');
        }else{
            url.searchParams.set('order', 'asc');
        };
        url.searchParams.set('order_by', column);
        
        

        // Reload the page with the updated URL
        window.location.href = url.toString();
      });
    }
  });