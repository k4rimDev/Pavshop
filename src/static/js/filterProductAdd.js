let brands = document.querySelector("#shop-brand");
let colors = document.querySelector("#shop-color");
let categories = document.querySelector("#shop-category");
let tags = document.querySelector("#shop-tag");
let sorting = document.querySelector("#filter-sorting");
let productContainer = document.querySelector("#productsContainer");

let brandApiUrl = "http://127.0.0.1:8000/api/product/brand/";
let colorApiUrl = "http://127.0.0.1:8000/api/product/color/";
let categoryApiUrl = "http://127.0.0.1:8000/api/product/category/";
let tagApiUrl = "http://127.0.0.1:8000/api/product/tag/";
let productListApiUrl = "http://127.0.0.1:8000/api/product/";

let urlstring = "?";

let link = window.location.href;
let indexOfQuery = link.indexOf("?");
let query = "";
if (indexOfQuery > 0) {
    query = link.slice(indexOfQuery, link.length);
    urlstring = query;
  
    // Post filter
    productContainer.innerHTML = "";
      fetch(`${productListApiUrl}${urlstring}`)
        .then((response) => {
          return response.json();
        })
        .then((data) => {
            productContainer.innerHTML = "";
          for (let i = 0; i < data.length; i++) {
            productContainer.innerHTML += `
                <div class="col-md-4">
              <div class="item">
                <!-- Item img -->
                <div class="item-img">
                  <img
                    class="img-1"
                    src="${data[i].main_image}"
                    alt=""
                  />
                  <!-- Overlay -->
                  <div class="overlay">
                    <div class="position-center-center">
                      <div class="inn">
                        <a href="${data[i].main_image}" data-lighter
                          ><i class="icon-magnifier"></i
                        ></a>
                        <a
                          class="update-basket"
                          href="#."
                          data-product="${data[i].id}"
                          data-action="add"
                          data-color=""
                          ><i class="icon-basket"></i
                        ></a>
                        <a href="#." class="update-whislist" data-product="${data[i].id}"><i class="icon-heart"></i></a>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- Item Name -->
                <div class="item-name">
                  <a href="${data[i].slug}"
                    >${data[i].product_name}</a
                  >
                  <p>${data[i].brief_info}</p>
                </div>
                <!-- Price -->
                <span class="price"><small>$</small>${data[i].price}</span>
              </div>
            </div>
                `;
          }
        })
        .then(data => {
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
              console.log("kerm")
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
        });
  }

function getPrice(min, max){
    if (urlstring.includes("min_price")){
        if (urlstring.indexOf("&", urlstring.indexOf("max_price")) < 0) {
            if(urlstring.charAt(urlstring.indexOf("min_price") - 2) == "?"){
                    urlstring = "?";
              }else{
                urlstring = urlstring.replace(
                    urlstring.slice(
                      urlstring.indexOf("min_price") - 1),
                    ""
                  );
              }
            
          } else {
            urlstring = urlstring.replace(
                urlstring.slice(
                  urlstring.indexOf("min_price"),
                  urlstring.indexOf("&", urlstring.indexOf("max_price")) + 1
                ),
                ""
              );
          }

    }else{
        urlstring += `&min_price=${min.slice(1, min.length)}&max_price=${max.slice(1, max.length)}`;
        if (urlstring.charAt(1) == "&"){
          urlstring = urlstring.replace(urlstring.charAt(1), "");
        }else{
          urlstring = urlstring.replace(urlstring.charAt(0), "?");
        }
        
        history.pushState(
            null,
            null,
            urlstring
          );
    }

      fetch(`${productListApiUrl}${urlstring}`)
        .then((response) => {
          return response.json();
        })
        .then((data) => {
          console.log(data)
            productContainer.innerHTML = "";
          for (let i = 0; i < data.length; i++) {
            productContainer.innerHTML += `
                <div class="col-md-4">
              <div class="item">
                <!-- Item img -->
                <div class="item-img">
                  <img
                    class="img-1"
                    src="${data[i].main_image}"
                    alt=""
                  />
                  <!-- Overlay -->
                  <div class="overlay">
                    <div class="position-center-center">
                      <div class="inn">
                        <a href="${data[i].main_image}" data-lighter
                          ><i class="icon-magnifier"></i
                        ></a>
                        <a
                          class="update-basket"
                          href="#."
                          data-product="${data[i].id}"
                          data-action="add"
                          data-color=""
                          ><i class="icon-basket"></i
                        ></a>
                        <a href="#." class="update-whislist" data-product="${data[i].id}"><i class="icon-heart"></i></a>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- Item Name -->
                <div class="item-name">
                  <a href="${data[i].slug}"
                    >${data[i].product_name}</a
                  >
                  <p>${data[i].brief_info}</p>
                </div>
                <!-- Price -->
                <span class="price"><small>$</small>${data[i].price}</span>
              </div>
            </div>
                `;
          }
        })
        .then(data => {
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
              console.log("kerm")
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

          let button = document.querySelectorAll(".update-whislist");
let url = "http://127.0.0.1:8000/api/cart/wishlist/";
            console.log(button)

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
        })
}

// Brands
fetch(brandApiUrl)
  .then((response) => response.json())
  .then((data) => {
    for (let i = 0; i < data.results.length; i++) {
      brands.innerHTML += `
            <li><a data-name="brand" data-value='${data.results[i].name}' class="brand">${data.results[i].name}</a></li>
        `;
    }
  })
  .then(() => {
    var brandList = document.querySelectorAll(".brand");
    brandList.forEach((brandListItem) => {
      brandListItem.addEventListener("click", function (e) {
        e.preventDefault();

        if (
            urlstring.indexOf("&", urlstring.indexOf(`${this.dataset.name}`)) < 0
          ) {
            if(urlstring.charAt(urlstring.indexOf(`${this.dataset.name}`) - 2) == "?"){
                    urlstring = "?";
              }else{
                urlstring = urlstring.replace(
                    urlstring.slice(
                      urlstring.indexOf(`${this.dataset.name}`) - 1),
                    ""
                  );
              }
            
          } else {
            urlstring = urlstring.replace(
              urlstring.slice(
                urlstring.indexOf(`${this.dataset.name}`),
                urlstring.indexOf(
                  "&",
                  urlstring.indexOf(`${this.dataset.name}`)
                ) + 1
              ),
              ""
            );
          }
        for (elem of brandList) {
          if (elem != this) {
            elem.classList.remove("active-filter");
          }
        }
        if (this.classList.contains("active-filter")) {
          urlstring = urlstring.replace(
            `${this.dataset.name}=${this.dataset.value}&`,
            ""
          );
        } else {
          urlstring = urlstring + `&${this.dataset.name}=${this.dataset.value}`;
        }
        this.classList.toggle("active-filter");

        if (urlstring.charAt(1) == "&"){
          urlstring = urlstring.replace(urlstring.charAt(1), "");
        }else{
          urlstring = urlstring.replace(urlstring.charAt(0), "?");
        }

        history.pushState(
          null,
          null,
          urlstring
        );

        fetch(`${productListApiUrl}${urlstring}`)
        .then((response) => {
          return response.json();
        })

        fetch(`${productListApiUrl}${urlstring}`)
        .then((response) => {
          return response.json();
        })
        .then((data) => {
          console.log(data)
          productContainer.innerHTML = "";
          for (let i = 0; i < data.length; i++) {
            productContainer.innerHTML += `
                <div class="col-md-4">
              <div class="item">
                <!-- Item img -->
                <div class="item-img">
                  <img
                    class="img-1"
                    src="${data[i].main_image}"
                    alt=""
                  />
                  <!-- Overlay -->
                  <div class="overlay">
                    <div class="position-center-center">
                      <div class="inn">
                        <a href="${data[i].main_image}" data-lighter
                          ><i class="icon-magnifier"></i
                        ></a>
                        <a
                          class="update-basket"
                          href="#."
                          data-product="${data[i].id}"
                          data-action="add"
                          data-color=""
                          ><i class="icon-basket"></i
                        ></a>
                        <a href="#." class="update-whislist" data-product="${data[i].id}"><i class="icon-heart"></i></a>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- Item Name -->
                <div class="item-name">
                  <a href="${data[i].slug}"
                    >${data[i].product_name}</a
                  >
                  <p>${data[i].brief_info}</p>
                </div>
                <!-- Price -->
                <span class="price"><small>$</small>${data[i].price}</span>
              </div>
            </div>
                `;
          }
        })
        .then(data => {
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
              console.log("kerm")
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
        });
      });
    });
  });

// Colors
fetch(colorApiUrl)
  .then((response) => response.json())
  .then((data) => {
    for (let i = 0; i < data.results.length; i++) {
      colors.innerHTML += `
                <li><a data-name="color" data-value='${data.results[i].name}' class="color" style="background:${data.results[i].color}"></a></li>
            `;
    }
  })
  .then(() => {
    var colorList = document.querySelectorAll(".color");
    let colorStr = [];
    colorList.forEach((colorListItem) => {
      colorListItem.addEventListener("click", function (e) {
        e.preventDefault();

        if (urlstring.indexOf("&", urlstring.indexOf(`${this.dataset.name}`)) > 0){
            urlstring = urlstring.replace(
                urlstring.slice(
                  urlstring.indexOf(`${this.dataset.name}`),
                  urlstring.indexOf("&", urlstring.indexOf(`${this.dataset.name}`)) +
                    1
                ),
                ""
              );
        }else{
            if(urlstring.charAt(urlstring.indexOf(`${this.dataset.name}`) - 2) == "?"){
                urlstring = "?";
          }else{
            urlstring = urlstring.replace(
                urlstring.slice(
                  urlstring.indexOf(`${this.dataset.name}`) - 1),
                ""
              );
          }
        }
        

        if (colorStr.includes(this.dataset.value)){
            colorStr.splice(colorStr.indexOf(`${this.dataset.value}`), 1)
        }else{
            colorStr.push(this.dataset.value);
        }

        if (colorStr.length == 0){
            console.log("dsfsdfsfs sfsdfs")
            urlstring = urlstring.replace(
                urlstring.slice(
                  urlstring.indexOf(`${this.dataset.name}`),
                  urlstring.indexOf("&", urlstring.indexOf(`${this.dataset.name}`)) +
                    1
                ),
                ""
              );
        }else{
            urlstring = urlstring + `&${this.dataset.name}=${colorStr.toString()}`;
        }

        this.classList.toggle("active-filter");

        if (urlstring.charAt(1) == "&"){
          urlstring = urlstring.replace(urlstring.charAt(1), "");
        }else{
          urlstring = urlstring.replace(urlstring.charAt(0), "?");
        }

        history.pushState(
          null,
          null,
          urlstring
        );

        fetch(`${productListApiUrl}${urlstring}`)
        .then((response) => {
          return response.json();
        })
        .then((data) => {
          console.log(data)
          productContainer.innerHTML = "";
          for (let i = 0; i < data.length; i++) {
            productContainer.innerHTML += `
                <div class="col-md-4">
              <div class="item">
                <!-- Item img -->
                <div class="item-img">
                  <img
                    class="img-1"
                    src="${data[i].main_image}"
                    alt=""
                  />
                  <!-- Overlay -->
                  <div class="overlay">
                    <div class="position-center-center">
                      <div class="inn">
                        <a href="${data[i].main_image}" data-lighter
                          ><i class="icon-magnifier"></i
                        ></a>
                        <a
                          class="update-basket"
                          href="#."
                          data-product="${data[i].id}"
                          data-action="add"
                          data-color=""
                          ><i class="icon-basket"></i
                        ></a>
                        <a href="#." class="update-whislist" data-product="${data[i].id}"><i class="icon-heart"></i></a>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- Item Name -->
                <div class="item-name">
                  <a href="${data[i].slug}"
                    >${data[i].product_name}</a
                  >
                  <p>${data[i].brief_info}</p>
                </div>
                <!-- Price -->
                <span class="price"><small>$</small>${data[i].price}</span>
              </div>
            </div>
                `;
          }
        })
        .then(data => {
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
              console.log("kerm")
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
        });
      });
    });
  });

// Categories
fetch(categoryApiUrl)
  .then((response) => response.json())
  .then((data) => {
    for (let i = 0; i < data.results.length; i++) {
      categories.innerHTML += `
                <li><a data-name="category" data-value='${data.results[i].name}' class="category">${data.results[i].name}</a></li>
            `;
    }
  })
  .then(() => {
    var categoryList = document.querySelectorAll(".category");
    categoryList.forEach((categoryListItem) => {
      categoryListItem.addEventListener("click", function (e) {
        e.preventDefault();

        if (urlstring.indexOf("&", urlstring.indexOf(`${this.dataset.name}`)) < 0) {
            if(urlstring.charAt(urlstring.indexOf(`${this.dataset.name}`) - 2) == "?"){
                urlstring = "?";
          }else{
              urlstring = urlstring.replace(
                  urlstring.slice(
                    urlstring.indexOf(`${this.dataset.name}`) - 1),
                  ""
                );
          }
        } else {
          urlstring = urlstring.replace(
            urlstring.slice(
              urlstring.indexOf(`${this.dataset.name}`),
              urlstring.indexOf(
                "&",
                urlstring.indexOf(`${this.dataset.name}`)
              ) + 1
            ),
            ""
          );
        }

        for (elem of categoryList) {
          if (elem != this) {
            elem.classList.remove("active-filter");
          }
        }
        if (this.classList.contains("active-filter")) {
          urlstring = urlstring.replace(
            `${this.dataset.name}=${this.dataset.value}&`,
            ""
          );
        } else {
          urlstring = urlstring + `&${this.dataset.name}=${this.dataset.value}`;
        }
        this.classList.toggle("active-filter");

        if (urlstring.charAt(1) == "&"){
          urlstring = urlstring.replace(urlstring.charAt(1), "");
        }else{
          urlstring = urlstring.replace(urlstring.charAt(0), "?");
        }

        history.pushState(
          null,
          null,
          urlstring
        );

        fetch(`${productListApiUrl}${urlstring}`)
        .then((response) => {
          return response.json();
        })
        .then((data) => {
          console.log(data)
          productContainer.innerHTML = "";
          for (let i = 0; i < data.length; i++) {
            productContainer.innerHTML += `
                <div class="col-md-4">
              <div class="item">
                <!-- Item img -->
                <div class="item-img">
                  <img
                    class="img-1"
                    src="${data[i].main_image}"
                    alt=""
                  />
                  <!-- Overlay -->
                  <div class="overlay">
                    <div class="position-center-center">
                      <div class="inn">
                        <a href="${data[i].main_image}" data-lighter
                          ><i class="icon-magnifier"></i
                        ></a>
                        <a
                          class="update-basket"
                          href="#."
                          data-product="${data[i].id}"
                          data-action="add"
                          data-color=""
                          ><i class="icon-basket"></i
                        ></a>
                        <a href="#." class="update-whislist" data-product="${data[i].id}"><i class="icon-heart"></i></a>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- Item Name -->
                <div class="item-name">
                  <a href="${data[i].slug}"
                    >${data[i].product_name}</a
                  >
                  <p>${data[i].brief_info}</p>
                </div>
                <!-- Price -->
                <span class="price"><small>$</small>${data[i].price}</span>
              </div>
            </div>
                `;
          }
        })
        .then(data => {
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
              console.log("kerm")
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
        });
      });
    });
  });

// Tags
fetch(tagApiUrl)
  .then((response) => response.json())
  .then((data) => {
    console.log(data.results[0].tag_name);
    for (let i = 0; i < data.results.length; i++) {
      tags.innerHTML += `
                <li><a data-name="tag" data-value=${data.results[i].tag_name.name} class="tag">${data.results[i].tag_name.name}</a></li>
            `;
    }
  })
  .then(() => {
    var tagList = document.querySelectorAll(".tag");
    tagList.forEach((tagListItem) => {
      tagListItem.addEventListener("click", function (e) {
        e.preventDefault();

        if (
          urlstring.indexOf("&", urlstring.indexOf(`${this.dataset.name}`)) < 0
        ) {
            if(urlstring.charAt(urlstring.indexOf(`${this.dataset.name}`) - 2) == "?"){
                  urlstring = "?";
            }else{
                urlstring = urlstring.replace(
                    urlstring.slice(
                      urlstring.indexOf(`${this.dataset.name}`) - 1),
                    ""
                  );
            }
          
        } else {
          urlstring = urlstring.replace(
            urlstring.slice(
              urlstring.indexOf(`${this.dataset.name}`),
              urlstring.indexOf(
                "&",
                urlstring.indexOf(`${this.dataset.name}`)
              ) + 1
            ),
            ""
          );
        }
        for (elem of tagList) {
          if (elem != this) {
            elem.classList.remove("active-filter");
          }
        }
        if (this.classList.contains("active-filter")) {
          urlstring = urlstring.replace(
            `${this.dataset.name}=${this.dataset.value}&`,
            ""
          );
        } else {
          urlstring = urlstring + `&${this.dataset.name}=${this.dataset.value}`;
        }
        this.classList.toggle("active-filter");

        if (urlstring.charAt(1) == "&"){
          urlstring = urlstring.replace(urlstring.charAt(1), "");
        }else{
          urlstring = urlstring.replace(urlstring.charAt(0), "?");
        }

        history.pushState(
          null,
          null,
          urlstring
        );

        fetch(`${productListApiUrl}${urlstring}`)
        .then((response) => {
          return response.json();
        })
        .then((data) => {
          console.log(data)
          productContainer.innerHTML = "";
          for (let i = 0; i < data.length; i++) {
            productContainer.innerHTML += `
                <div class="col-md-4">
              <div class="item">
                <!-- Item img -->
                <div class="item-img">
                  <img
                    class="img-1"
                    src="${data[i].main_image}"
                    alt=""
                  />
                  <!-- Overlay -->
                  <div class="overlay">
                    <div class="position-center-center">
                      <div class="inn">
                        <a href="${data[i].main_image}" data-lighter
                          ><i class="icon-magnifier"></i
                        ></a>
                        <a
                          class="update-basket"
                          href="#."
                          data-product="${data[i].id}"
                          data-action="add"
                          data-color=""
                          ><i class="icon-basket"></i
                        ></a>
                        <a href="#." class="update-whislist" data-product="${data[i].id}"><i class="icon-heart"></i></a>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- Item Name -->
                <div class="item-name">
                  <a href="${data[i].slug}"
                    >${data[i].product_name}</a
                  >
                  <p>${data[i].brief_info}</p>
                </div>
                <!-- Price -->
                <span class="price"><small>$</small>${data[i].price}</span>
              </div>
            </div>
                `;
          }
        })
        .then(data => {
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
              console.log("kerm")
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
        });
      });
    });
  });

// Sorting
sorting.addEventListener("change", function (e) {
  let value = sorting.options[sorting.selectedIndex].getAttribute("name");
  let order_str = "";
  if (value != null){
    order_str = `&order_by=${value}`;
   }
//else{
//     if (
//         urlstring.indexOf("&", urlstring.indexOf("order_by")) < 0
//       ) {
//           if(urlstring.charAt(urlstring.indexOf("order_by") - 2) == "?"){
//                 urlstring = "?";
//           }else{
//               urlstring = urlstring.replace(
//                   urlstring.slice(
//                     urlstring.indexOf("order_by") - 1),
//                   ""
//                 );
//           }
        
//       } else {
//         urlstring = urlstring.replace(
//           urlstring.slice(
//             urlstring.indexOf("order_by"),
//             urlstring.indexOf(
//               "&",
//               urlstring.indexOf("order_by")
//             ) + 1
//           ),
//           ""
//         );
//       }
//   }
  if (
    urlstring.indexOf("&", urlstring.indexOf("order_by")) < 0
  ) {
      if(urlstring.charAt(urlstring.indexOf("order_by") - 2) == "?"){
            urlstring = "?";
      }else{
          urlstring = urlstring.replace(
              urlstring.slice(
                urlstring.indexOf("order_by") - 1),
              ""
            );
      }
    
  } else {
    urlstring = urlstring.replace(
      urlstring.slice(
        urlstring.indexOf("order_by"),
        urlstring.indexOf(
          "&",
          urlstring.indexOf("order_by")
        ) + 1
      ),
      ""
    );
  }

  urlstring += order_str;
  console.log(urlstring);
  if (urlstring.charAt(1) == "&"){
    urlstring = urlstring.replace(urlstring.charAt(1), "");
  }else{
    urlstring = urlstring.replace(urlstring.charAt(0), "?");
  }
  history.pushState(null, null, urlstring);

  fetch(`${productListApiUrl}${urlstring}`)
    .then((response) => {
      return response.json();
    })
    .then((data) => {
      console.log(data)
      productContainer.innerHTML = "";
          for (let i = 0; i < data.length; i++) {
            productContainer.innerHTML += `
                <div class="col-md-4">
              <div class="item">
                <!-- Item img -->
                <div class="item-img">
                  <img
                    class="img-1"
                    src="${data[i].main_image}"
                    alt=""
                  />
                  <!-- Overlay -->
                  <div class="overlay">
                    <div class="position-center-center">
                      <div class="inn">
                        <a href="${data[i].main_image}" data-lighter
                          ><i class="icon-magnifier"></i
                        ></a>
                        <a
                          class="update-basket"
                          href="#."
                          data-product="${data[i].id}"
                          data-action="add"
                          data-color=""
                          ><i class="icon-basket"></i
                        ></a>
                        <a href="#." class="update-whislist" data-product="${data[i].id}"><i class="icon-heart"></i></a>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- Item Name -->
                <div class="item-name">
                  <a href="${data[i].slug}"
                    >${data[i].product_name}</a
                  >
                  <p>${data[i].brief_info}</p>
                </div>
                <!-- Price -->
                <span class="price"><small>$</small>${data[i].price}</span>
              </div>
            </div>
                `;
      }
    })
    .then(data => {
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
          console.log("kerm")
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
    });
});
