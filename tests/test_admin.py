import site
import pytest

from blog.models import Comment, Blog, Tag
from blog import admin
from product.models import Category


@pytest.fixture
def unused_category(db):
    return Category.objects.create(name="unused_tag")


@pytest.fixture
def blog_model_admin() -> admin.BlogAdmin:
    return admin.BlogAdmin(Blog, site)


def test_category_list_filter_return_correct_blog(
    blog, 
    category, 
    unused_category, 
    request_factory,
    blog_model_admin
) -> None:
    request = request_factory.get("/", {})
    filter = admin.CategoryListFilter(
        request=request, 
        params={"category": category.id}, 
        model=Blog, 
        model_admin=blog_model_admin
    )

    queryset = filter.queryset(request=request, queryset=Blog.objects.all())

    assert queryset.count() == 1

    assert queryset.first().id == blog.id

    filter = admin.CategoryListFilter(
        request=request, 
        params={"category": unused_category.id}, 
        model=Blog, 
        model_admin=blog_model_admin
    )

    queryset = filter.queryset(request=request, queryset=Blog.objects.all())

    assert queryset.count() == 0


def test_category_list_filter_return_used_tags(
    blog, 
    category, 
    unused_category, 
    request_factory,
    blog_model_admin
) -> None:
    request = request_factory.get("/", {})
    filter = admin.CategoryListFilter(
        request=request, 
        params={"category": category.id}, 
        model=Blog, 
        model_admin=blog_model_admin
    )

    lookups = filter.lookups(request=request, model_admin=blog_model_admin)

    assert lookups == [
        (category.id, f"Category with id = {category.id}")
    ]