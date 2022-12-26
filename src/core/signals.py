from django.db.models.signals import post_save
from django.dispatch import receiver
from core.models import Subscription
from users.tasks import send_email_task


@receiver(post_save, sender=Subscription, dispatch_uid="send_info_email_to_subscriber")
def send_info_email_to_subscriber(sender, instance, created, **kwargs):
    if created:
        subscriber = instance
        email = subscriber.subscription_email
        subject = "Subscription Notification"
        message = "We received your message. You will be contacted as soon as possible"
        send_email_task.delay(subject = subject, email = message, user_email = email)
          