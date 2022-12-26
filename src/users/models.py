import datetime
from django.db import models
from django.contrib.auth.models import AbstractUser
from django.conf import settings
from django.utils import timezone

# User table
class User(AbstractUser):
    COUNTRY_CHOICES = (
    ('azerbaijan','AZERBAIJAN'),
    ('turkey', 'TURKEY'),
    ('russia','RUSSIA'),
    ('america','AMERICA'),
    )
    GENDER_CHOICES = (
        ("w", "woman"),
        ("m", "man"),
    )   

    username = models.CharField(
        ("username"),
        null=True, blank=True,
        max_length=150,
        unique=True,
        help_text=(
            "Required. 150 characters or fewer. Letters, digits and @/./+/-/_ only."
        ),
        error_messages={
            "unique": ("A user with that username already exists."),
        },
    )
    profile_image = models.ImageField(upload_to="user", default="users/default-pp/avatar-1.jpg", null=True, blank=True)
    first_name = models.CharField(
        ("first name"), 
        max_length=255, 
        blank=True
    )
    last_name = models.CharField(
        ("last name"), 
        max_length=255, 
        blank=True
    )
    address = models.TextField(
        null=True,
        blank=True
    )
    country = models.CharField(
        max_length=10, 
        choices=COUNTRY_CHOICES, 
        default='green', 
        blank=True
    )
    city = models.CharField(
        max_length=128,
        null=True,
        blank=True
    )
    email = models.EmailField(
        ("email address"), 
        max_length=255, 
        unique=True,
    )
    gender = models.CharField(
        max_length=50,
        choices=GENDER_CHOICES,  
        null=True, 
        blank=True
    )
    phone = models.CharField(
        max_length=50,
        null=True,
        blank=True
    ) 
    phone_prefix = models.ForeignKey(
        "users.PhonePrefix",
        related_name="users",
        blank=True,
        null=True,
        on_delete=models.DO_NOTHING,
    )
    zip_code = models.IntegerField(
        null=True, 
        blank=True
    )
    is_staff = models.BooleanField(
        ("staff status"),
        default=False,
        help_text=("Designates whether the user can log into this admin " "site."),
    )
    birth_date = models.DateField(
        blank=True, 
        null=True,
    )
    date_joined = models.DateTimeField(
        ("date joined"), 
        default=timezone.now,
    )
    last_login = models.DateTimeField(
        null=True, 
        blank=True, 
        default=datetime.datetime.now(),
    )

    # def save(self, *args, **kwargs) -> None:
    #     self.username = self.first_name + self.last_name + 'kerim'
    #     super(User, self).save(*args, **kwargs)

    @property
    def full_name(self) -> str:
        return '%s %s' % (self.first_name, self.last_name)

    def __str__(self) -> str:
        return self.full_name

    class Meta:
        verbose_name = "user"
        indexes = [
            models.Index(fields=['first_name', 'last_name']),
            models.Index(fields=['first_name'], name='first_name_idx'),
        ]


# --------------------------------------------

class Blogger(User):
    class Meta:
        proxy = True
    
    def __str__(self):
        return f"{self.full_name}"


# --------------------------------------------
class MyUser(User):
    class Meta:
        proxy = True
    
    def __str__(self):
        return f"{self.full_name}"
        
# --------------------------------------------
# class Designer(User):
# --------------------------------------------

class PhonePrefix(models.Model):
    prefix = models.CharField(max_length=10, unique=True)
    
    # moderation
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.prefix}"



# --------------------------------------------       

class UserNotification(models.Model):
    """
    This model is used for as ref_obj for myuser model object.
    """
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        related_name="user_notification",
        on_delete=models.CASCADE,
    )
    mail_sent = models.BooleanField(default=False)

    # moderation
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.user}"
