document.addEventListener('DOMContentLoaded', function() {
    var textField = document.querySelector(`input[name="survey[question${window.step}]"]`);
    var submitButton = document.getElementById('submit_button');
  
    function checkInput() {
      submitButton.disabled = textField.value.trim() === '';
    }
  
    textField.addEventListener('input', checkInput);
    checkInput();
});