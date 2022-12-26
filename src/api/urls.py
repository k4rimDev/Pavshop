from django.urls import path, include
from rest_framework_simplejwt.views import TokenRefreshView
from . import views


app_name = "api"

urlpatterns = [
    
    # User  urls
    path('user/', include(("api.users.urls", "api-users")), name='api_users'),

    # Product urls
    path('product/', include(("api.product.urls", "api-product")), name='api_product'),

    # Blog urls
    path("blog/", include(("api.blog.urls", "api-blog")), name="api_blog"),
    
    # Cart
    path('cart/', include('api.cart.urls', "api-urlscart"), name="api_cart"),

    path('about/statistics', views.StatisticsAPIView.as_view(), name="statistics"),
    
    path('about/sponsor', views.AboutSponsorsListApiView.as_view(), name="sponsors"),
    
    path('about/staff', views.AboutStaffListApiView.as_view(), name="staffs"),
]
