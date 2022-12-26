"""pavshop URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.conf.urls.static import static
from django.conf import settings
from django.contrib.auth import views as auth_views
from django.conf.urls.i18n import i18n_patterns

# from django.conf.urls import include
from django.urls import re_path
from drf_spectacular.views import SpectacularAPIView, SpectacularRedocView, SpectacularSwaggerView



urlpatterns = [
    path('jet/', include('jet.urls', 'jet')),
    path('jet/dashboard/', include('jet.dashboard.urls', 'jet-dashboard')),
    path('admin/', admin.site.urls),
    
    path('api/', include('api.urls')),
    path('api/schema/', SpectacularAPIView.as_view(), name='schema'),
    # Optional UI:
    path('api/schema/swagger-ui/', SpectacularSwaggerView.as_view(url_name='schema'), name='swagger-ui'),
    path('api/schema/redoc/', SpectacularRedocView.as_view(url_name='schema'), name='redoc'),

    path('', include('core.urls', namespace='core')),
    path('', include('users.urls')),
    path('blogs/', include('blog.urls', namespace='blogs')),
    path('accounts/', include('users.urls', namespace="users")),
    # path('accounts/', include('allauth.urls')),
    path('', include('order.urls')),
    path('products/', include('product.urls')),
    path('cart/', include('cart.urls')),


    re_path(r'^rosetta/', include('rosetta.urls')),

    path('password_reset/done/', auth_views.PasswordResetDoneView.as_view(template_name='users/password/password_reset_done.html'), name='password_reset_done'),
    path('reset/<uidb64>/<token>/', auth_views.PasswordResetConfirmView.as_view(template_name="users/password/password_reset_confirm.html"), name='password_reset_confirm'),
    path('reset/done/', auth_views.PasswordResetCompleteView.as_view(template_name='users/password/password_reset_complete.html'), name='password_reset_complete'),

    path('oauth/', include('social_django.urls', namespace='social')),

] + static(settings.MEDIA_URL, document_root = settings.MEDIA_ROOT)


# if 'rosetta' in settings.INSTALLED_APPS:
#     urlpatterns += [
#         re_path('rosetta/', include('rosetta.urls'))
#     ]

urlpatterns = [
    *i18n_patterns(*urlpatterns, prefix_default_language=False),
    # path("<str:language>/<path:path>/", core_view.set_language, name="set-language"),
    path('i18n/', include('django.conf.urls.i18n')),
]
