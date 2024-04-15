function showSkillsSubjects(input) {
    var skillsSubjectsDiv = document.getElementById('skills-subjects-create-user');
    var role = input.value;
  
    if (role == 'student') {
        skillsSubjectsDiv.style.display = 'block'
    }else{
        skillsSubjectsDiv.style.display = 'none'
    }
  }