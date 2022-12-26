from cart.context_processors import cart_data
from cart.models import Cart, CartItem
import json
from django.http import JsonResponse


from core.models import Background

from django.shortcuts import render
from django.http.request import HttpRequest
from django.http.response import HttpResponse
from django.contrib.auth.decorators import login_required
from django.shortcuts import redirect

from order.forms import ShippingForm, BillingForm, OrderForm
from order.models import Billing, Shipping, Order, OrderItem


@login_required(login_url="/accounts/login")
def checkout(request: HttpRequest) -> HttpResponse: 
    order_image = Background.objects.all()[0].order_page
    user = request.user
    billing = Billing.objects.get(user = user)
    shipping = Shipping.objects.get(user = user)

    shipping_form = ShippingForm(initial={"phone": shipping.phone, "country": shipping.country, "city": shipping.city, "zipcode": shipping.zipcode, "address": shipping.address})
    billing_form = BillingForm(initial={"phone": billing.phone, "first_name": billing.first_name, "last_name": billing.last_name, "address": billing.address})
    if request.method == "POST":
        if 'shipping_form' in request.POST:
            shipping_form = ShippingForm(request.POST)
            # if shipping_form.is_valid():
            #     shipping_form = shipping_form.save(commit=False)
            #     shipping_form.user = user
            #     shipping_form.save()
            # else:
            #     print("non validate shipping_form")

            shipping.company_name = request.POST.get('company_name')
            shipping.country = request.POST.get('country')
            shipping.address = request.POST.get('address')
            shipping.phone = request.POST.get('phone')
            shipping.city = request.POST.get('city')
            shipping.zipcode = request.POST.get('zipcode')

            shipping.save()
        
        if 'billing_form' in request.POST:
            # billing_form = BillingForm(request.POST)
            # if billing_form.is_valid():
            #     billig_form = billing_form.save(commit=False)
            #     billing_form.user = user
            #     billig_form.save()
            # else:
            #     print("non validate billing_form")
            
            billing.address = request.POST.get('address')
            billing.first_name = request.POST.get('first_name')
            billing.last_name = request.POST.get('last_name')
            billing.phone = request.POST.get('phone')

            billing.save()
        
        if 'order_form' in request.POST:
            billing: Billing = Billing.objects.get(user_id = user)
            shipping: Shipping = Shipping.objects.get(user = user)
            cart: Cart = Cart.objects.get(user = user, complete = False)
            cart_item = CartItem.objects.filter(user = user)
            order = Order.objects.create(
                user = user,
                billing_info = billing,
                shipping = shipping,
            )

            if cart.get_cart_items > 0:
                cart.complete = True
                cart.save()

            for cartitem in cart.cart_items.all():
                if cartitem.color != None or cartitem.color != "":
                    cartitem.product.order_count += 1
                    cartitem.product.save()
                    order_item = OrderItem.objects.create(
                        user=user,
                        cart=cart,
                        order=order,
                        product=cartitem.product,
                        quantity=cartitem.quantity,
                        color=cartitem.color,
                    )
                else:
                    order_item = OrderItem.objects.create(
                        user=user,
                        cart=cart,
                        order=order,
                        product_id=cartitem.product,
                        quantity=cartitem.quantity,
                    )
                order_item.subtotal = cart.get_cart_total
                order_item.total = order_item.subtotal + order.shipping_price 
                order_item.save()

            order.save()
            cart_item.delete()
            return redirect("order_success")

    data = cart_data(request)
    
    

    context = {
        'shipping_form': shipping_form,
        'billing_form': billing_form,
        'title': 'Checkout',
        'order_image': order_image,
        'items': data["items"],
        'cart_total': data["cart_total"],
    }
    return render(request, 'order/checkout.html', context=context)
    
def terms(request: HttpRequest) -> HttpResponse:
    return render(request, "order/terms-conditions.html")

@login_required(login_url="accounts/login")
def order_success(request: HttpRequest) -> HttpResponse:
    user=request.user
    order = Order.objects.filter(user=user).last()
    order_items = OrderItem.objects.filter(order=order)
    context = {
        "order": order,
        "subtotal": order.order_item.all()[0].subtotal,
        "total": order.order_item.all()[0].total,
        "order_items": order_items
    }
    return render(request, "order/order_success.html", context=context)

@login_required(login_url="accounts/login")
def payment_complete_paypal(request: HttpRequest) -> None:
    body = json.loads(request)
    print(body)

    return JsonResponse("Payment complete successfully")
