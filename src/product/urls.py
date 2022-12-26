from django.urls import path
from product import views


app_name = 'products'

urlpatterns = [
    path('', views.ProductListView.as_view(), name = 'products'),
    path('<slug:slug>', views.ProductDetailView.as_view(), name = 'product-detail'),
]