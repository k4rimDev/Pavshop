from django.db.models.signals import post_save
from django.dispatch import receiver
from order.models import Order, OrderItem
from templated_email import send_templated_mail
from django.conf import settings


@receiver(post_save, sender=OrderItem)
def create_order_pdf(sender, instance: OrderItem, created: bool, **kwargs) -> None:
    if created:
        order_item = instance
        order = order_item.order
        print(order.order_item.all(), "kerimkerimkeri")
        order_items = OrderItem.objects.filter(order=order)
        send_templated_mail(
                template_name='order_success',
                from_email=settings.EMAIL_HOST_USER,
                recipient_list=[settings.EMAIL_HOST_USER],
                context={
                    'domain': "http://127.0.0.1:8000",
                    "order": order,
                    "subtotal": order.order_item.all().first().subtotal,
                    "total": order.order_item.all().first().total,
                    "order_items": order_items
                }
            ) 
        
            