from django.db.models import QuerySet
from django.db.utils import IntegrityError
from blog.models import Tag, Blog, Comment
from blog.services.blogs import list_blog
from product.models import Tag, Brand, Category, Color, Designer, Image, Review, Product
from order.models import Cart, Order, Payment, Shipping
from users.models import User
from core.models import SocialMedia, Staff, Subscription


def test_blog_model_is_created(blog) -> None:
    # blog.save()
    blogs = list_blog()
    assert blogs.count() > 0

def test_blog_tag_str(blog_tag) -> None:
    assert blog_tag.__str__() == "Tag"

def test_blog_category_str(blog_category) -> None:
    assert blog_category.__str__() == "Category"

def test_blog_type_str(blog_type) -> None:
    assert blog_type.__str__() == "Blog"



#######
# Product
#######
def test_product_product_name_str(product) -> None:
    assert product.__str__() == 'laptop'

import pytest

def test_product_price(product):
    # with pytest.raises(IntegrityError):
    #     assert product.price >= 0
    assert product.price >= 0


from django import test
from . import factories
class ProductTests(test.TestCase):
    def test_product_image(self):
        image = factories.ImageFactory() 
        self.assertIsNotNone(image.image)