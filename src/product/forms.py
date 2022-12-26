from django import forms
from django.forms import ModelForm
from .models import Review
from django.core.validators import RegexValidator

# Review form on product-detail.html
class ReviewForm(ModelForm):
    class Meta:
        model = Review
        exclude = ['reviewed_at']
        fields = '__all__'
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control', 'name': 'name', 'required': 'required'}),
            'email': forms.EmailInput(attrs={'class': 'form-control', 'name': 'email', 'placeholder':'username@example.com', 'required': 'required'}),
            'review_text': forms.Textarea(attrs={'class':'form-control', 'name': 'review_text', 'placeholder': 'Write...', 'required': 'required'}),
            'product_id': forms.HiddenInput(attrs={'class': 'product_id', 'name': 'product_id'}),
            'rating': forms.HiddenInput(attrs={'class': 'rating-input', 'name':'rating'})
        }
        labels= {
            'name': '*NAME',
            'email': '*EMAIL',
            'review_text': '*YOUR REVIEW',
            'product_id': '',
            'rating': 'YOUR RATING',
        }
        required=(
            'name',
            'email',
            'review_text',
        )
        # validators ={
        #     'email': [RegexValidator('[a-zA-z0-9_\-\.] + [@][a-z]+[\.][a-z]{2,3}',
        #     message='Enter an email in correct format')],
        # }

        def fields_required(self, fields):
            for field in fields:
                if not self.cleaned_data.get(field, ''):
                    msg = forms.ValidationError('Please enter'+ field)
                    self.add_error(field, msg)

        def clean(self):
            try:
                cleaned_data = super(ReviewForm, self).clean()
                name = self.cleaned_data['name']
                email = self.cleaned_data['email']
                review_text = self.cleaned_data['review_text']
                product_id = self.cleaned_data['product_id']
                rating = self.cleaned_data['rating']
                if len(email)< 7:
                    raise forms.ValidationError('Your email is too short')
                return cleaned_data
            except:
                raise forms.ValidationError('')

    