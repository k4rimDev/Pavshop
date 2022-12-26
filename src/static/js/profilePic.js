let cartContainer = document.getElementById("cart-container");
let imageBtn = document.getElementById("imageBtn");
let csrftoken = document.querySelector("[name='csrfmiddlewaretoken']").value;

function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#imagePreview').css('background-image', 'url('+e.target.result +')');
            $('#imagePreview').hide();
            $('#imagePreview').fadeIn(650);

            fetch("http://127.0.0.1:8000/api/user/change-profilepic", {
                method: 'PATCH',
                headers: {
                    "Content-Type": "application/json",
                    "X-CSRFToken": csrftoken,
                    "Authorization": `token ${token}`
                },
                body: JSON.stringify({ new_image: e.target.result })
            })
            .then(response => {response.json()})
            .then(data => console.log(data))
        }
        reader.readAsDataURL(input.files[0]);
    }
}

$("#imageUpload").change(function() {
    readURL(this);
});


// imageBtn.addEventListener('click', function(e) {
//     e.preventDefault();
//     var input = document.querySelector('input[type="file"]')
//     console.log(input)
//     var csrftoken = document.querySelector('input[name="csrfmiddlewaretoken"]').value

//     fetch("http://127.0.0.1:8000/api/user/change-profilepic", {
//         method: 'PATCH',
//         headers: {
//             "Content-Type": "multipart/form-data",
//             "X-CSRFToken": csrftoken,
//             "Authorization": `token ${token}`
//         },
//         body: JSON.stringify({ new_image: input.files })
//     })
//     .then(response => {response.json()})
//     .then(data => console.log(data))
// })