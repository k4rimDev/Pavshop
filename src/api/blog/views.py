from rest_framework import generics, permissions, status
from api.blog.serializers import (
    BlogSerializer,
    BlogTagSerializer,
)
from api.product.serializers import CategorySerializer
from blog.models import (
    Tag,
    Blog,
    Comment,
    BlogTag,
)
from product.models import Category


class BlogListAPIView(generics.ListAPIView):
    """
    Endpoint for this api - "api/blog/"
                            "api/blog/?recent=true/"
                            "api/blog/?popular=true/"
                            "api/blog/?category=<str>/"
    """
    permission_classes = (permissions.AllowAny,)
    serializer_class = BlogSerializer
    
    def get_queryset(self):
        recent_blogs = self.request.query_params.get("recent") 
        popular_blogs = self.request.query_params.get("popular") 
        blog_category = self.request.query_params.get("category")

        queryset = Blog.objects.all().order_by("-created_at")
        if recent_blogs:
            queryset = queryset[:5]
        if popular_blogs:
            queryset = queryset.filter("-read_count")
        if blog_category:
            category = Category.objects.get(name=blog_category.lower())
            queryset = category.blogs

        return queryset




class BlogCategoryListApiView(generics.ListAPIView):
    """
    Endpoint for this api - "api/blog/categories"
    LIst of blog categories
    """
    permission_classes = (permissions.AllowAny,)
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    pagination_class = None
    # TODO blogcategory ni product categoryden ayirmaq ucun extra fieldi yarat


class PopularBlogTagsListAPIView(generics.ListAPIView):
    """
    Endpoint for this api - "api/blog/popular-tags/"
    List of 5 popular blog tags
    """
    queryset = BlogTag.objects.all().order_by("-tag_name__usage_count")[:5]
    serializer_class = BlogTagSerializer
    pagination_class = None



class LastBlogsListAPIView(generics.ListAPIView):
    """
    Endpoint for this api - "api/blog/popular-tags/"
    LIst of 2 popular blogs
    """
    queryset = Blog.objects.all().order_by("-read_count")[:2]
    serializer_class = BlogSerializer
    pagination_class = None

