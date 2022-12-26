from core.models import Background

from urllib.parse import quote_plus, urlencode
from django.shortcuts import render, redirect
from django.http import HttpRequest, HttpResponse, JsonResponse
from authlib.integrations.django_client import OAuth
from django.db.models.query_utils import Q
from django.contrib.auth.decorators import login_required
from users.forms import PasswordChangingForm, UserForm, RegisterForm
from django.contrib.auth import login, logout, get_user_model
from django.contrib.auth.forms import AuthenticationForm, PasswordResetForm
from django.conf import settings
from django.urls import reverse
from django.contrib.auth import update_session_auth_hash, login, authenticate, logout
from django.contrib import messages

from django.utils.encoding import force_str
from django.utils.http import urlsafe_base64_decode

from users.services.users import send_user_email, create_user_if_not_exist
from users.utils.tokens import account_activation_token

from users.tasks import send_confirmation_mail

from order.models import Billing, Shipping
from order.forms import ShippingForm



User = get_user_model()

        
def login_user(request: HttpRequest) -> HttpResponse:
    if request.user.is_authenticated or request.session.get("user"):
        return redirect("/")
    else:
        if request.method == 'POST':
            login_form = AuthenticationForm(request, data=request.POST)
            if login_form.is_valid():
                username = login_form.cleaned_data.get('username')
                password = login_form.cleaned_data.get('password')
                user = authenticate(username=username, password=password) 
                if user is not None:
                    login(request, user)
                    
                    messages.info(request, f'You are now logged in as {username}')
                    
                    # Check cookies if cart exists then added to database
                    return redirect("carts:check_basket")
                else:
                    messages.error(request, 'Invalid username or pasword.')
            else:
                messages.error(request, 'Invalid username or password.')
        login_form = AuthenticationForm(request)
        login_background = Background.objects.all()[0]
        context = {
            'title': 'Login',
            'login_form': login_form,
            'login_register_background': login_background.login_register_page,
            }
        return render(request, 'users/login.html', context=context)


def register_user(request: HttpRequest) -> HttpResponse:
    if request.user.is_authenticated:
        return redirect('/')
    else:
        register_form = RegisterForm()
        if request.META.get('HTTP_X_REQUESTED_WITH') == 'XMLHttpRequest' and request.method == 'POST':
            register_form = RegisterForm(request.POST)
            if register_form.is_valid():
                register_form.clean()

                user = register_form.save()
                user.is_active = False
                user.save()
                send_confirmation_mail(user)
                
                billing = Billing.objects.create(
                    user = user,
                    first_name = user.first_name,
                    last_name = user.last_name,
                    phone = user.phone,
                    address = user.address,
                )

                billing.save()

                shipping = Shipping.objects.create(
                    user = user,
                    address = user.address,
                    country = user.country,
                    city = user.city,
                    region = str(user.country + user.city),
                    zipcode = user.zip_code,
                    phone = user.phone,
                    company_name = None
                )
                
                shipping.save()

                messages.success(request, 'We sent Confirmation Email !')
                
                # Check cookies if cart exists then added to database
                # return redirect("carts:check_basket")
                return redirect("users:login")

            else:
                # messages.error(request, 'Registration is unseccessful. Please fill the form correctly.')
                return JsonResponse({"error": register_form.errors}, status=406)

        register_background = Background.objects.all()[0].login_register_page
        # messages.error(request, 'Registration is unseccessful. Please fill the form correctly.')
        register_form = RegisterForm()

        context={
            "register_form": register_form,
            'title': 'Register',
            'login_register_background': register_background,
            'register_form_errors': register_form.error_class,
        }
        return render(request, "users/register.html", context=context)


# ---------------------------------

oauth = OAuth()

oauth.register(
    "auth0",
    client_id=settings.AUTH0_CLIENT_ID,
    client_secret=settings.AUTH0_CLIENT_SECRET,
    client_kwargs={
        "scope": "openid profile email",
    },
    server_metadata_url=f"https://{settings.AUTH0_DOMAIN}/.well-known/openid-configuration",
)

def login_social(request: HttpRequest) -> HttpResponse:
    return oauth.auth0.authorize_redirect( # type: ignore
        request, request.build_absolute_uri(reverse("users:callback"))
    )
    

def callback(request: HttpRequest) -> HttpResponse:
    user: dict = oauth.auth0.authorize_access_token(request) # type: ignore

    create_user_if_not_exist(
        first_name=user["userinfo"]["given_name"],
        username = user["userinfo"]["nickname"],
        email=user["userinfo"]["email"]
    )
    

    request.session["user"] = user

    return redirect(request.build_absolute_uri(reverse("core:home")))

def logout_user(request: HttpRequest) -> HttpResponse:
    response = redirect(request.build_absolute_uri(reverse("core:home")))
    response.delete_cookie('cart')
    if request.session.get("user") == None:
        logout(request)
        messages.info(request, 'Successfully logged out.')
    else:
        logout_user_auth0(request)
    
    return response


def logout_user_auth0(request: HttpRequest) -> HttpResponse:    
    if request.user.is_authenticated:
        logout(request)
        return redirect("users:login")
    
    else:
        request.session.clear()
        return redirect(
            f"https://{settings.AUTH0_DOMAIN}/v2/logout?"
            + urlencode(
                {
                    "returnTo": request.build_absolute_uri(reverse("core:home")),
                    "client_id": settings.AUTH0_CLIENT_ID,
                },
                quote_via=quote_plus,
            ),
        )



@login_required(login_url="users:login")
def user_profile(request: HttpRequest) -> HttpResponse:
    user = request.user
    form = UserForm(initial={'first_name': request.user.first_name, 'last_name': request.user.last_name, 'email': request.user.email, 'username': request.user.username}) # type: ignore
    shipping_form = ShippingForm(initial={"phone": user.shipping.last().phone, "country": user.shipping.last().country, "city": user.shipping.last().city, "zipcode": user.shipping.last().zipcode, "address": user.shipping.last().address})

    password_form = PasswordChangingForm(request.user) # type: ignore
    if request.method == 'POST':
        if "shipping_form" in request.POST:
            shipping_form = ShippingForm(request.POST)
            if shipping_form.is_valid():
                shipping_form.save()
        if "username" in request.POST:
            form = UserForm(request.POST)
            user.username = request.POST.get("username")
            user.email = request.POST.get("email")
            user.first_name = request.POST.get("first_name")
            user.last_name = request.POST.get("last_name")
            user.save()

        else:
            print(password_form.errors)
            return JsonResponse({"error": password_form.errors}, status=406)
    context = {
        'title': 'Profile',
        "user": user,
        'form': form,
        'passwordForm': password_form,
        "shipping_form": shipping_form
    }
    return render(request, 'users/profile2.html', context=context)

def password_reset_request(request):
    if request.method == "POST":
        password_reset_form = PasswordResetForm(request.POST)
        if password_reset_form.is_valid():
            data = password_reset_form.cleaned_data['email']
            user = User.objects.filter(Q(email=data)).last()
            if user:
                send_user_email(user)
                return redirect ("core:home")
    password_reset_form = PasswordResetForm()
    return render(request=request, template_name="users/password/password_reset.html", context={"password_reset_form":password_reset_form})

def confirmation(request: HttpRequest, uuidb64: str, token: str) -> HttpResponse:
    uuid = force_str(urlsafe_base64_decode(uuidb64))
    print(uuid, 'uuiduuiduuiduuiduuiduid')
    user = User.objects.filter(id = int(uuid), is_active = False).first()
   
    print(user, "asfsfsdfsadfasffajsflakjsflashflashflsadfh")
    print(token, "token--------------------------------------------------------")
    print(account_activation_token.check_token(user, token) , "token----------  --------------------------------")
    if user and account_activation_token.check_token(user, token): # type: ignore
        messages.success(request, 'Your account activated') 
        user.is_active = True # type: ignore
        user.save()
        return redirect("users:login")
    else:
        messages.error(request, 'your link expired or link invalid')
        return redirect("/")
