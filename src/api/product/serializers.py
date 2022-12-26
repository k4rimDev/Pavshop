from types import CoroutineType
from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from rest_framework.validators import ValidationError
from django.contrib.auth.password_validation import validate_password

from product.models import (
    Product,
    Category,
    Color,
    Brand,
    ProductTag,
)
from blog.models import Tag

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = [
            'name',
            'category_image',
        ]



class ColorSerializer(serializers.ModelSerializer):
    """
    Color Serializer
    """
    class Meta:
        model = Color
        fields = ['name', 'color', ]

class BrandSerializer(serializers.ModelSerializer):
    """
    Brand Serializer
    """
    class Meta:
        model = Brand
        fields = ['name', ]


class TagSerializer(serializers.ModelSerializer):
    """
    Producttag serializer
    """

    class Meta:
        model = Tag
        fields = ['name', 'usage_count']



class ProductTagSerializer(serializers.ModelSerializer):
    """
    Tag Serializer
    """
    tag_name = TagSerializer(read_only=True)

    class Meta:
        model = ProductTag
        fields = ['tag_name', ]

        
class ProductSerializer(serializers.ModelSerializer):
    colors = serializers.SerializerMethodField()
    tags = serializers.SerializerMethodField()
    category = CategorySerializer(read_only=True)
    brand = BrandSerializer(read_only=True)

    def validate(self, attrs: dict) -> dict:
        if attrs["price"] == 0:
            raise ValidationError("...")
        return attrs

    def get_colors(self, obj):
        color_qs = obj.color.all()
        color = ColorSerializer(color_qs, many=True).data
        return color

    def get_tags(self, obj):
        tag_qs = ProductTag.objects.filter(product=obj)
        tags = ProductTagSerializer(tag_qs, many=True).data
        return tags



    class Meta:
        model = Product
        fields = (
            "id",
            'product_name',
            'main_image',
            'brief_info',
            'price',
            'category',
            'tags',
            'brand',
            'discount_status',
            'discount_percent',
            'designer',
            'product_detail',
            'delivery_info',
            'product_description',
            'product_info',
            'availability',
            'slug',
            'colors',
            "order_count",
        )

        depth = 1
        