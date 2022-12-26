from django.shortcuts import render
from django.http import HttpResponse, HttpRequest


def get_language(request: HttpRequest) -> HttpResponse:
    language = (request.path).split('/')[1]
    context = {
        "LANGUAGES": language
    }
    return context