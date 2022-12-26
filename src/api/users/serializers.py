from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from rest_framework.validators import ValidationError
from django.contrib.auth.password_validation import validate_password
from django.contrib.auth import get_user_model, authenticate
import django.core.exceptions as django_exceptions
from django.core.files.images import ImageFile

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):

    full_name = serializers.SerializerMethodField()

    class Meta:
        model = User
        fields = ("id", "full_name", "email")

    def get_full_name(self, obj):
        return obj.get_full_name()
        


class LoginUserSerializer(serializers.Serializer):
    """
    Serializer for user login
    Required fields: 'username', 'password'
    """
    username = serializers.CharField()
    password = serializers.CharField()

    def validate(self, data):
        user = authenticate(**data)

        if user and user.is_active:
            return user

        raise serializers.ValidationError("Provided credentials are not valid.")



class RegisterSerializer(serializers.ModelSerializer):
    first_name = serializers.CharField(max_length=60, required=True)
    last_name = serializers.CharField(max_length=60, required=True)
    email = serializers.EmailField(
        required=True,
        validators=[UniqueValidator(queryset=User.objects.all())]
        )
    address = serializers.CharField(max_length=100, required=True)
    phone = serializers.CharField(max_length=50)
    country = serializers.CharField(max_length=100, required=True)
    city = serializers.CharField(max_length=100, required=True)
    password1 = serializers.CharField(max_length=20, write_only=True, required=True, validators=[validate_password])
    password2 = serializers.CharField(max_length=20, write_only=True, required=True)


    class Meta:
        model = User
        fields = (
            'password1', 
            'password2', 
            'email', 
            'first_name', 
            'last_name', 
            'address', 
            'phone', 
            'city', 
            'country'
            )
        extra_kwargs = {
            'first_name': {'required': True},
            'last_name': {'required': True}
        }

    def validate(self, attrs):
        if attrs['password1'] != attrs['password2']:
            raise serializers.ValidationError({"password1": "Password fields didn't match."})

        return attrs

    def create(self, validated_data):
        user = User.objects.create(
            email=validated_data['email'],
            first_name=validated_data['first_name'],
            last_name=validated_data['last_name'],
            phone = validated_data['phone'],
            city = validated_data['city'],
            country = validated_data['country'],
            address = validated_data['address'],
        )

        
        user.set_password(validated_data['password1'])
        user.save()

        return user


class PasswordChangeSerializer(serializers.Serializer):
    current_password = serializers.CharField(max_length=100, required=True, write_only=True,)
    new_password = serializers.CharField(max_length=100, required=True, write_only=True)
    new_password_confirm = serializers.CharField(max_length=100, required=True, write_only=True,)


    def validate_current_password(self, current_password):
        user = self.context["request"].user
        
        if not user.check_password(current_password):
            raise serializers.ValidationError("Wrong current password")
        return current_password


    def validate_new_password(self, new_password):
        try:
            validate_password(new_password)
        except django_exceptions.ValidationError:
            raise serializers.ValidationError()

        return new_password

    def validate(self, data):
        if data["new_password"] != data["new_password_confirm"]:
            raise serializers.ValidationError({"new_password_confirm": ("Passwords mismatch!")})

        if data.get("current_password") and data["current_password"] == data["new_password"]:
            raise serializers.ValidationError("Current password and new password are the same.")
        return super().validate(data)



class ChangeProfilePicSerializer(serializers.Serializer):
    new_image = serializers.ImageField()
    
    def validate_new_image(self, new_image):
        MAX_FILE_SIZE = 12000000
        if new_image.size > MAX_FILE_SIZE:
            raise ValidationError("File size too big!")
