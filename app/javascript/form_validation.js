function validateForm(){
    const fields = document.querySelectorAll('.form-select:invalid, .form-control:invalid')

    if(fields.length > 0){
        if(fields[0].parentElement.textContent.replace(/\s/g, '') == "Contraseña"){
            alert("La contraseña debe tener al menos 8 caracteres")
        } else {
            alert("Ingrese un valor válido en ".concat(fields[0].parentElement.firstElementChild.textContent.toLowerCase()))
        }
    }
}