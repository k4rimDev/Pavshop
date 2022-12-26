from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from rest_framework.validators import ValidationError
from core.models import Sponsor, Staff


class AboutSponsorSerializer(serializers.ModelSerializer):
    """
    Sponsor Serializer
    """

    class Meta:
        model = Sponsor
        fields = ['image', ]

class AboutStaffSerializer(serializers.ModelSerializer):
    """
    Staff Serializer
    """

    class Meta:
        model = Staff
        fields = "__all__"
