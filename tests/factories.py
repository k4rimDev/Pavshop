import factory
from blog.models import Tag, Blog, Comment
from order.models import Cart, Order, Payment, Shipping
from core.models import SocialMedia, Staff
from product.models import Category, Designer, Color, Brand, Image, Product, Review
from faker import Faker

fake = Faker()

class TagFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Tag  
    name = "Tag"

class CategoryFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Category  
        django_get_or_create = ('name', )
    name = "Category"

class CommentFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Comment  
        django_get_or_create = ('subject', )
    subject = "Comment"

class BlogTypeFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Blog 
        django_get_or_create = ('title', ) 
    
    tag_id = factory.RelatedFactoryList(
        TagFactory,
        size=1,
    )
    comment_id = factory.SubFactory(CommentFactory)
    category_id = factory.SubFactory(CategoryFactory)
    title = "Blog"
    
class ProductFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Product

    product_name = "phone"
    brief_info = fake.text()
    price = 12
    tag_id = factory.RelatedFactoryList(
        TagFactory,
        size = 1
    )

class ImageFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Image
    image = factory.django.ImageField()

class ReviewFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Review
    name = 'Review'

class DesignerFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Designer
    name = "Designer"

class ColorFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Color
    name = "Color"

class BrandFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Brand
    name = "Brand"

class SocialMediaFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = SocialMedia
    name = "twitter"

class StaffFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Staff
    name = "admin"

class CartFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Cart
    name = "cart"

class OrderFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Order
    name = "order"

class ShippingFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Shipping
    name = "shipping"