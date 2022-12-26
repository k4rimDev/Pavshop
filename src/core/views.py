from django.http.request import HttpRequest
from django.http.response import HttpResponse
from django.shortcuts import render, redirect
from django.urls import translate_url
from django.http import JsonResponse

from django.conf import settings

from core.forms import ContactForm
from core.models import Background, Contact, Feedback, Slider, About, AwesomeCulture

from users.tasks import send_email_task

from django.views.generic import CreateView
from django.views.decorators.cache import cache_page
from product.models import Product
from django.db.models import Q


# def set_language(request, language):    
#     for lang, _ in settings.LANGUAGES:
#         translation.activate(lang)
#         try:
#             view = resolve(urlparse(request.META.get("HTTP_REFERER")).path)
#         except Resolver404:
#             view = None
#         if view:
#             break
#     if view:
#         translation.activate(language)
#         next_url = reverse(view.url_name, args=view.args, kwargs=view.kwargs)
#         response.set_cookie(settings.LANGUAGE_COOKIE_NAME, language)
#         # response = request.COOKIES.get(settings.LANGUAGE_COOKIE_NAME, language)
#         # request.session[translation.LANGUAGE_SESSION_KEY] = language
#         request.session['language'] = language
#         print(request.META.get("HTTP_REFERER"), '----------------------------------------------------------------')
#         response = HttpResponseRedirect(next_url)
#     else:
#         response = HttpResponseRedirect("/")
#     return response


def set_language(request, language, path):
    print(path)
    list_path = path.split("/")
    for path in list_path:
        if path in settings.LANGUAGES:
            list_path.remove(path)
        
    path = "/".join(list_path)
    print(path, '----------------------------------------------------------------')

    lang = request.META.get("HTTP_REFERER", None)
    response = redirect(translate_url(path, language))
    response.set_cookie(settings.LANGUAGE_COOKIE_NAME, language)
    return response

# @cache_page(60 * 15)
def home(request: HttpRequest) -> HttpResponse:
    home_background = Background.objects.all()[0]
    home_background = home_background.home_page
    feedbacks = Feedback.objects.all()[:3]
    sliders = Slider.objects.all()[:4]
    last_product = Product.objects.all()[0]
    context = {
        'title': 'Home',
        'home_background': home_background,
        'feedbacks': feedbacks,
        'sliders': sliders,
        'last_product': last_product
    }
    return render(request, 'core/index.html', context = context)


@cache_page(60 * 15)
def about(request: HttpRequest) -> HttpResponse:
    about_background = Background.objects.all()[0]
    awesomeculture = AwesomeCulture.objects.all()
    about = About.objects.all()[0]
    print(about.main_image.url)
    about_background = about_background.about_page
    context = {
        'title': 'About',
        'about_background': about_background,
        'awesomeculture': awesomeculture,
        'about': about
    }
    return render(request, 'core/about-us.html', context=context)


# @cache_page(60 * 15)
class ContactUs(CreateView):
    template_name = 'core/contact.html'
    form_class = ContactForm   
    contact_background = Background.objects.all()[0].contact_page

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["title"] = "Contact"
        context["form"] = self.form_class
        context["contact_background"] = self.contact_background
        return context

    def form_valid(self, form):
        contact_user = form.save()
        send_email_task(subject="Pavshop Team Notification", email="Your contact form has been saved successfully", user_email=contact_user.email)
        return super(ContactUs, self).form_valid(form) 
    

@cache_page(60 * 15)
# Deprecated view
def contact(request: HttpRequest) -> HttpResponse:
    contact_form = ContactForm()
    contact_background = Background.objects.all()[0]
    
    if request.META.get('HTTP_X_REQUESTED_WITH') == 'XMLHttpRequest' and request.method == 'POST':
        contact_form = ContactForm(request.POST)
        print(request.POST)
        if contact_form.is_valid():
            contact_user= contact_form.save(commit=False)
            send_email_task(subject="Pavshop Team Notification", email="Your contact form has been saved successfully", user_email=contact_user.email)
            contact_user.save()
        else:
            return JsonResponse({"error": contact_form.errors}, status=406)
    
    context = {
        'form': contact_form, 
        'title': 'Contact',
        'contact_background': contact_background.contact_page,
    }
    return render(request, 'core/contact.html', context=context)
