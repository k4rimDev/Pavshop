from django.contrib import admin
from .models import Order, Payment, Shipping, Billing

@admin.register(Shipping)
class ShippingAdmin(admin.ModelAdmin):
    list_display = ("address", "country", "city", )
    list_display_links = ("address",)

@admin.register(Billing)
class BillingAdmin(admin.ModelAdmin):
    list_display = ("first_name", "last_name", "address", )
    list_display_links = ("address",)

@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ("user_id", "ship_date", "order_date", )


@admin.register(Payment)
class PaymentAdmin(admin.ModelAdmin):
    list_display = ("payment_type", )
