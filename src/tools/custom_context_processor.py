from django.http.request import HttpRequest
from blog.forms import SearchForm
from core.forms import SubscriptionForm
from blog.services.blogs import get_blog
from core.services.core import subscribe_to_newsletter


def search_renderer(request: HttpRequest):
    search_blog_form = SearchForm()
    if 'search_text' in request.GET:
        searched_blog = get_blog(request.GET['search_text'])
        return {
            'search_blog_form': search_blog_form,
            'searched_blog': searched_blog,
        }
        
    return {
        'search_blog_form': search_blog_form,
    }

def user(request: HttpRequest):
    if request.session.get("user"):   
        current_user = request.session.get("user")
        print(current_user)
        if current_user:
            return {
                'user_email': current_user["userinfo"]["email"],
                'username': current_user["userinfo"]["given_name"],
                'current_user': current_user
            }
        else:
            return {
                'user_email': None
            }
    elif request.user:
        current_user = request.user
        if current_user.is_authenticated:
            return {
                'user_email': current_user.email,
                'username': current_user.first_name + " " + current_user.last_name,
                'current_user': current_user
            }
        else:
            return {
                'user_email': None
            }

def newsletter_subscription(request: HttpRequest):
    subscription_form = SubscriptionForm()
    if request.method == 'POST':
        if "subscription_email" in request.POST:
            subscription_form = SubscriptionForm(request.POST)
            if subscription_form.is_valid:
                email = request.POST.get('subscription_email')
                subscribe_to_newsletter(subscription_email=email)
    
    context = {
        'subscription_form': subscription_form
    }m
    return context
