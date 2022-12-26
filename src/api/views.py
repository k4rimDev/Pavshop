from product.models import Product
from rest_framework.views import APIView
from rest_framework import generics, permissions
from rest_framework.response import Response
from django.contrib.auth import get_user_model
from order.models import Order

from core.models import Sponsor, Staff
from .serializers import AboutSponsorSerializer


User = get_user_model()

class StatisticsAPIView(APIView):
    """
    Endpoint for this api - "api/about/statistics"

    Statistics of products, sales and clients
    
    """
    pagination_class = None
    
    def get(self, *args, **kwargs):
        products = Product.objects.all().count()
        clients = User.objects.filter(is_active=True).count()
        sales = Order.objects.all().count()
        
        data = {"products":products, "clients":clients, "sales":sales}

        return Response(data)

class AboutSponsorsListApiView(generics.ListAPIView):
    """
    Endpoint for this api - "api/about/sponsors"
    List of about sponsors
    """
    permission_classes = (permissions.AllowAny,)
    queryset = Sponsor.objects.all()
    serializer_class = AboutSponsorSerializer


class AboutStaffListApiView(generics.ListAPIView):
    """
    Endpoint for this api - "api/about/staff"
    List of about staff
    """
    permission_classes = (permissions.AllowAny,)
    queryset = Staff.objects.all()
    serializer_class = AboutSponsorSerializer
