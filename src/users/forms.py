from django.forms import ModelForm
from django import forms
from django.contrib.auth.forms import UserCreationForm, PasswordChangeForm
from django.contrib.auth import get_user_model

User = get_user_model()

class RegisterForm(UserCreationForm):
    class Meta:
        model = User
        fields = ('first_name', 'last_name', 'email', 'phone', 'password1', 'address', 'country', 'city', 'password2')

        widgets = {
            'first_name': forms.TextInput(attrs={'class': 'form-control col-lg-6', 'style': 'display:block;'}),
            'email': forms.EmailInput(attrs={'class': 'form-control col-lg-6', 'style': 'display:block;'}),
            'last_name': forms.TextInput(attrs={'class': 'form-control'}),
            'password': forms.PasswordInput(attrs={'class': 'form-control'}),
            'phone': forms.TextInput(attrs={'class': 'form-control'}),
            'city': forms.TextInput(attrs={'class': 'form-control'}),
            'country': forms.Select(attrs={'class': 'selectpicker'}),
            'address': forms.Textarea(attrs={'class': 'form-control'}),
        }

        labels ={
            'first_name': '*FIRST NAME',
            'email': '*EMAIL',
            'last_name': '*LAST NAME',
            'password': '*PASSWORD',
            'phone': '*PHONE',
            'city': '*TOWN/CITY',
            'country': 'COUNTRY',
            'address': '*ADDRESS',
        }

class UserForm(ModelForm):
    class Meta:
        model = User
        fields = ('first_name', 'last_name', 'email', 'username')

        widgets = {
            'first_name': forms.TextInput(attrs={'class': 'form-control form-control-alternative', 'name': 'first_name', 'initial': 'value'}),
            'last_name': forms.TextInput(attrs={'name': 'last_name', 'class': 'form-control form-control-alternative', 'initial': 'value'}),
            # 'phone': forms.TextInput(attrs={'class': 'form-control form-control-alternative', 'name': 'phone'}),
            'email': forms.EmailInput(attrs={'class': 'form-control form-control-alternative', 'name': 'email', 'initial': 'value'}),
            'username': forms.TextInput(attrs={'class': 'form-control form-control-alternative', 'name': 'username'}),
        }
        labels = {
            'first_name': 'FIRST NAME',
            'email': 'EMAIL',
            'last_name': 'LAST NAME',
        }

        value = {
            'first_name': 'value',
            'last_name': 'value',
            'email': 'value',
        }

class UserPasswordForm(forms.Form):
    labels = {
            'password': 'CURRENT PASSWORD',
            'new_password': 'NEW PASSWORD',
            'new_password_confirmation': 'NEW PASSWORD CONFIRMATION',
        }

    current_password = forms.CharField(widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    new_password = forms.CharField(widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    new_password_confirmation = forms.CharField(widget=forms.PasswordInput(attrs={'class': 'form-control'}))

class PasswordChangingForm(PasswordChangeForm):
    old_password = forms.CharField(widget=forms.PasswordInput(attrs={'class': 'form-control form-control-alternative', 'type': 'password'}))
    new_password1 = forms.CharField(widget=forms.PasswordInput(attrs={'class': 'form-control form-control-alternative', 'type': 'password'}))
    new_password2 = forms.CharField(widget=forms.PasswordInput(attrs={'class': 'form-control form-control-alternative', 'type': 'password'}))

    class Meta:
        model = User
        fields = ('old_password', 'new_password1', 'new_password2')
        labels = {
            'old_password': 'CURRENT PASSWORD',
            'new_password1': 'NEW PASSWORD',
            'new_password2': 'NEW PASSWORD CONFIRMATION',
        }   
