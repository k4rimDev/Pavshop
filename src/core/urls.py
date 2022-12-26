from django.urls import path
from . import views

app_name = 'core'

urlpatterns = [
    path("", views.home, name = 'home'),
    path("about", views.about, name = 'about'),
    # path("contact", views.ContactUs.as_view(), name = 'contact'),
    path("contact", views.contact, name = 'contact'),
]
