import pytest

from django.urls import reverse

@pytest.mark.django_db
def test_root_url(client):
   url = reverse('home')
   response = client.get(url)
   assert response.status_code == 200


@pytest.mark.django_db
def test_about_url(client):
   url = reverse('about')
   response = client.get(url)
   assert response.status_code == 200


@pytest.mark.django_db
def test_contact_url(client):
   url = reverse('contact')
   response = client.get(url)
   assert response.status_code == 200


@pytest.mark.django_db
def test_blog_url(client):
   url = reverse('blogs')
   response = client.get(url)
   assert response.status_code == 200


@pytest.mark.django_db
def test_blog_details_url(client):
   url = reverse('blog-detail')
   response = client.get(url)
   assert response.status_code == 200