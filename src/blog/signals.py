from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import BlogTag
from blog.models import Tag


@receiver(post_save, sender=BlogTag, dispatch_uid="increase_blog_tag_usage_count")
def increase_blog_tag_usage_count(sender, instance, created, **kwargs):
    if created:
        instance.tag_name.usage_count = instance.tag_name.usage_count + 1
        Tag.objects.filter(name=instance.tag_name).update(usage_count=instance.tag_name.usage_count)