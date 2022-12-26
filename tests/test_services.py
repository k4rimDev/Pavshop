from django.db.models import QuerySet
from blog.services.blogs import get_comments, list_blog, list_tag, list_comment, get_similar_blog, get_category_blog, get_blog, get_tags, popular_blog, recent_blogs
from product.services.products import get_categories, get_category, get_most_popular_tags, get_productsby_category, get_simmilar_products, get_reviews, list_products, search_product, sort_by_price_and_date

# ------------------------------------------------
# Blog services tests
def test_list_blog_return_queryset() -> None:
    blogs = list_blog()
    assert isinstance(blogs, QuerySet)

def test_list_comments_return_queryset() -> None:
    comments = list_comment()
    assert isinstance(comments, QuerySet)

def test_list_tag_return_queryset() -> None:
    tags = list_tag()
    assert isinstance(tags, QuerySet)

def test_similar_blog_is_returned(blog) -> None:
    blogs = get_similar_blog(blog.id, blog.category_id)
    for selected_blog in blogs:
        assert blog.category_id == selected_blog.category_id

def test_get_category_is_blog_category(blog) -> None:
    blog_categories = get_category_blog(blog.id)
    assert blog.category_id == blog_categories

def test_searching_blog(blog) -> None:
    selected_blog = get_blog(blog.title[:2])
    assert len(selected_blog) > 0

def test_get_blog_tag(blog) -> None:
    tags = get_tags(blog.id)
    assert len(tags) > 0

def test_recent_blog(blog) -> None:
    recent_blog = recent_blogs()
    assert recent_blog.count() > 0

def test_recent_blog_is_queryset() -> None:
    recent_blog = recent_blogs()
    assert isinstance(recent_blog, QuerySet)

def test_popular_blog() -> None:
    popular_blogs = popular_blog()
    assert isinstance(popular_blogs, QuerySet)

def test_popular_blog_tag_is_not_unique(blog) -> None:
    popular_blogs = popular_blog()
    for popular_blog_in_list in popular_blogs:
        assert blog.tag_id == popular_blog_in_list.tag_id

def test_comment_assinstance_blog(blog) -> None:
    blog_comments = get_comments(blog.id)
    assert isinstance(blog_comments, QuerySet)
    
# ------------------------------------------------
# Product services tests
def test_get_productsby_category(product) -> None:
    similiar_products = get_productsby_category(product.category_id)
    assert isinstance(similiar_products, QuerySet)
    assert len(similiar_products) > 0

# def test_get_most_popular_tags(product) -> None:
#     ...