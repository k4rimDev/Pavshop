from django.contrib.auth import get_user_model
from django.contrib.auth.hashers import make_password
from django.template.loader import render_to_string
from django.contrib.auth.tokens import default_token_generator
from django.utils.encoding import force_bytes
from django.utils.http import urlsafe_base64_encode
from users.tasks import send_email_task

User = get_user_model()

def send_user_email(user):
    subject = "Password Reset Requested"
    email_template_name = "users/password/password_reset_email.txt"
    c = {
    "email":user.email,
    'domain':'127.0.0.1:8000',
    'site_name': 'PavShop',
    "uid": urlsafe_base64_encode(force_bytes(user.pk)),
    'token': default_token_generator.make_token(user),
    'protocol': 'http',
    }
    email = render_to_string(email_template_name, c)
    send_email_task.delay(subject = subject, email = email, user_email = user.email)


def create_user_if_not_exist(
    *,
    email: str,
    first_name: str,
    username: str
) -> None:
    if User.objects.filter(email=email).exists():
        return

    password = make_password(password=None)

    user = User(
        username=f"{username}{email}",
        email=email,
        first_name=first_name,
        password=password
    )
    user.save()