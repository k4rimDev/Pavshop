from django.contrib import admin
from django.contrib.auth import get_user_model

from users.models import PhonePrefix, UserNotification, Blogger

User = get_user_model()


@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    list_display = (
        "username", 
        "email", 
        "is_staff", 
        "is_active", 
    )

    readonly_fields = (
        "password",
        "date_joined",
        "last_login",
    )

    fieldsets_map = {
        None: {"__all__": {"fields": (
            "username", 
            "password",
            )}},
        "Personal Info": {"__all__": {"fields": (
            "first_name", 
            "last_name", 
            "email",
            "gender",
            "address",
            "country",
            "city",
            "phone_prefix",
            "phone",
            "zip_code",
            "birth_date",
            )}},
        "Permissions": {"__all__": {"fields": (
                "is_staff",
                "is_active",
                "is_superuser",
                "groups",
                "user_permissions",
            )}},
        "Important Dates": {"__all__": {"fields": (
                "date_joined",
                "last_login",
            )}}
    }
    

    def get_fieldsets(self, request, obj=None):
        fieldsets = []
        for title, fields in self.fieldsets_map.items():
            options = fields["__all__"]
            fieldsets.append((title, options))
        return fieldsets


# --------------------------------------------

@admin.register(PhonePrefix)
class PhonePrefixAdmin(admin.ModelAdmin):
    list_display = ["prefix"]

    readonly_fields = [
        "created_at", 
        "updated_at"
        ]
      
      

@admin.register(Blogger)
class BloggerAdmin(admin.ModelAdmin):
    list_display = ("username", )
    
