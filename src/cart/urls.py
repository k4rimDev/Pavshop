from django.urls import path

from cart import views

app_name = 'carts'


urlpatterns = [
    path('shopping-cart', views.shopping_cart, name = 'shopping-cart'),
    path("check_basket/", views.check_basket, name="check_basket"),
    path("update_item/", views.update_item, name="update_item"),
    path("whislist/", views.whislist, name="whislist"),
]