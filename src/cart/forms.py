from django import forms
from django.forms import ModelForm
from cart.models import Discount


class DiscountForm(ModelForm):
    shipping_form = forms.BooleanField(widget=forms.HiddenInput, initial=True)

    class Meta:
        model = Discount
        fields = ("discount_code", )

        widgets = {
            'discount_code': forms.TextInput(attrs={'class': 'form-control', "placeholder": "ENTER YOUR CODE IF YOU HAVE ONE"}),
        }
