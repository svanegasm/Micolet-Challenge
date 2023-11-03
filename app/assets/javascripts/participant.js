document.addEventListener('DOMContentLoaded', function() {
    const emailField = document.querySelector('#participant_email');
    const errorMsg = document.querySelector('#errorMsg')
    const VALID_EMAIL_REGEX = /^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$/;
    const checkboxes = document.querySelectorAll('input[type="checkbox"]');
    const submitBtn = document.querySelector('input[type="submit"]');

    emailField.addEventListener('input', function() {
        if (VALID_EMAIL_REGEX.test(emailField.value)) {
            emailField.style.boxShadow = "0 0 0 3px #4ADE80";
            errorMsg.classList.add('hidden');
        } else {
            emailField.classList.remove('focus:ring-green-500');
            errorMsg.classList.remove('hidden');
            emailField.style.boxShadow = "0 0 0 3px rgba(239, 68, 68, 0.7)";
        }
    });

    document.addEventListener('click', function(event) {
        if (event.target !== emailField && event.target !== errorMsg) {
            errorMsg.classList.add('hidden');
            emailField.style.boxShadow = "none";
        }
    });

    function validateBtnConditions() {
        const emailIsValid = VALID_EMAIL_REGEX.test(emailField.value);
        const oneCheckboxChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);

        if (emailIsValid && oneCheckboxChecked) {
            submitBtn.removeAttribute('disabled');
        } else {
            submitBtn.setAttribute('disabled', 'disabled');
        }
    }

    emailField.addEventListener('input', validateBtnConditions);

    checkboxes.forEach(checkbox => {
        checkbox.addEventListener('input', validateBtnConditions);
    });
    submitBtn.setAttribute('disabled', 'disabled');
});