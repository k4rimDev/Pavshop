from django.http import HttpRequest, HttpResponse
from django.shortcuts import redirect
from django.urls import reverse


class LoginRequiredMixin:
    def dispatch(self, request: HttpRequest, *args, **kwargs) -> HttpResponse:
        if "user" not in request.session or not request.user:
            return redirect(reverse("core:home"))

        return super().dispatch(request, *args, **kwargs)
