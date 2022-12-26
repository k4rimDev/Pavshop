from django import forms
from django.forms import ModelForm
from order.models import Order, Shipping, Billing


class ShippingForm(ModelForm):
    shipping_form = forms.BooleanField(widget=forms.HiddenInput, initial=True)

    class Meta:
        model = Shipping
        fields = '__all__'

        widgets = {
            'company_name': forms.TextInput(attrs={'class': 'form-control form-control-alternative', "disabled": "true"}),
            'phone': forms.TextInput(attrs={'class': 'form-control form-control-alternative', "disabled": "true"}),
            'country': forms.TextInput(attrs={'class': 'form-control form-control-alternative', "disabled": "true"}),
            'city': forms.TextInput(attrs={'class': 'form-control form-control-alternative', "disabled": "true"}),
            'address': forms.TextInput(attrs={'class': 'form-control form-control-alternative', "disabled": "true"}),
            'zipcode': forms.TextInput(attrs={'class': 'form-control form-control-alternative', "disabled": "true"}),
        }
        labels = {
            'company_name': 'COMPANY NAME',
            'phone': '*PHONE',
            'country': 'COUNTRY',
            'city': '*TOWN/CITY',
            'address': '*ADDRESS',
            'zipcode': '*ZIP',
        }

class BillingForm(ModelForm):
    billing_form = forms.BooleanField(widget=forms.HiddenInput, initial=True)
    class Meta:
        model = Billing
        fields = "__all__"

        widgets = {
            'first_name': forms.TextInput(attrs={'class': 'form-control'}),
            'last_name': forms.TextInput(attrs={'class': 'form-control'}),
            'address': forms.TextInput(attrs={'class': 'form-control'}),
            'phone': forms.TextInput(attrs={'class': 'form-control'}),

        }
        labels = {
            'first_name': '*FIRST NAME',
            'last_name': '*LAST NAME',
            'address': '*ADDRESS',
            'phone': '*PHONE',
        }   

class OrderForm(ModelForm):
    order_form = forms.BooleanField(widget=forms.HiddenInput, initial=True)

    class Meta:
        model = Order
        fields = '__all__'
        exclude = []

        widgets = {
            'payment': forms.TextInput(attrs={'class': 'form-control'}),

        }
        labels = {
            'payment': '*PAYMENT',
        } 
