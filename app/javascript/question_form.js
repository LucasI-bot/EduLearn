window.addEventListener("turbolinks:load", function() {
    document.body.addEventListener("click", function(event) {
        const addOptionButton = document.getElementById("addOption");
        if (event.target === addOptionButton) {
            const optionsContainer = document.getElementById("optionsContainer");
            const optionCount = optionsContainer.querySelectorAll(".option-div").length;
            const newOptionDiv = document.createElement("div");
            newOptionDiv.classList.add("option-div");
            newOptionDiv.classList.add("my-1");

            const columnDiv = document.createElement("div");
            columnDiv.classList.add("col-md-11");

            const checkboxDiv = document.createElement("div");
            checkboxDiv.classList.add("my-2");

            const formCheck = document.createElement("div");
            formCheck.classList.add("form-check");
        
            const textboxlabel = document.createElement("label");
            textboxlabel.textContent = "Opción " + (optionCount + 1)
            textboxlabel.for = "question_options_Opción";
            textboxlabel.classList.add("form-label")

            const textbox = document.createElement("input");
            textbox.type = "text";
            textbox.name = "question[options_attributes][" + optionCount + "][option]";
            textbox.classList.add("form-control")

            const checkbox = document.createElement("input");
            checkbox.type = "checkbox";
            checkbox.name = "question[options_attributes][" + optionCount + "][correct]";
            checkbox.value = "1";
            checkbox.classList.add("form-check-input");

            const checkboxlabel = document.createElement("label");
            checkboxlabel.textContent = "Correcta"
            checkboxlabel.for = "question_options_Correcta";
            checkboxlabel.classList.add("form-check-label")

            const btnDelete = document.createElement("div")
            btnDelete.innerHTML = '<svg class="delete-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><path d="M135.2 17.7L128 32H32C14.3 32 0 46.3 0 64S14.3 96 32 96H416c17.7 0 32-14.3 32-32s-14.3-32-32-32H320l-7.2-14.3C307.4 6.8 296.3 0 284.2 0H163.8c-12.1 0-23.2 6.8-28.6 17.7zM416 128H32L53.2 467c1.6 25.3 22.6 45 47.9 45H346.9c25.3 0 46.3-19.7 47.9-45L416 128z"/></svg>'
            btnDelete.classList.add("delete-option")
            btnDelete.classList.add("btn")
            btnDelete.classList.add("btn-secondary")
            
            formCheck.appendChild(checkbox);
            formCheck.appendChild(checkboxlabel);
            checkboxDiv.appendChild(formCheck);
            columnDiv.appendChild(textboxlabel);
            columnDiv.appendChild(textbox);
            columnDiv.appendChild(checkboxDiv);
            newOptionDiv.appendChild(columnDiv);
            newOptionDiv.appendChild(btnDelete);
            
            optionsContainer.appendChild(newOptionDiv);
        }
    });
});