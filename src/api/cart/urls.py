from django.urls import path

from api.cart.views import (
    CartListAPIView, 
    CartItemListAPIView, 
    CartItemCreateAPIView, 
    CartCreateAPIView, 
    UserCartItemAPIView,
    DiscountListAPIView,
    CartUpdateAPIView,
    WishlistListCreateAPIView,
)


app_name = "api_cart"

urlpatterns = [
    # Cart and Order API
    path('', CartListAPIView.as_view(), name='cart_list'),
    path('create/', CartCreateAPIView.as_view(), name='cart_create'),
    path('cart-item', CartItemListAPIView.as_view(), name='cart_item_list'),
    path('cart-item/create/', CartItemCreateAPIView.as_view(), name='cart_item_create'),
    path('cart-item/<int:id>', UserCartItemAPIView.as_view(), name='user_cart_item'),

    path('discount/update', CartUpdateAPIView.as_view(), name='user_cart_discount_update'),

    
    path('discount/', DiscountListAPIView.as_view(), name='user_cart_discount'),

    # path('wishlist/', WishlistListCreateAPIView.as_view(), name='wishlist'),
    path('wishlist/<int:id>', WishlistListCreateAPIView.as_view(), name='wishlist-create'),
]
