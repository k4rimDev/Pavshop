from django.shortcuts import render
from django.http.request import HttpRequest
from django.http.response import HttpResponse
from blog.services.blogs import get_blog_by_id, get_comments, recent_blogs, blog_list_pagination, get_category_blog, get_similar_blog, list_comment, popular_blog, get_blog, get_tags, list_tag, list_blog, get_blog_id_with_slug, get_all_categories, get_blog_categories
from blog.forms import CommentForm, SearchForm
from product.services.products import newest_product
from django.core.paginator import Paginator

from django.views.generic import ListView
from blog.models import Blog
from typing import Any, Dict

from django.views.decorators.cache import cache_page
from core.models import Background

# Global variable
recent_blogs_posts = recent_blogs()


class BlogListView(ListView):
    model = Blog
    object_list = Blog.objects.all()
    

    def get_context_data(self, *, object_list=None, **kwargs) -> Dict[str, Any]:
        queryset = object_list if object_list is not None else self.object_list.order_by("-read_count")
        categories = get_all_categories()
        tags = list_tag()
        new_product = newest_product()
        # page_size = self.get_paginate_by(queryset)
        context_object_name = self.get_context_object_name(queryset)
        paginator = blog_list_pagination()
        page_number = self.request.GET.get('page', 1)
        background = Background.objects.all()[0].blog_page
        page_obj = paginator.get_page(page_number)
        context = {
                'paginator': paginator,
                'page_obj': page_obj,
                'blogs': queryset,
                'recent_blogs': recent_blogs_posts,
                "categories": categories,
                "tags": tags,
                "new_product": new_product,
                "background": background
            }
     
        if context_object_name is not None:
            context[context_object_name] = queryset
        context.update(kwargs)
        return super().get_context_data(**context)


def blog_detail(request: HttpRequest, slug) -> HttpResponse: 
    id = get_blog_id_with_slug(slug).id
    blog = get_blog_by_id(id)
    comments = get_comments(id)
    categories = get_all_categories()
    blogtags = list_tag()
    new_product = newest_product()
    similar_blogs = get_similar_blog(id, blog.category)
    search_form = SearchForm()
    comment_form = CommentForm(initial={"comment": id})
    if request.user.is_authenticated:
        comment_form = CommentForm(initial={"comment": id, "name": request.user.full_name, "email": request.user.email})
    if request.method == "POST":
        parent_id = request.POST.get('parent')
        form = CommentForm(request.POST, initial={"comment": id, "parent": parent_id})
        if form.is_valid():
            form.save()
    
    context = {
        'blog': blog,
        'title': 'Blog Detail',
        'comment_form': comment_form,
        'search_form': search_form,
        'blog_id': id,
        'comments': comments,
        'recent_blogs': recent_blogs_posts,
        "categories": categories,
        "similar_blogs":similar_blogs,
        "blogtags":blogtags,
        "new_product": new_product,
    }
    return render(request, 'blog/blog_detail.html', context=context)