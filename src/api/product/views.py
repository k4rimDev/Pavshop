from rest_framework import generics, permissions, status
from rest_framework.response import Response
from api.product.serializers import (
    ProductSerializer, 
    CategorySerializer,
    ColorSerializer,
    BrandSerializer,
    ProductTagSerializer,
)
from product.models import Product, Category, ProductTag, Color, Brand
from django.db.models import Count, Q


# Category VIEWS
class CategoryListAPIView(generics.ListAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer


class CategoryDetailAPIView(generics.RetrieveAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    lookup_field = 'pk'

class CategoryUpdateAPIView(generics.UpdateAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    lookup_field = 'pk'

class CategoryDeleteAPIView(generics.DestroyAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    lookup_field = 'pk'
    
    def perform_destroy(self, instance):
        super().perform_destroy(instance)

class CategoryCreateAPIView(generics.CreateAPIView):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer

# Color VIEWS 
class ColorListAPIView(generics.ListAPIView):
    queryset = Color.objects.all()
    serializer_class = ColorSerializer

# Tag VIEWS
class TagListAPIView(generics.ListAPIView):
    queryset = ProductTag.objects.all()
    serializer_class = ProductTagSerializer

# Brand VIEWS
class BrandListAPIView(generics.ListAPIView):
    queryset = Brand.objects.all()
    serializer_class = BrandSerializer

# Product VIEWS
class ProductListAPIView(generics.ListAPIView):
    """
      
      Method: GET
      Endpoints: api/product/?tag=<str>/       - filter products by tag, expected str
                 api/product/?category=<str>/  - filter products by category, expected str
                 api/product/?color=<list>/    - filter products by color, expected list
                 api/product/?order_by=<str>/  - order by descending, ascending, expected str: "createdat_desc", "createdat_asc", "popularity_asc", "popularity_desc", "price_desc", "price_asc"
                 api/product/?min_price=<int>/ - filter by min price, expected int
                 api/product/?max_price=<int>/ - filter by min price, expected int
                 api/product/?brand=<str>/     - filter by brand, expected str
                 api/product/?new-product=True/- get newest and popular product
    """
    permission_classes = (permissions.AllowAny,)
    

    def get(self, *args, **kwargs):
        queryset = Product.objects.filter(availability=True)

        tag = self.request.query_params.get("tag")  
        category = self.request.query_params.get("category")  
        brand = self.request.query_params.get("brand")  
        color = self.request.query_params.get("color") 
        min_price = self.request.query_params.get("min_price")
        max_price = self.request.query_params.get("max_price")
        new_product = self.request.query_params.get("new-product")
        order_by = self.request.query_params.get("order_by") 
        search_product = self.request.query_params.get("search_product")

        
        if tag:
            queryset = queryset.filter(tag__tag_name=str(tag).lower())
        
        if category:
            queryset = queryset.filter(category__name=str(category))

        if color:
            queryset = queryset.filter(color__name__in=color.split(","))
        
        if brand:
            queryset = queryset.filter(brand__name=str(brand))

        if min_price:
            queryset = queryset.filter(price__gte=float(min_price))
        if max_price:
            queryset = queryset.filter(price__lte=float(max_price))

        if new_product:
            queryset = queryset.order_by('-created_at', '-order_count')[:1]

        if order_by:
            order_by = str(order_by).lower()
            if order_by=="createdat_desc":
                queryset = queryset.order_by("-created_at")
            if order_by=="createdat_asc":
                queryset = queryset.order_by("created_at")
            if order_by=="popularity_desc":
                queryset = queryset.order_by("-order_count")
            if order_by=="popularity_asc":
                queryset = queryset.order_by("order_count")
            if order_by=="price_desc":
                queryset = queryset.order_by("-price")
            if order_by=="price_asc":
                queryset = queryset.order_by("price")
        
        if search_product:
            queryset = queryset.filter(Q(product_name__icontains=search_product) | Q(brief_info__icontains=search_product) | Q(product_info__icontains=search_product))

        serializer = ProductSerializer(queryset, many=True)

        return Response(serializer.data, status=status.HTTP_200_OK)



class PopularProductTagsListAPIView(generics.ListAPIView):
    """
    Endpoint for this api - "api/product/popular-tags/"
    List of 5 popular tags
    """
    queryset = ProductTag.objects.all().order_by("-tag_name__usage_count")[:5]
    serializer_class = ProductTagSerializer
    pagination_class = None


class NewProductsListAPIView(generics.ListAPIView):
    """
    Endpoint for this api - "api/product/new-products/"
    List of 8 new products
    """
    queryset = Product.objects.all().order_by("-created_at")[:8]
    serializer_class = ProductSerializer
    pagination_class = None

class PopularProductsListAPIView(generics.ListAPIView):
    """
    Endpoint for this api - "api/product/new-products/"
    List of 6 popular products
    """
    queryset = Product.objects.all().order_by("-order_count")[:4]
    serializer_class = ProductSerializer
    pagination_class = None



class ProductDetailAPIView(generics.RetrieveAPIView):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    lookup_field = 'pk'


class ProductUpdateAPIView(generics.UpdateAPIView):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    lookup_field = 'pk'

class ProductDeleteAPIView(generics.DestroyAPIView):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer
    lookup_field = 'pk'
    
    def perform_destroy(self, instance):
        super().perform_destroy(instance)

class ProductCreateAPIView(generics.CreateAPIView):
    queryset = Product.objects.all()
    serializer_class = ProductSerializer




# from rest_framework import generics, status, permissions
# from api.serializers import ProductSerializer
# from product.models import Product
# from rest_framework.response import Response

# # in listcreateapiview i need two function in  - get_queryset(self) and post(sel, request, *args, **kwargs)  (for validating data and return response(serializer.data, status))
# # in serializer if i have many querysets i handle it by get_field_name methods() and create method() for taking validated data
# class ProductListCreateApiView(generics.ListCreateAPIView):
#     serializer_class = ProductSerializer
    
#     def get_queryset(self):
#         products = Product.objects.all()
#         return Response(products, status=status.HTTP_200_OK)


#     def post(self, request, *args, **kwargs):
#         serializer = self.get_serializer(data=request.data)
#         serializer.is_valid(raise_exception=True)
#         serializer.save()
#         return Response(serializer.data, status=status.HTTP_201_CREATED)



# class ProductListApiView(generics.ListAPIView):
#     serializer_class = ProductSerializer
    
#     def get_queryset(self):
#         return Product.objects.all()

#     #     paginator_class = CustomPagination()
#     #     # page_obj = paginator_class.get_paginated_response(request, products)

#     #     return Response({'products': products, 'categories': categories, 'popular_tags': popular_tags, 'popular_brands': popular_brands, 'colors': colors, 'page_obj': page_obj, 'title': 'Product List'}, status=status.HTTP_200_OK)
#     #     # return products.union(categories, popular_tags, popular_brands, colors, all=True)


# class ProductCreateApiView(generics.Create):

#     # def get_queryset(self):    
#     #     products = Product.objects.all().order_by('added_date')
#     #     categories = Category.objects.annotate(Count('product')).values_list('name', 'product__count').filter(product__count__gte=1)
#     #     popular_tags = Product.objects.values_list("tag_id__name", flat=True).annotate(Count('tag_id')).order_by('-tag_id__count')[:5]
#     #     popular_brands = Product.objects.values_list("brand_id__name", flat=True).annotate(Count('brand_id')).order_by('-brand_id__count')[:5]
#     #     colors = Color.objects.annotate(Count('product')).values_list('name', 'color').filter(product__count__gte=1)
#     # def get_queryset(self):    
#     #     products = Product.objects.all().order_by('added_date')
#     #     categories = Category.objects.annotate(Count('product')).values_list('name', 'product__count').filter(product__count__gte=1)
#     #     popular_tags = Product.objects.values_list("tag_id__name", flat=True).annotate(Count('tag_id')).order_by('-tag_id__count')[:5]
#     #     popular_brands = Product.objects.values_list("brand_id__name", flat=True).annotate(Count('brand_id')).order_by('-brand_id__count')[:5]
#     #     colors = Color.objects.annotate(Count('product')).values_list('name', 'color').filter(product__count__gte=1)
#     serializer_class = ProductSerializer

#     def perform_create(self, serializer):
#         return super().perform_create(serializer)
    
