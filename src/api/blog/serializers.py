from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from rest_framework.validators import ValidationError
from blog.models import (
    Tag, 
    Blog, 
    Comment, 
    BlogTag,
)
from api.product.serializers import TagSerializer
from rest_framework.fields import SerializerMethodField


class BlogTagSerializer(serializers.ModelSerializer):
    """
    Tag Serializer
    """
    tag_name = TagSerializer(read_only=True)

    class Meta:
        model = BlogTag
        fields = ['tag_name', ]


class BlogSerializer(serializers.ModelSerializer):
    author = SerializerMethodField()
    category = SerializerMethodField()
    tags = serializers.SerializerMethodField()

    class Meta:
        model = Blog
        fields = [
            "title",
            "slug",
            "text",
            "image",
            "created_at",
            "author",
            "category",
            "tags",
            "brief_info",
            "read_count",
        ]
    
    def get_author(self, obj):
        return obj.author.full_name

    def get_category(self, obj):
        return obj.category.name

    def get_tags(self, obj):
        tag_qs = BlogTag.objects.filter(blog=obj)
        tags = BlogTagSerializer(tag_qs, many=True).data
        return tags


