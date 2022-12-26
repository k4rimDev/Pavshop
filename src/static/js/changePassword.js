function getToken(name) {
    var cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        const cookies = document.cookie.split(';');
        for (let i = 0; i < cookies.length; i++) {
            const cookie = cookies[i].trim();
            if (cookie.substring(0, name.length + 1) === (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}
let token = JSON.parse(getToken("token")).token;

let changePasswordUrl = "http://127.0.0.1:8000/api/user/change-password";

let changePasswordBtn = document.querySelector("#password-change-btn");


changePasswordBtn.addEventListener("click", function(e) {
    e.preventDefault();
    let current_password = document.querySelector("#id_old_password").value;
    let new_password = document.querySelector("#id_new_password1").value;
    let new_password_confirm = document.querySelector("#id_new_password2").value;
    let csrftoken = document.querySelector('[name="csrfmiddlewaretoken"]').value;

    fetch(changePasswordUrl, {
        method: 'PATCH',
        headers: {
            "Authorization": `token ${token}`,
            "Content-Type": "application/json",
            "X-CSRFToken": csrftoken,
        },
        body: JSON.stringify({current_password: current_password, new_password: new_password, new_password_confirm: new_password_confirm})
    })
    .then(response => {
        console.log(response);
    })
    .then(data => console.log(data))
});
