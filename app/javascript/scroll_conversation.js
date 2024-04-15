window.addEventListener("turbolinks:load", function() {
    var chatbox = document.getElementById('chatbox');
    if( chatbox !== null){
        chatbox.scrollTop = chatbox.scrollHeight;
    } 
});