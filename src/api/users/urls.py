from django.urls import path
from api.users import views
from rest_framework_simplejwt.views import TokenRefreshView
from knox import views as knox_views



urlpatterns = [

    # User APIs
    path('login', views.LoginUserApiView.as_view(), name="login"),
    path('login/refresh', TokenRefreshView.as_view(), name='token_refresh'),
    path('register', views.UserCreateView.as_view(), name='register'),
    path('change-profilepic', views.UpdateProfilePicAPIView.as_view(), name='change_profilepic'),
    path('change-password', views.PasswordUpdateView.as_view(), name='change_password'),

]