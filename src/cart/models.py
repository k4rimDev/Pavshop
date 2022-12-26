from datetime import datetime, timedelta
from django.db import models
from django.contrib.auth import get_user_model

from product.models import Product, Variation


User = get_user_model()

class Cart(models.Model):
    user = models.ForeignKey(User, related_name="cart", on_delete=models.CASCADE, null=False)
    date_added = models.DateTimeField(auto_now_add=True, null=True, blank=True) 
    complete = models.BooleanField(default=False)
    transaction_id = models.CharField(max_length=100, null=True)
    discount_percent = models.FloatField(default=0)

    def __str__(self):
        return self.user.email
    
    @property
    def shipping(self):
        shipping = False
        cart_items = self.cart_items.all()  # type: ignore
        for i in cart_items:
            if i.product.digital == False:
                shipping = True
        return shipping

    @property
    def get_cart_total(self):
        cart_items = self.cart_items.all()  # type: ignore
        total = sum([item.get_total for item in cart_items])
        total = total * (100 - self.discount_percent)/100
        return total 

    @property
    def get_cart_items(self):
        cart_items = self.cart_items.all()  # type: ignore
        total = sum([item.quantity for item in cart_items])
        return total

    def save(self, *args, **kwargs) -> None:
        cart_items = self.cart_items.all()
        self.total_price = sum([item.quantity for item in cart_items])
        super().save(*args, **kwargs)

class CartItem(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)

    cart = models.ForeignKey(Cart, related_name="cart_items", on_delete=models.SET_NULL, null=True)
    quantity = models.IntegerField(default=0, null=True, blank=True)
    color = models.CharField(max_length=128, null=True)
    date_added = models.DateTimeField(auto_now_add=True, null=True, blank=True)

    @property
    def get_total(self):
        total = self.product.price * self.quantity # type: ignore
        return total

    def __unicode__(self):
        return self.products

class Discount(models.Model):
    discount_code = models.CharField(max_length=128, null= True)
    discount_percent = models.IntegerField(default=0)
    lifetime = models.IntegerField(null=True)
    expiry_date = models.DateTimeField(auto_now_add=True)
    created_date = models.DateTimeField(auto_now_add=True, null=True)
    user = models.ManyToManyField(
        User,
        related_name="discount",
        null=True,
    )

    def save(self, *args, **kwargs) -> None:
        self.expiry_date = datetime.now() + timedelta(days=self.lifetime)
        super().save(*args, **kwargs)

class Whislist(models.Model):
    user = models.ForeignKey(
        User,
        related_name="whislist",
        on_delete=models.CASCADE
    )
    product = models.ForeignKey(
        Product,
        related_name="whislist",
        on_delete=models.CASCADE
    )
    is_liked = models.BooleanField(default=True)
