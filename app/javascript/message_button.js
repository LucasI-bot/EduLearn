document.addEventListener('turbolinks:load', function() {
    const textarea = document.getElementById('message-textarea');
    const button = document.getElementById('message-button');

    textarea.addEventListener('input', function() {
        if (textarea.value.trim() !== '') {
            button.removeAttribute('disabled');
        } else {
            button.setAttribute('disabled', true);
        }
    });
});