$(document).on('turbolinks:load', function() {
    $('.select2').select2({
    placeholder: 'Seleccionar',
    tags: true // Allows creating new skills on the fly
    });
});