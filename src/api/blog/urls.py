from django.urls import path
from api.blog import views



urlpatterns = [
    # Blog APIs
    path('', views.BlogListAPIView.as_view(), name='blog-list'),
    path('categories', views.BlogCategoryListApiView.as_view(), name='blog-categories'),
    path('popular-tags/', views.PopularBlogTagsListAPIView.as_view(), name="blog_tags"),
    path('last-blogs/', views.LastBlogsListAPIView.as_view(), name="last_blogs"),
]