from re import template
# from django.contrib.auth import views as auth_views
from django.urls import path
from django.contrib.auth import views as auth_views #import this

from . import views 

app_name = 'users' 

urlpatterns = [
    path('login', views.login_user, name='login'),
    path('login-social', views.login_social, name='login_social'),    
    path('register', views.register_user, name='register'),
    path('profile', views.user_profile, name='profile'),

    path('confirmation/<str:uuidb64>/<str:token>/', views.confirmation, name='confirmation'),

    # path('/password', auth_views.PasswordChangeView.as_view(template_name='users/profile.html'), name='password'),
    path('password', views.user_profile, name = 'change_password'),
    path('callback', views.callback, name='callback'),
    path('logout', views.logout_user, name='logout_user'),    
    path("password_reset", views.password_reset_request, name="password_reset")
]