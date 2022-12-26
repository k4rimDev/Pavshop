"use strict";

var productBtn = document.getElementsByClassName("update-basket");
var postUrl = "http://localhost:8000/api/cart-item/create/";
var getUrl = "http://localhost:8000/api/cart-item";
var productColor = document.querySelectorAll(".specProductColor");


if (productColor != null) {
  productColor.forEach(item => {
    item.addEventListener("click", () => {
      // productBtn.dataset.color=item.dataset.color;
      productBtn[0].setAttribute("data-color", item.dataset.color)
    });
  });
}

for (let i = 0; i < productBtn.length; i++) {
  productBtn[i].addEventListener("click", function () {
    let productId = this.dataset.product;
    let action = this.dataset.action;
    let color = this.dataset.color

    if (user === "AnonymousUser") {
      addCookieItem(productId, action, color);
    } else {
      console.log(productId, action);
      updateUserCart(productId, action, color);
    }
  });
}

function updateUserCart(productId, action, color) {
  var url = "http://127.0.0.1:8000/cart/update_item/";
  if (color == null || color == undefined) {
    color = "";
  }

  fetch(url, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "X-CSRFToken": csrftoken,
    },
    body: JSON.stringify({ productId: productId, action: action, color: color }),
  })
    .then((response) => {
      return response.json();
    })

    .then((data) => {
      addCart();
    });
}

function addCookieItem(productId, action, color) {
  console.log("User is not authenticated");

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

