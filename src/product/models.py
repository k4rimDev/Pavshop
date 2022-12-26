from django.db import models
from django.db.models import Q
from django.utils.text import slugify
from django.core.validators import MaxValueValidator, MinValueValidator
from django.utils import timezone
from django.core.exceptions import ValidationError
from colorfield.fields import ColorField
from ckeditor.fields import RichTextField 
from blog.models import Tag
from tools.unique_slug import unique_slug_generator


variation_category_choice = (
    ("color", "color"),
)

        

class Color(models.Model):
    name = models.CharField(
        max_length=30,
        null=False,
        blank=True
    )
    color = ColorField(default='#000',format="hexa")
    def __str__(self) -> str:
        return self.name

class Category(models.Model):
    name = models.CharField(
        max_length=30,
        null=False
    )
    category_image = models.ImageField(null=True, blank=True, default="category_default.jpeg")
    class Meta:
        verbose_name_plural="Categories"
        
    def __str__(self) -> str:
        return self.name

class VariationManager(models.Manager):
    def colors(self):
        return super(VariationManager, self).filter(variation_category = "color", is_active = True)

class Variation(models.Model):
    product = models.ForeignKey("Product", on_delete=models.CASCADE)
    variation_category = models.CharField(max_length=100, choices=variation_category_choice)
    variation_value = models.CharField(max_length=100)
    is_active = models.BooleanField(default=True)
    created_date = models.DateField(auto_now=True)

    objects = VariationManager()

    def __str__(self) -> str:
        return self.variation_value

class Product(models.Model):
    product_name = models.CharField(
        max_length=60,
        null=False,
    )
    main_image = models.ImageField(null=True, blank=True)
    brief_info = models.CharField(
        max_length=255,
        null=False,
    )
    price = models.FloatField(
        null=False, #FIXME add decimal place decimalfield currency
    )
    like_status = models.BooleanField(
        null=True,
        default=False,
    )
    category = models.ForeignKey(
        'product.Category', 
        null=True, 
        blank=True, 
        on_delete=models.CASCADE,
        related_name="products",
    )
    tags = models.ManyToManyField(
        Tag,
        related_name="products",
        through="ProductTag",
    )
    brand = models.ForeignKey(
        'product.Brand', 
        null=False, 
        blank=True, 
        on_delete=models.CASCADE,
        related_name="products",
    )
    discount_status = models.BooleanField(
        null=True,
        default=False,
    )
    discount_percent = models.IntegerField(
        null=True
    )
    designer = models.ForeignKey(
        'product.Designer', 
        null=False, 
        blank=True, 
        on_delete=models.CASCADE,
        related_name="products",
    )
    product_detail = models.TextField(
        null=False,
    )
    delivery_info = models.TextField(
        null=False,
    )
    product_description = models.TextField(
        null=False,
    )
    product_info = RichTextField()
    availability = models.BooleanField(
        null=True,
        default=True,
    )
    color = models.ManyToManyField(
        Color, 
    )
    tags = models.ManyToManyField(
        Tag,
        related_name="products",
        through="ProductTag",
    )
    slug = models.SlugField(
        max_length=255,
        null=False, 
        blank=True, 
        unique=True, 
        editable=False, 
        db_index=True
        )
    order_count = models.IntegerField(default=0)
    hit_count = models.IntegerField(default=0)
    
    # moderation
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    
    class Meta:
        verbose_name_plural="products"
        constraints = [
            models.CheckConstraint(
                check = (Q(price__gte=0)),
                name="price constraints",
            ),
            models.CheckConstraint(
                check = (Q(discount_percent__gte=0) & Q(discount_percent__lte = 100)),
                name="discount percent constraints"
            )
        ]
    def clean(self):
        if self.price <=0:
             raise ValidationError("Price can not under or equal zero!")

    def __str__(self) -> str:
        return self.product_name

    def save(self, *args, **kwargs) -> None:
        if not self.slug:
            self.slug = unique_slug_generator(self, slugify(f"{self.brand.name}-{self.category.name}-{self.product_name}"))
        
        super().save(*args, **kwargs)

# Images table
class Image(models.Model):
    product = models.ForeignKey(
        'product.Product', 
        default=1, 
        on_delete=models.CASCADE,
        related_name="images",
    )
    image = models.ImageField(
        upload_to="product_images/%Y/%m/%d/",
        null=True,
        )
    is_main = models.BooleanField(default=False)

    def __str__(self) -> str:
        return self.product.product_name

class Brand(models.Model):
    name = models.CharField(
        max_length=60,
        null=False)

    def __str__(self) -> str:
        return self.name
        
# Designers table -- without test
class Designer(models.Model):
    name = models.CharField(
        max_length=255,
        null=False
    )
    def __str__(self) -> str:
        return self.name

class Review(models.Model):
    # user_id = 
    name = models.CharField(
        max_length=128,
        null=True,
        blank=True,
    )
    email = models.EmailField(
        null=True,
        blank=True,
    )
    review_text = models.TextField(
        null=True,
        blank=False,
    )
    rating = models.IntegerField(
        validators=[
            MaxValueValidator(5),
            MinValueValidator(1)
        ],
        null=True,
    )
    product = models.ForeignKey(
        'product.Product', 
        default=None,
        null=True, 
        blank=True, 
        on_delete=models.CASCADE,
        related_name="reviews"
    )
    
    # moderation
    created_at = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    updated_at = models.DateTimeField(auto_now=True, null=True, blank=True)

    def __str__(self) -> str:
        return self.review_text



class ProductTag(models.Model):
    tag_name = models.ForeignKey(Tag, on_delete=models.CASCADE, related_name="producttag",)
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name="producttag",)

    # moderation
    created_at = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    updated_at = models.DateTimeField(auto_now=True, null=True, blank=True)

    def __str__(self):
        return self.tag_name.name
