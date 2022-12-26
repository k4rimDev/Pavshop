from django.contrib import admin

from core.models import (
    Subscription, 
    Staff, 
    Contact, 
    Slider,
    Background,
    Feedback,
    Sponsor,
    About,
    AwesomeCulture, 
)


@admin.register(Subscription)
class SubscriptionAdmin(admin.ModelAdmin):
    list_display = ("subscription_email", )

@admin.register(Staff)
class StaffAdmin(admin.ModelAdmin):
    list_display = ("full_name", "facebook_url", "twitter_url", "website_url", "email", "image", "position", "description")

@admin.register(Sponsor)
class SponsorAdmin(admin.ModelAdmin):
    list_display = ("image", )

@admin.register(About)
class AboutAdmin(admin.ModelAdmin):
    list_display = ("main_image", "about_header_text", "about_footer_text")

@admin.register(AwesomeCulture)
class AwesomeCultureAdmin(admin.ModelAdmin):
    list_display = ("image", )


@admin.register(Feedback)
class FeedbackAdmin(admin.ModelAdmin):
    list_display = ("author", "text")
@admin.register(Background)
class BackgroundAdmin(admin.ModelAdmin):
    list_display = ("home_page", "about_page", "contact_page", "login_register_page", "order_page", "cart_page", "product_page")

@admin.register(Contact)
class ContactAdmin(admin.ModelAdmin):
    list_display = ("full_name", "email", )
    search_fields = ('full_name', 'email', )

@admin.register(Slider)
class SliderAdmin(admin.ModelAdmin):
    list_display = ("title", "description", "price", )
