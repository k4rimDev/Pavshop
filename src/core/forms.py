import re
from django import forms
from django.forms import ModelForm
from .models import Contact
from django.core.validators import RegexValidator, EmailValidator
from core.models import Subscription


# Subscription form on base.html
class SubscriptionForm(ModelForm):
    class Meta:
        model = Subscription
        fields = ("subscription_email", )
    
        widgets = {
            'subscription_email': forms.TextInput(attrs={'class': 'form-control', "placeholder": "Enter your email address"}),
        }


# Contact form on contact.html
class ContactForm(ModelForm):
    class Meta:
        model = Contact
        fields = '__all__'

        widgets = {
            'full_name': forms.TextInput(attrs={'class': 'form-control'}),
            'phone': forms.TextInput(attrs={'class': 'form-control'}),
            'email': forms.EmailInput(attrs={'class': 'form-control', 'placeholder': 'username@example.com'}),
            'subject': forms.TextInput(attrs={'class': 'form-control'}),
            'message': forms.Textarea(attrs={'class': 'form-control', 'rows':4, 'cols':40}),
        }
        labels = {
            'full_name': '*FULL NAME',
            'email': '*EMAIL',
            'phone': '*PHONE',
            'subject': '*SUBJECT',
            'message': '*COMMENTS'
        }

        required = (
            'email',
            'full_name',
            'phone',
            'subject',
            'message'
        )

        validators ={
            'email': [RegexValidator('[a-zA-z0-9_\-\.]+[@][a-z]+[\.][a-z]{2,3}', message='Enter an email in correct format')],
            'phone': [RegexValidator('[0-9]{3}[0-9]{7}', message="Enter a valid 10 digit phone number")]
        }

    def fields_required(self, fields):
        for field in fields:
            if not self.cleaned_data.get(field, ''):
                msg = forms.ValidationError("Please enter " + field)
                self.add_error(field, msg)

    # def clean(self):
    #     cleaned_data = super(ContactForm, self).clean()
    #     subject = self.cleaned_data['subject']
    #     full_name = self.cleaned_data['full_name']
    #     email = self.cleaned_data['email']
    #     phone = self.cleaned_data['phone']
    #     message = self.cleaned_data['message']
    #     print(email, "kerim yaxsi")
    #     is_phone_matched = bool(re.match('[0-9]{3}[0-9]{7}', phone))
    #     print('akif akif akif', is_phone_matched)

    #     if len(phone) < 10 or not is_phone_matched:
    #         print('kerim kerim kerim', is_phone_matched)
    #         self.errors['phone']='Invalid phone number'
    #         raise forms.ValidationError('Your phone is too short')

    #     if len(full_name) < 4:
    #         print("ful")
    #         self._errors['full_name']='Your full name\'s length is too short'
    #         raise forms.ValidationError('Your full name is too short')
            
    #     if len(email) < 7:
    #         print("email")
    #         self._errors['email']='Your email\'s length is too short'
    #         raise forms.ValidationError('Your email is too short')

    #     if(re.match(r'^[a-zA-z0-9_\-\.]+[@][a-z]+[\.][a-z]{5,3}', email)):
    #         print('enail 2')
    #         raise forms.ValidationError('Invalid email address')

    #     if (re.match(r'[0-9]{3}[0-9]{7}', phone)):
    #         print('phone 3')
    #         self._errors['phone']='Invalid phone number'
    #         raise forms.ValidationError('Invalid phone number')


    #     return cleaned_data
