from django.contrib import admin
from .models import Blog, Tag, Comment, BlogTag
from blog.admin_filters import CategoryListFilter


@admin.register(Blog)
class BlogAdmin(admin.ModelAdmin):
    list_display = ("author", "title", "category",)
    list_editable = ("title", )
    search_fields = ("title", "category",)
    list_filter = ('tags', 'category', CategoryListFilter)


@admin.register(Tag)
class TagAdmin(admin.ModelAdmin):
    list_display = ("name", )
    search_fields = ("name", )

@admin.register(BlogTag)
class BlogTagAdmin(admin.ModelAdmin):
    list_display = ("tag_name", )
    search_fields = ("tag_name", )



@admin.register(Comment)
class CommentAdmin(admin.ModelAdmin):
    list_display = ("subject", )
    search_fields = ("subject", )
