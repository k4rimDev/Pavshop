from blog.models import Blog, BlogTag, Comment, Tag
from django.db.models import QuerySet, Q, F, Count
from product.models import Category


def list_blog() -> QuerySet:
    return Blog.objects.annotate(comment_count = Count('blog_comment'))

def list_tag() -> QuerySet:
    return BlogTag.objects.all()[:5]

def list_comment() -> QuerySet:
    return Comment.objects.all()

# Get similar blogs
def get_similar_blog(blog_id: int, category_id: int) -> QuerySet:
    return Blog.objects.filter(
        Q(category_id = category_id) & ~Q(id = blog_id)
    )


# Get category of blog
def get_category_blog(id: int) -> Blog:
    return Blog.objects.filter(
        id = id
    ).first().category_id


# Get blog by data
def get_blog(text: str) -> QuerySet:
    return Blog.objects.filter(
        Q(title__icontains=text) | Q(text__icontains=text)
    ).all()


# Get blog by id
def get_blog_by_id(id) -> Blog:
    return Blog.objects.get(id = id)

# Get tags of blog
def get_tags(id: int) -> Tag:
    return Tag.objects.filter(
        id__in = (Blog.objects.filter(id = id).values(
            'tag_id',
        ))
    )  # type: ignore


# Get comments of blog   ????
def get_all_categories() -> QuerySet:
    return Category.objects.filter(
        id__in = (Blog.objects.all().values(
            'category_id'
        )))[:5]

# The most popular 5 blog
def popular_blog() -> QuerySet:
    return Blog.objects.all().annotate(
        Count('tag_id')
    ).order_by(
        '-tag_id__count'
    )[:5]

    
# Get most recent 3 blogs
def recent_blogs() -> QuerySet:
    return Blog.objects.order_by('-created_at')[:3]

# Get id of blog by slug
def get_blog_id_with_slug(slug) -> Blog:
    return Blog.objects.get(slug = slug)


# Supheli qs dir 
# Get specific blog's comments 
def get_comments(blog_id: int) -> QuerySet:
    return Comment.objects.filter(comment = blog_id)


# Get blog categories and its count with at least 1 blog
def get_blog_categories() -> QuerySet:
    categories = Category.objects.annotate(Count('blog'))
    return categories.values_list('name', 'blog__count').filter(blog__count__gte=1)

from django.core.paginator import Paginator

# Pagination on blog-list page
def blog_list_pagination() -> QuerySet:
    blog_list = Blog.objects.all().order_by('created_at')
    paginator = Paginator(blog_list, 3)
    return paginator







