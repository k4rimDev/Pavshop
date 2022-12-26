from django.urls import path
from order import views 

urlpatterns = [
    path('checkout', views.checkout, name = 'checkout'),
    path('terms', views.terms, name = 'terms'),
    path('order-success', views.order_success, name = 'order_success'),
    path('payment-complete', views.payment_complete_paypal, name = 'payment_complete_paypal'),
]