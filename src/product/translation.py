from unicodedata import category
from product.models import Product, Category, Brand, Designer, Color
from modeltranslation.translator import TranslationOptions, register


@register(Product)
class ProductTranslationOptions(TranslationOptions):
    fields = (
        "product_name",
        "brief_info",
        "product_description",
        "product_detail",
        "delivery_info",
        "product_info"
    )

@register(Category)
class CategoryTranslationOptions(TranslationOptions):
    fields = ("name", )

@register(Color)
class ColorTranslationOptions(TranslationOptions):
    fields = ("name", )

@register(Designer)
class DesignerTranslationOptions(TranslationOptions):
    fields = ("name", )

@register(Brand)
class BrandTranslationOptions(TranslationOptions):
    fields = ("name", )