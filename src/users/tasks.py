from datetime import timedelta, datetime
from django.utils import timezone
from django.core.mail import EmailMessage
from time import sleep
from django.core.mail import send_mail
from django.template.loader import render_to_string
from templated_email import send_templated_mail

from django.contrib.auth import get_user_model
from django.utils.http import urlsafe_base64_encode
from django.utils.encoding import force_bytes
from django.urls import reverse_lazy
from django.conf import settings

from celery import shared_task

from django.db.models import Count
from users.models import User
from product.models import Product
from pavshop.celery import app

from users.utils.tokens import account_activation_token

users = User.objects.all()
current_user = get_user_model()


@shared_task
def send_confirmation_mail(user):
    token = account_activation_token.make_token(user) # check if user is exists
    uuid = urlsafe_base64_encode(force_bytes(user.id)) # check who is user
    redirect_url = f"http://127.0.0.1:8000{reverse_lazy('users:confirmation', kwargs={'uuidb64': uuid,'token': token})}"
    body = render_to_string('email/confirmation-email.html', context={'user': user, 'redirect_url': redirect_url})
    message = EmailMessage(subject = "Email Verification", body = body, from_email = settings.EMAIL_HOST_USER, to=[user.email])
    message.content_subtype = 'html'
    message.send()


@shared_task
def send_email_user_not_logged_in_for_30_days():
    users = User.objects.all()
    one_month_ago = datetime.today() - timedelta(days=30)
    for user in users:
        print(timezone.now() - user.last_login) # type: ignore
        if timezone.now() - user.last_login >= timedelta(days = 30): # type: ignore
            send_templated_mail(
                template_name='email-subscribers',
                from_email=settings.EMAIL_HOST_USER,
                recipient_list=[user.email],
                context={
                    'message': "We are miss you!",
                    'product_count': 5,
                    'domain': "http://127.0.0.1:8000",
                    'current_user': user.full_name,
                    'products': Product.objects.filter(created_at__gte = one_month_ago)
                    .annotate(
                        review_count = Count(
                            'reviews'
                        )
                    ).order_by('-reviews')
                    [:5],
                }
            )       
    return None

@shared_task
def send_email_task(*, subject, email, user_email):
    sleep(10)
    send_mail(
        subject,    
        email,
        '321kerim123@gmail.com',
        [user_email],
    )
    return None
    
@app.task
def setup_periodic_tasks():
    one_week_ago = datetime.today() - timedelta(days=7)
    for user in users:
        send_templated_mail(
        template_name='email-subscribers',
        from_email=settings.EMAIL_HOST_USER,
        recipient_list=[user.email],
        context={
            'domain': "http://127.0.0.1:8000",
            'product_count': 3,
            'current_user': user.full_name,
            'products': Product.objects.filter(created_at__gte = one_week_ago)
            .annotate(
                review_count = Count(
                    'reviews'
                )
            ).order_by('-reviews_count')
            [:3],
        }
    )  
    