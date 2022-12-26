from django.db.models import QuerySet, Avg, Q, Count
from core.models import Subscription, Contact

# Subscribtion queryset
def subscribe_to_newsletter(subscription_email: str) -> None:
    subscription, created = Subscription.objects.get_or_create(subscription_email=subscription_email)
    print(subscription, created)
    if created:
        subscription.save()


# Contact_information queryset
def add_contact_information(full_name: str, email: str, phone: str, subject: str, message: str) -> None:
    Contact.objects.get_or_create(full_name=full_name, email=email, phone=phone, subject=subject, message=message)
