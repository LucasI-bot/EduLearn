document.addEventListener("turbolinks:load", function() {
    const buttonPairs = document.querySelectorAll('.card-question-answer-buttons');
  
    buttonPairs.forEach(function(pair) {
        const buttonCorrect = pair.querySelector('.btn-correct');
        const buttonIncorrect = pair.querySelector('.btn-incorrect');
        const hiddenForm = pair.querySelector('.correct_hidden_form');

        buttonCorrect.addEventListener('click', function() {
            if(!buttonCorrect.classList.contains('selected')){
                buttonCorrect.classList.add('selected');
                hiddenForm.value = "true"
                buttonIncorrect.classList.remove('selected');
            }
        });
        
        buttonIncorrect.addEventListener('click', function() {
            if(!buttonIncorrect.classList.contains('selected')){
                buttonCorrect.classList.remove('selected');
                hiddenForm.value = "false"
                buttonIncorrect.classList.add('selected');
            }
        });
    });
  });