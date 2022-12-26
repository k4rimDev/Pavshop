from datetime import datetime
from django.utils import timezone
from django.shortcuts import render
from django.http import JsonResponse, HttpResponse, HttpRequest
from django.shortcuts import redirect
from django.http.response import HttpResponsePermanentRedirect
import json


from product.models import Product
from cart.models import Cart, CartItem, Discount
from cart.context_processors import cart_data
from core.models import Background


# Check cookies if cart exists
def check_basket(request: HttpRequest) -> HttpResponsePermanentRedirect:
    
    user = request.user
    cookie_cart = eval(request.COOKIES["cart"])

    cart, created = Cart.objects.get_or_create(user=user, complete=False)

    for key, value in cookie_cart.items():
        product = Product.objects.get(id = key)
        if cookie_cart[key]["color"] != "":
            cart_items, _created = CartItem.objects.get_or_create(user=user, product=product, color=cookie_cart[key]["color"])
        else:
            cart_items, _created = CartItem.objects.get_or_create(user=user, product=product)
        cart_items.quantity += cookie_cart[key]["quantity"]
        cart_items.cart = cart
        cart_items.save()

    return redirect("core:home") # type: ignore

# Default view
def shopping_cart(request: HttpRequest) -> HttpResponse: 
    cart_background = Background.objects.all()[0]
    cart_background = cart_background.cart_page
    data = cart_data(request)

    if request.method == "POST":
        if request.user.is_authenticated:
            cart: Cart = Cart.objects.get(user=request.user, complete=False)
            discount_code = request.POST.get("discount_code")
            discount_users = Discount.objects.filter(discount_code=discount_code).values_list("user", flat=True)
            discount = Discount.objects.filter(discount_code=discount_code).first()
            total = cart.get_cart_total
            if request.user in discount_users:
                ...
            else:
                if discount and discount.expiry_date > timezone.now():
                    cart.get_cart_total = total * discount.discount_percent / 100
                    cart.save()
                    cart.discount_price = total - cart.get_cart_total
                    discount.user.add(request.user)
                    discount.save()
                    cart.save()
                else:
                    ...

    context = {
        'title': 'Shopping Cart',
        'cart_background': cart_background,
        'items': data["items"],
        'cart_items': data["cart_items"],
        'cart_total': data["cart_total"],
    }
    return render(request, 'cart/shopping-cart.html', context=context)

def update_item(request):
    data = json.loads(request.body)
    productId = data['productId']
    action = data['action']
    color = data['color']

    user = request.user
    product = Product.objects.get(id = productId)
    cart, _created = Cart.objects.get_or_create(user = user, complete=False)
    cart_item, created = CartItem.objects.get_or_create(cart=cart, product=product, color=color)

    if action == 'add':
        cart_item.quantity = (cart_item.quantity + 1) # type: ignore
    elif action == 'remove':
        cart_item.quantity = (cart_item.quantity - 1) # type: ignore
    elif action == 'remove-all':
        cart_item.quantity = 0

    if color is not None:
        cart_item.color = color
    
    cart_item.user = user
    cart_item.save()

    if cart_item.quantity <= 0: # type: ignore
        cart_item.delete()

    return JsonResponse(cart_item.quantity, safe=False)

def whislist(request: HttpRequest) -> HttpResponse:
    context = {
        
    }
    return render(request, 'cart/whislist.html', context=context)
