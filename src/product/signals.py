from django.db.models.signals import m2m_changed, post_save
from django.dispatch import receiver
from .models import ProductTag
from blog.models import Tag


@receiver(post_save, sender=ProductTag, dispatch_uid="increase_product_tag_usage_count")
def increase_product_tag_usage_count(sender, instance, created, **kwargs):
    if created:
        instance.tag_name.usage_count = instance.tag_name.usage_count + 1
        Tag.objects.filter(name=instance.tag_name).update(usage_count=instance.tag_name.usage_count)