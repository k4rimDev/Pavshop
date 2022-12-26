from datetime import timedelta, datetime

from django.db import models
from django.conf import settings
from django.utils.translation import gettext_lazy as _
from cart.models import Cart

from django.contrib.auth import get_user_model
import uuid

from product.models import Product


User = get_user_model()


class Billing(models.Model):
    
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        related_name="billings",
        on_delete=models.CASCADE,
        null=True
    )
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    address = models.CharField(max_length=200)
    phone = models.CharField(max_length=15, null=False, blank=True)

    def __str__(self) -> str:
        return self.first_name + ' ' + self.last_name

class Order(models.Model):
    order_number = models.UUIDField(unique=True, default=uuid.uuid4)
    transaction_id = models.CharField(max_length=128, null=True)
    
    STATUS = (
        ('New', 'New'),
        ('Accepted', 'Accepted'),
        ('Preaparing', 'Preaparing'),
        ('OnShipping', 'OnShipping'),
        ('Completed', 'Completed'),
        ('Canceled', 'Canceled'),
    )

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        related_name="orders",
        on_delete=models.CASCADE,
    )

    payment = models.ForeignKey(
        "Payment",
        on_delete=models.CASCADE,
        related_name="orders",
        null=True,
    )

    shipping = models.ForeignKey(
        "Shipping",
        on_delete=models.CASCADE,
        related_name="orders",
    )
    ship_date = models.DateTimeField(auto_now_add=True)
    order_date = models.DateTimeField(auto_now_add=True)
    shipping_price = models.FloatField(null=True, default=10.0)
    delivery_date = models.DateTimeField(auto_now_add=True, null=True)
    billing_info = models.ForeignKey(
        "Billing",
        on_delete=models.CASCADE,
        related_name="billing_info",
        null=True
    )

    def __str__(self) -> str:
        return self.user.email

    def save(self, *args, **kwargs) -> None:
        self.delivery_date = datetime.now() + timedelta(days=10)
        self.transaction_id = datetime.now().timestamp()
        
        super().save(*args, **kwargs)
    
    @property
    def get_products(self) -> Product:
        return self.order_item.product

class OrderItem(models.Model):
    user = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name="order_item",
    )
    cart = models.ForeignKey(
        Cart,
        on_delete=models.CASCADE,
        related_name="order_item"
    )
    product = models.ForeignKey(
        "product.Product",
        on_delete=models.CASCADE,
        related_name="order_item",
    )
    quantity = models.IntegerField(
        default=1
    )
    color = models.CharField(
       max_length=128,
        null=True
    )
    subtotal = models.FloatField(default=0)
    total = models.FloatField(default=0)
    order = models.ForeignKey(
        Order,
        on_delete=models.CASCADE,
        related_name="order_item",
        null=True
    )
    complete = models.BooleanField(
        default=False
    )

class Payment(models.Model):
    CARD = "card"
    CASH = "cash"
    PAYMEMT_TYPES = (
        (CARD, _("kartla")),
        (CASH, _("nağd")),
    )

    is_paid = models.BooleanField(default=False)
    payment_date = models.DateTimeField(auto_now_add=True, null=True)
    payment_type = models.CharField(choices=PAYMEMT_TYPES, max_length=30)
    is_allowed = models.BooleanField(default=False)

    def __str__(self) -> str:
        return self.payment_type


class Shipping(models.Model):

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        related_name="shipping",
        on_delete=models.CASCADE
    )
    address = models.TextField()
    country = models.CharField(max_length=255)
    city = models.CharField(max_length=255)
    region = models.CharField(max_length=255, null=True, blank=False)
    zipcode = models.IntegerField(null=True, blank=False)
    phone = models.CharField(max_length=15, null=False, blank=True)
    company_name = models.CharField(max_length=128, null=True, blank=True)

    def __str__(self) -> str:
        return self.city
