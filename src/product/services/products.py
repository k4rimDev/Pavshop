from django.db.models import QuerySet, Avg, Q, Count
from product.models import Color, Image, Product, Category, Review
from django.core.paginator import Paginator


# # Get all products
# def list_products() -> QuerySet:
#     return Product.objects.all()


# Get product
def get_product(id) -> QuerySet:
    return Product.objects.get(id = id)

# Get id of spesific product
def get_product_id_with_slug(slug) -> int:
    return Product.objects.get(slug = slug)


# Get image url
def get_product_image_url(id) -> QuerySet:
    return Image.objects.filter(product_id = id)

# Get category
def get_category() -> QuerySet:
    return  Review.objects.all().aggregate(
        Avg('rating')
    ).order_by('-rating__avg')[:5]


# Get colors of product
def get_color_of_product(id) -> QuerySet:
    return Product.objects.values_list('color__color', 'color__name').filter(id = id)


# # The most popular 5 products tags
def get_most_popular_tags() -> QuerySet:
    return Product.objects.values_list("tags__name", flat=True).annotate(
        Count('tags')
    ).order_by(
        '-tags__count'
    )[:5]

# Get similar products
def get_simmilar_products(category_id) -> QuerySet:
    return Product.objects.filter(category_id = category_id).order_by()[:8]

# Get all products by category
def get_productsby_category(category_id) -> QuerySet:
    return Product.objects.filter(category_id = category_id)


# Sort products by price and date added
def sort_by_price_and_date() -> QuerySet:
    return Product.objects.all().order_by('price', 'created_at')

# Get product categories and its count with at least 1 product
def get_categories() -> QuerySet:
    categories = Category.objects.annotate(Count('products')) 
    return categories.values_list('name', 'products__count').filter(products__count__gte=1)

# Get specific product reviews
def get_reviews(product_id) -> QuerySet:
    return Review.objects.filter(product_id = product_id)

# Find product by its name
def search_product(query) -> QuerySet:
    return Product.objects.filter(product_name__contains = query)

# Get popular 5 brands
# def get_popular_brands() -> QuerySet:
#     return Product.objects.values_list("brand_id__name", flat=True).annotate(
#         Count('brand_id')
#     ).order_by(
#         '-brand_id__count'
#     )[:5]

# Get all colors with at least 1 product
# def get_all_colors() -> QuerySet:
#     colors = Color.objects.annotate(Count('product')) 
#     return colors.values_list('name', 'color').filter(product__count__gte=1)

# # Pagination on product-list page
# def product_list_pagination(products) -> QuerySet:
#     product_list = Product.objects.all().order_by('created_at')
#     paginator = Paginator(product_list, 9)
#     return paginator

# Get popular brand 
def get_popular_brands() -> QuerySet:
    return Product.objects.values_list("brand_id__name", flat=True).annotate(
        Count('brand_id')
    ).order_by(
        '-brand_id__count'
    )[:5]


# Get all colors with at least 1 product
def get_all_colors() -> QuerySet:
    colors = Color.objects.annotate(Count('product')) 
    return colors.values_list('name', 'color').filter(product__count__gte=1)
    


# Add reviews for product
def add_reviews(name: str, email: str, review_text: str, rating: int, product_id) -> None:
    Review.objects.get_or_create(name=name, email=email, review_text=review_text, rating=rating, product_id=product_id)


# Pagination on product-list page
def product_list_pagination() -> QuerySet:
    product_list = Product.objects.all().order_by('created_at')
    paginator = Paginator(product_list, 9)
    return paginator


def newest_product() -> QuerySet:
    return Product.objects.all().order_by("-created_at").first()