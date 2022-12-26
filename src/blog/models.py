from django.db import models
from django.utils import timezone
from django.utils.text import slugify
from django.urls import reverse
from ckeditor.fields import RichTextField
from django.contrib.postgres.fields import JSONField
from django.conf import settings

from tools.unique_slug import unique_slug_generator


class Tag(models.Model):
    name = models.CharField(max_length=255)
    usage_count = models.IntegerField(default=0)
    
    # moderation
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name



class Blog(models.Model):
    title = models.CharField(
        max_length=255,
        null=False,
    )
    slug = models.SlugField(
        max_length=255, 
        null=True, 
        blank=True, 
        unique=True, 
        editable=False, 
        db_index=True
    )
    brief_info = models.CharField(max_length=200, null=True)
    author = models.ForeignKey(
        "users.Blogger",
        related_name="blogs",
        null=True,
        blank=True,
        on_delete=models.CASCADE,
    )
    text = RichTextField(
        null=False,
        blank=True
    )
    image = models.ImageField(
        upload_to="blogs/%Y/%m/%d/", 
        null=True,
        blank=True,
    )
    tags = models.ManyToManyField(
        Tag,
        related_name="blogs",
        through="BlogTag",
    )
    category = models.ForeignKey(
        "product.Category",
        related_name="blogs",
        null=False,
        blank=True,
        on_delete=models.CASCADE,
    )
    read_count = models.IntegerField(
        null=True,
        default=0,
    )

    # moderation
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


    class Meta:
        verbose_name_plural="blogs"

    def __str__(self) -> str:
        return self.title

    def save(self, *args, **kwargs) -> None:
        if not self.slug:
            self.slug = unique_slug_generator(self, slugify(f"{self.category.name}-{self.title}", allow_unicode=True))
        super().save(*args, **kwargs)
    
    def get_absolute_url(self):
        return reverse('blogs:blog-detail', kwargs={'slug': self.slug}) #FIXME view changed with api
    
    
# TODO we can delete the useless fields
class Comment(models.Model):
    comment = models.ForeignKey(
        Blog,
        null=True,
        blank=True,
        on_delete=models.CASCADE,
        related_name="comments",
    )
    name = models.CharField(
        max_length=128, 
        null=True,
    )
    email = models.EmailField(
        null=True, 
        blank=True,
    )
    subject = models.CharField(
        max_length=255, 
        null=False,
    )
    author = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        null=True, 
        blank=True,
        related_name="comments",
    )
    comment_text = models.TextField(
        null=False,
        blank=True,
    )
    parent = models.ForeignKey(
        'self', 
        null=True, 
        related_name='replies', 
        on_delete=models.CASCADE, 
        blank=True,
    )

    # moderation
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


    def __str__(self) -> str:
        return f"{self.author} {self.name}"


class BlogTag(models.Model):
    tag_name = models.ForeignKey(Tag, on_delete=models.CASCADE, related_name="blogtag",)
    blog = models.ForeignKey(Blog, on_delete=models.CASCADE, related_name="blogtag",)

    # moderation
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.tag_name.name