from django import forms
from django.forms import ModelForm

from .models import Comment


class CommentForm(ModelForm):
    class Meta:
        model = Comment
        fields = ('comment', 'parent', 'name', 'email', 'subject', 'comment_text')

        widgets = {
            'comment': forms.HiddenInput(attrs={'initial': 'value'}),
            'parent': forms.HiddenInput(attrs={'name': 'parent_id', 'initial': 'value'}),
            'name': forms.TextInput(attrs={'class': 'form-control', 'name': 'name'}),
            'email': forms.EmailInput(attrs={'class': 'form-control', 'required': 'required', 'name': 'email'}),
            'subject': forms.TextInput(attrs={'class': 'form-control', 'name': 'subject'}),
            'comment_text': forms.Textarea(attrs={'class': 'form-control', 'rows':4, 'cols':15, 'name': 'comment_text'}),
        }
        labels = {
            'name': 'NAME',
            'email': 'EMAIL',
            'subject': 'SUBJECT',
            'comment_text': 'COMMENTS'
        }
    
        value = {
            'comment': 'value'
        }

    def clean(self):
        cleaned_data = super().clean()
        email = self.cleaned_data['email']
        if email is not None:
            if len(email) < 10:
                raise forms.ValidationError('Your email is too short')

        return cleaned_data

class SearchForm(forms.Form):
    search_text = forms.CharField(max_length=128, widget=forms.TextInput(attrs={'placeholder': 'SEARCH', 'class': 'form-control', 'name': 'search_text'}))
        