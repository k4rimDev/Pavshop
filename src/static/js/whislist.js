let button = document.querySelectorAll(".update-whislist");
let url = "http://127.0.0.1:8000/api/cart/wishlist/";

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
// let csrftoken = document.querySelector("[name='csrfmiddlewaretoken']").value;
console.log(button)
button.forEach(element => {
    element.addEventListener("click", (e) =>{
        if (user==="AnonymousUser"){
            addCookieWhislist(element.dataset.product);
        }else{
            updateWhislist(element.dataset.product)
        }
    })
});

function updateWhislist(productId){
    fetch(`${url}${productId}`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `token ${token}`,
          "X-CSRFToken": csrftoken,
        },
      })
        .then((response) => {
          return response.json();
        })
    
        .then((data) => {
          console.log(data);
        });
}

function addCookieWhislist(productId) {
  
    if (action == "add") {
      if (cart[productId] == undefined) {
        cart[productId] = { quantity: 1 };
        if (color != undefined || color != null || color != "") {
          cart[productId] = {quantity: 1, color: color}
        }else{
          cart[productId] = {quantity: 1}
        }
      } else {
        cart[productId]["quantity"] += 1;
        if (color != undefined || color != null || color != "") {
          cart[productId] = {quantity: cart[productId]["quantity"] , color: color}
        }else{
          cart[productId] = {quantity: cart[productId]["quantity"]}
        }
      }
    }
  
    if (action == "remove") {
      cart[productId]["quantity"] -= 1;
  
      if (cart[productId]["quantity"] <= 0) {
        console.log("Item should be deleted");
        delete cart[productId];
      }
    }
    document.cookie = "cart=" + JSON.stringify(cart) + ";domain=;path=/";
  
    location.reload();
  }