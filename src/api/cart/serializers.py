from rest_framework import serializers
from rest_framework.fields import SerializerMethodField

from cart.models import CartItem, Cart, Discount, Whislist

from api.product.serializers import ProductSerializer


class CartItemSerializer(serializers.ModelSerializer):
    product = ProductSerializer(
        read_only = True,
        many = False,
    )
    class Meta:
        model = CartItem
        fields = ["product", "user", "quantity", "cart"]

class CartSerializer(serializers.ModelSerializer):
    cart_items = CartItemSerializer(many=True, )
    user = SerializerMethodField()
    class Meta:
        model = Cart
        fields = ["user", "date_added", "complete", "transaction_id", "cart_items", "discount_percent"]


    def get_user(self, obj):
        return obj.user.full_name

class DiscountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Discount
        fields = ["discount_percent", "expiry_date"]

class CartUpdateDiscountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Cart
        fields = ["discount_percent"]


class WishlistSerializer(serializers.ModelSerializer):
    product = ProductSerializer(read_only=True)
    class Meta:
        model = Whislist
        fields = [
            "product",
            "is_liked",
        ]
