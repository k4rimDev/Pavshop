from typing import Any
from django.contrib import admin
from django.forms import CheckboxSelectMultiple
from product.admin_filters import CategoryListFilter
# from modeltranslation.admin import TranslationAdmin

from product.models import Product, Category, Designer, Review, Color, Brand, Image, ProductTag



class ImageModelInline(admin.StackedInline):
    model = Image

@admin.register(Product)
class ProductModelAdmin(admin.ModelAdmin):
    search_fields = ('product_name', 'category_id', )
    list_filter = ("category_id", "product_name", CategoryListFilter)
    inlines = [ImageModelInline]

    group_fieldsets = True

    class Media:
        js = (
            'http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js',
            'http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js',
            'modeltranslation/js/tabbed_translation_fields.js',
        )
        css = {
            'screen': ('modeltranslation/css/tabbed_translation_fields.css',),
        }

    class Meta:
        model = Product

@admin.register(Category)
class CategoryModelAdmin(admin.ModelAdmin):
    list_display = ('name', )
    search_fields = ('name', )
    group_fieldsets = True

    class Media:
        js = (
            'http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js',
            'http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js',
            'modeltranslation/js/tabbed_translation_fields.js',
        )
        css = {
            'screen': ('modeltranslation/css/tabbed_translation_fields.css',),
        }

@admin.register(Designer)
class DesignerModelAdmin(admin.ModelAdmin):
    list_display = ('name', )
    search_fields = ('name', )
    group_fieldsets = True

    class Media:
        js = (
            'http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js',
            'http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js',
            'modeltranslation/js/tabbed_translation_fields.js',
        )
        css = {
            'screen': ('modeltranslation/css/tabbed_translation_fields.css',),
        }

@admin.register(Review)
class ReviewModelAdmin(admin.ModelAdmin):
    list_display = ('rating', )
    search_fields = ('review_text', 'rating', )

@admin.register(Color)
class ColorModelAdmin(admin.ModelAdmin):
    list_display = ('name', )
    group_fieldsets = True

    class Media:
        js = (
            'http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js',
            'http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js',
            'modeltranslation/js/tabbed_translation_fields.js',
        )
        css = {
            'screen': ('modeltranslation/css/tabbed_translation_fields.css',),
        }

@admin.register(Brand)
class BrandModelAdmin(admin.ModelAdmin):
    list_display = ('name', )
    group_fieldsets = True

    class Media:
        js = (
            'http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js',
            'http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js',
            'modeltranslation/js/tabbed_translation_fields.js',
        )
        css = {
            'screen': ('modeltranslation/css/tabbed_translation_fields.css',),
        }

@admin.register(Image)
class ImageModelAdmin(admin.ModelAdmin):
    list_display = ('image', )   
    search_fields = ('name', )

    def save_model(self, request, obj, form, change):
        obj.user = request.files
        super().save_model(request, obj, form, change)

@admin.register(ProductTag)
class ProductTagAdmin(admin.ModelAdmin):
    list_display = ("tag_name", )
    