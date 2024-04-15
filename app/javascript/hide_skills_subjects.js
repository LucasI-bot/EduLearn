document.addEventListener("turbolinks:load", function() {
    var skillsSubjectsDiv = document.getElementById('skills-subjects-create-user');
    var selectRole = document.getElementById('role-select');
    var role = selectRole.value;
  
    if (role == 'student') {
        skillsSubjectsDiv.style.display = 'block'
    }else{
        skillsSubjectsDiv.style.display = 'none'
    }
  });