from django.contrib import admin

from cart.models import CartItem, Cart, Discount, Whislist


@admin.register(CartItem)
class CartItemAdmin(admin.ModelAdmin):
    list_display = ("user", "product", "quantity", )

@admin.register(Cart)
class CartAdmin(admin.ModelAdmin):
    list_display = ("user", )

@admin.register(Discount)
class DiscountAdmin(admin.ModelAdmin):
    list_display = ("discount_code", "lifetime")


@admin.register(Whislist)
class WishlistAdmin(admin.ModelAdmin):
    list_display = ("user", "product")
