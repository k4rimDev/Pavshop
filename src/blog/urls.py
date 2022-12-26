from django.urls import path
from . import views

app_name = "blogs"

urlpatterns = [
    path('', views.BlogListView.as_view(), name='blogs'),
    path('<slug:slug>/', views.blog_detail, name='blog-detail')
]