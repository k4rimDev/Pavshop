from core.models import Background

from django.http.request import HttpRequest
from django.http.response import HttpResponse
from django.http import JsonResponse
from django.shortcuts import render, redirect
from django.db.models import QuerySet, Avg, Q, Count
from django.core.paginator import Paginator
from django.views import generic
from django.urls import reverse

from rest_framework import generics, status
from rest_framework.response import Response

from product.models import Product
from product.forms import ReviewForm
from product.services.products import get_product, newest_product, get_color_of_product, get_simmilar_products, get_categories, get_most_popular_tags, get_product_image_url, get_reviews, get_product_id_with_slug, get_popular_brands, get_all_colors, product_list_pagination
from product.models import (
    Color, 
    Image, 
    Product, 
    Category, 
    Review
)


class CustomPagination:

    def get_paginated_response(self, request, queryset):
        paginator = Paginator(queryset, 3)
        page_number = request.GET.get('page', 1)
        page_obj = paginator.get_page(page_number)
        return page_obj


# class ProductCreateApiView(generics.CreateAPIView):
    # serializer_class = ProductSerializer
    

    # def post(self, request, *args, **kwargs):
    #     serializer = Product(data=request.data)
    #     serializer.is_valid(raise_exception=True)
    #     serializer.save()
    #     return Response(serializer.data, status=status.HTTP_201_CREATED)


# def product_list(request: HttpRequest) -> HttpResponse:
#     products = list_products()
#     products = Product.objects.all()
#     paginator = product_list_pagination()
#     paginator = Paginator(products.order_by('added_date'), 9)
#     page_number = request.GET.get('page', 1)
#     page_obj = paginator.get_page(page_number)
#     categories = get_categories()
#     popular_tags = get_most_popular_tags()
#     popular_brands = get_popular_brands()
#     colors = get_all_colors()
#     context = {
#         'products': products,
#         'categories': categories,
#         'popular_tags': popular_tags,
#         'popular_brands': popular_brands,
#         'colors': colors,
#         'page_obj': page_obj,
#         'title': 'Product List',
#     }
#     return render(request, 'product/product-list.html', context=context)


# def product_detail(request: HttpRequest, slug) -> HttpResponse:
#     product = get_product_id_with_slug(slug)
#     # product = get_product(id)
#     colors = get_color_of_product(product.id)
#     similiar_products = get_simmilar_products(product.category_id)
#     image_url = get_product_image_url(product.id)
#     reviews = get_reviews(product.id)
#     review_form = ReviewForm(prefix='review_form',  initial={'product_id': product})

#     if request.method == 'POST':
#         review_form = ReviewForm(request.POST, prefix='review_form',  initial={'product_id': product})
#         if review_form.is_valid():
#             review_form.save()
#         else:
#             return JsonResponse({'error': review_form.errors}, status =406)
    
#     context = {
#         'active_page': 'product-detail',
#         'product': product,
#         'title': 'Product Detail',
#         'colors': colors,
#         'similiar_products': similiar_products,
#         'image': image_url,
#         'reviews': reviews,
#         'review_form': review_form,
#     }
#     return render(request, 'product/product-detail.html', context=context) 

class ProductListView(generic.ListView):
    model = Product
    context_object_name = "products"


    def get_context_data(self, **kwargs) -> dict:
        context_data = super().get_context_data(**kwargs)
        product_bg = Background.objects.all()[0]
        products = Product.objects.all()
        new_product = newest_product()
        paginator = product_list_pagination()
        page_number = self.request.GET.get('page', 1)
        page_obj = paginator.get_page(page_number)
        categories = get_categories()
        popular_tags = get_most_popular_tags()
        popular_brands = get_popular_brands()
        colors = get_all_colors()

        context_data["active_page"] = 'product-list'
        context_data["products"] = products
        context_data["title"] = "Product List"
        context_data["categories"] = categories
        context_data["popular_tags"] = popular_tags
        context_data["popular_brands"] = popular_brands
        context_data["page_obj"] = page_obj
        context_data["colors"] = colors
        context_data["product_bg"] = product_bg.product_page
        context_data["new_product"] = new_product

        return context_data
    
    def post(self, request, *args, **kwargs):
        ...

class ProductDetailView(generic.edit.FormMixin, generic.DetailView):
    model = Product 
    context_object_name = "product"
    form_class = ReviewForm
    template_name: str = "product/product_detail.html"

    def get(self, request: HttpRequest, slug, *args, **kwargs):
        self.review_form = self.form_class({}, *args, **kwargs)
        return super().get(request, *args, **kwargs)

    def get_context_data(self, **kwargs) -> dict:
        context_data = super().get_context_data(**kwargs)
        slug = self.object.slug
        id = get_product_id_with_slug(slug).id
        product = get_product(id)
        self.product = product
        colors = get_color_of_product(id)
        similiar_products = get_simmilar_products(product.category_id)
        image_url = get_product_image_url(id)
        reviews = get_reviews(id)

        context_data["active_page"] = 'product-detail'
        context_data["product"] = product
        context_data["title"] = "Product Detail"
        context_data["similiar_products"] = similiar_products
        context_data["image"] = image_url
        context_data["reviews"] = reviews   
        context_data["colors"] = colors
        context_data["user"] = self.request.user
        context_data['review_form'] = self.review_form

        return context_data

    
    def post(self, request, *args, **kwargs):
        review_form = self.form_class(request.POST)
        if review_form.is_valid:
            review_form = review_form.save(commit = False)
            review_form.product = self.get_object()
            review_form.save()
            return redirect(reverse('products:product-detail', kwargs={ 'slug': self.get_object().slug }))
        else:
            return JsonResponse({'error': review_form.errors}, status =406)