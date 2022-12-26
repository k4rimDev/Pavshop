from django.utils.text import slugify
'''
random_string_generator is located here:
http://joincfe.com/blog/random-string-generator-in-python/
'''
# from random import randrange

def unique_slug_generator(instance, new_slug=None, i=2):
    """
    This is for a Django project and it assumes your instance
    has a model with a slug field and a title character (char) field.
    """
    if new_slug is not None:
        slug = new_slug
    else:
        slug = slugify(instance.name)

    Klass = instance.__class__
    qs_exists = Klass.objects.filter(slug=slug).exists()
    if qs_exists:
        new_slug = "{slug}-{randstr}".format(
                    slug=slugify(instance.name),
                    randstr=i
                )
        a=i+1
        return unique_slug_generator(instance, new_slug=new_slug, i=a)
    return slug
