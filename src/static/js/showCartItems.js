var cartItems = document.querySelector(".cart-items");
var cartPrice = document.querySelector(".cart-price");
var basketProductCount = document.querySelector(".basket-product-count");
var productQuantity = document.querySelector(".product-quantity");

var cartItemUrl = "http://127.0.0.1:8000/api/cart/cart-item/";
console.log(user);

function addCart(){
    if (user === null || user === undefined || user == "AnonymousUser") {
        console.log("User is anonymous");
      } else {
        fetch(`${cartItemUrl}${userId}`, {
          method: "GET",
          "Content-Type": "application/json",
        })
          .then((response) => {
            return response.json();
          })
      
          .then((data) => {
            console.log(data.cart_items);
            cartItems.innerHTML = "";
            basketProductCount.innerHTML = "";
            let sumQuantity = 0;
            let sumPrice = 0;
            cartPrice.innerHTML = `SUBTOTAL: ${sumPrice} USD`;
            for (let i = 0; i < data.cart_items.length; i++) {
              console.log(data.cart_items[i].quantity, "kermkerimkerimekr")
              sumQuantity += data.cart_items[i].quantity;
              sumPrice += data.cart_items[i].product.price * data.cart_items[i].quantity;
              cartItems.innerHTML += 
                  `
                        <li class="cart-items">
                          <div class="media-left">
                            <div class="cart-img">
                              <a href="#">
                                <img
                                  class="media-object img-responsive"
                                  src="${data.cart_items[i].product.main_image}"
                                  alt="..."
                                />
                              </a>
                            </div>
                          </div>
                          <div class="media-body">
                            <h6 class="media-heading">${data.cart_items[i].product.product_name}</h6>
                            <span class="price">${data.cart_items[i].product.price} USD</span>
                            <span class="qty">QTY: ${data.cart_items[i].quantity}</span>
                          </div>
                        </li>
                  `;
            }
            basketProductCount.innerHTML = sumQuantity;
            // if(productQuantity != null){
            //   productQuantity.innerHTML = sumQuantity;
            // }
            cartPrice.innerHTML = `SUBTOTAL: ${sumPrice} USD`;
          });
      }
      
}

addCart()