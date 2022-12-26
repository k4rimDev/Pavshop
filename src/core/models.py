from django.db import models


# Backgrounds table for each page
class Background(models.Model):
    home_page = models.ImageField(default = "about/home.png", upload_to = "about")
    about_page = models.ImageField(default = "about/about.png", upload_to = "about")
    contact_page = models.ImageField(default = "contact/contact-us.jpeg", upload_to = "contact")
    blog_page = models.ImageField(default = "blog/blog-bg.jpeg", upload_to = "blog-bg")
    product_page = models.ImageField(default = "products/products-list-bg.jpeg", upload_to="products")
    order_page = models.ImageField(default = "order/payment-card.jpeg", upload_to = "order")
    login_register_page = models.ImageField(default = "users/login-register.jpeg", upload_to = "users")
    cart_page = models.ImageField(default="cart/view-cart.jpeg", upload_to="cart")

# Only site users can be subscriber :/
class Subscription(models.Model):
    subscription_email = models.EmailField(
        max_length=128,
        null=True,
        blank=True,
    )

    # moderation
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self) -> str:
        return self.subscription_email

    class Meta:
        verbose_name = 'subscription'

# WHY WE NEED THIS TABLE?
class Contact(models.Model):
    full_name = models.CharField(
        max_length=128, 
        null=True,
        blank=True,
    )
    email = models.EmailField(
        max_length=128, 
        blank=True,
        null=True
    )
    phone = models.CharField(
        max_length=10,
        null=True,
        blank=True,
    )
    subject = models.CharField(
        max_length=255,
        null=True,
        blank=True,
    )
    message = models.TextField(
        null=True,
        blank=True,
    )

    # moderation
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

# WE DON'T NEED THIS TABLE!! FIXME
class Staff(models.Model):
    full_name = models.CharField(max_length=255)

    facebook_url = models.CharField(max_length=255, null=True)
    twitter_url = models.CharField(max_length=255, null=True)
    website_url = models.CharField(max_length=255, null=True)

    email = models.EmailField()
    image = models.ImageField(
        upload_to="staff_images/%Y/%m/%d/",
        null=True,
        blank=True,
    )
    position = models.CharField(max_length=255)
    description = models.TextField(
        null=True,
        blank=True,
        )

    class Meta:
        verbose_name = "staff"
        verbose_name_plural = "staff"
    # facebook_url = models.CharField(max_length=255)
    # twitter_url = models.CharField(max_length=255)
    # website_url = models.CharField(max_length=255)
    def __str__(self) -> str:
        return self.full_name

# Home slider table
class Slider(models.Model):
    title = models.CharField(max_length = 255, null = True)
    description = models.CharField(max_length = 300, null = True)
    price = models.FloatField()
    product_link = models.CharField(max_length = 255, null = True)
    image = models.ImageField(null = True, upload_to = "core")

class Feedback(models.Model):
    text = models.TextField(null=True)
    author = models.CharField(max_length=200, null=True)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now_add=True)

class Sponsor(models.Model):
    image = models.ImageField(upload_to="sponsors")

class AwesomeCulture(models.Model):
    image = models.ImageField(upload_to="cultures")

class About(models.Model):
    main_image = models.ImageField(upload_to="about-page")
    about_header_text = models.TextField()
    about_footer_text = models.TextField()
