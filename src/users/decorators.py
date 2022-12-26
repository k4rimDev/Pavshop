from django.http import HttpRequest, HttpResponse


def check_user_login(func):
    def wrapper(request, *args, **kwargs):
        # if func.request.session.get("user"):
        #     ...
        # elif func.request.user:
        #     ...

        print(request.session.get("user"))
    
        return func(request, *args, **kwargs)
    return wrapper