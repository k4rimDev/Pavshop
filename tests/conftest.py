from django.test import RequestFactory
import faker
import pytest
from pytest_factoryboy import register
from tests.factories import TagFactory, BlogTypeFactory, CategoryFactory, ImageFactory, ProductFactory, BrandFactory, ColorFactory, DesignerFactory, ReviewFactory
from django.contrib.auth import get_user_model


from blog.models import Blog, Tag, Comment
from product.models import Brand, Category, Color, Designer, Image, Review, Product
from order.models import Cart, Order, Payment, Shipping
from users.models import User
from core.models import SocialMedia, Staff, Subscription

# --------------------------------------------------------------------------------------------
register(TagFactory)
register(BlogTypeFactory)
register(CategoryFactory)
register(ImageFactory)
register(ProductFactory)
register(ReviewFactory)
register(DesignerFactory)
register(BrandFactory)
register(ColorFactory)



@pytest.fixture
def blog_tag(db, tag_factory):
    tag = tag_factory.create()
    return tag

@pytest.fixture
def blog_category(db, category_factory):
    blog_category = category_factory.create()
    return blog_category

@pytest.fixture
def blog_type(db, blog_type_factory):
    blog = blog_type_factory.create()
    return blog

@pytest.fixture
def product_image(db, image_factory):
    image = image_factory.create()
    return image

@pytest.fixture
def product_product_name(db, product_factory):
    product = product_factory.create()
    return product

@pytest.fixture
def product_brand_name(db, brand_factory):
    product_brand = brand_factory.create()
    return product_brand


@pytest.fixture
def product_color_name(db, color_factory):
    product_color = color_factory.create()
    return product_color


@pytest.fixture
def product_designer_name(db, designer_factory):
    product_designer = designer_factory.create()
    return product_designer


@pytest.fixture
def product_review_name(db, review_factory):
    product_review = review_factory.create()
    return product_review


# --------------------------------------------------------------------------------------------

@pytest.fixture
def user_model():
    return get_user_model()


@pytest.fixture
def request_factory() -> RequestFactory:
    return RequestFactory()


@pytest.fixture
def comment(db) -> Comment:
    return Comment.objects.create(
        subject = "Some comment",
        comment_text = "Some comment text"
    )

@pytest.fixture
def category(db) -> Category:
    return Category.objects.create(
        name = "Category"
    )


@pytest.fixture
def tag(db) -> Tag:
    return Tag.objects.create(name = "Tag")

@pytest.fixture
def comment(db) -> Comment:
    return Comment.objects.create(
        subject = "Some comment",
        comment_text = "This is so good product"
    )


@pytest.fixture
def blog(db, category, comment, user_model) -> Blog:
    blog =  Blog.objects.create(
        user = user_model.objects.create(
            first_name = "kerim",
            last_name = "mirzequliyev",
            password = "12345",
            email = "kerim@gmail.com"
        ),
        title = "Title of blog",
        text = "This is text of blog",
        comment_id = comment,
        category_id = category
    )
    blog.tag_id.add(Tag.objects.create(name="tag"))
    return blog



#############
# Product
###############
@pytest.fixture
def designer(db) -> Designer:
    designer = Designer.objects.create(name = "Kerim")
    return designer

@pytest.fixture
def brand(db) -> Brand:
    brand = Brand.objects.create(name = "Nike")
    return brand

@pytest.fixture
def color(db) -> Color:
    color = Color.objects.create(name = "Black")
    return color

@pytest.fixture()
def product(db, product_image, category, brand, designer, color) -> Product:
    product = Product.objects.create(
        product_name = "laptop",
        brief_info = "Electronical device",
        price = 0,
        image_id = product_image,
        like_status = True,
        category_id = category,
        brand_id = brand,
        discount_status = False,
        discount_percent = 1,
        designer_id = designer,
        product_detail = "Good product",
        delivery_info = "yes",
        product_info = "This is electronic product",
        availability = True,
    )
    product.tag_id.add(Tag.objects.create(name="tag"))
    product.color.add(Color.objects.create(name="black"))
    return product