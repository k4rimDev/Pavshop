from django.urls import path, include
from api.product import views



urlpatterns = [

    # Product APIs
    path('', views.ProductListAPIView.as_view(), name='product'),
    path('<int:pk>', views.ProductDetailAPIView.as_view(), name='product_detail'),
    path('create/', views.ProductCreateAPIView.as_view(), name='product_create'),
    path('delete/<int:pk>/', views.ProductDeleteAPIView.as_view(), name='product_delete'),
    path('update/<int:pk>/', views.ProductUpdateAPIView.as_view(), name='product_upadate'),
    path('popular-tags/', views.PopularProductTagsListAPIView.as_view(), name="product_tags"),
    path('new-products/', views.NewProductsListAPIView.as_view(), name="new_products"),
    path('popular-products/', views.PopularProductsListAPIView.as_view(), name="popular_products"),
  

    # Category APIs
    path('category/', views.CategoryListAPIView.as_view(), name='category'),
    path('category/<int:pk>', views.CategoryDetailAPIView.as_view(), name='category_detail'),
    path('category/create/', views.CategoryCreateAPIView.as_view(), name='category_create'),
    path('category/delete/<int:pk>', views.CategoryDeleteAPIView.as_view(), name='category_delete'),
    path('category/update/<int:pk>', views.CategoryUpdateAPIView.as_view(), name='category_update'),

    # Color APIs
    path('color/', views.ColorListAPIView.as_view(), name='color_list'),

    # Brand APIs
    path('brand/', views.BrandListAPIView.as_view(), name='brand_list'),

    # Tag APIs
    path('tag/', views.TagListAPIView.as_view(), name='tag_list'),

]

