from rest_framework import generics, permissions, status
from django.contrib.auth import get_user_model
from rest_framework.response import Response

from datetime import datetime
from product.models import Product

from api.cart.serializers import CartItemSerializer, CartSerializer, DiscountSerializer, CartUpdateDiscountSerializer, WishlistSerializer
from cart.models import Cart, CartItem, Discount, Whislist


User = get_user_model()

class CartListAPIView(generics.ListAPIView):
    queryset = Cart.objects.all()
    serializer_class = CartSerializer

class UserCartItemAPIView(generics.RetrieveAPIView):
    permission_classes = (permissions.AllowAny,)

    def get(self, *args, **kwargs):
        user_id = self.kwargs.get("id")
        try:
            cart = Cart.objects.get(user=user_id, complete=False) # type: ignore
            serializer = CartSerializer(cart)

            return Response(serializer.data, status=status.HTTP_200_OK)
        except Cart.DoesNotExist:
            return Response({"detail": "Cart not found"}, status=status.HTTP_404_NOT_FOUND)
    
class CartCreateAPIView(generics.CreateAPIView):
    queryset = Cart.objects.all()
    serializer_class = CartSerializer

class CartItemListAPIView(generics.ListAPIView):
    queryset = CartItem.objects.all()
    serializer_class = CartItemSerializer

class CartItemCreateAPIView(generics.CreateAPIView):
    queryset = CartItem.objects.all()
    serializer_class = CartItemSerializer


class DiscountListAPIView(generics.ListAPIView):
    permisson_classes = (permissions.IsAuthenticated,)
    
    def get(self, *args, **kwargs):
        queryset = Discount.objects.all()

        discount_code = self.request.query_params.get("discount_code")  

        if discount_code:
            try:
                queryset = queryset.filter(discount_code = discount_code, expiry_date__lt = datetime.now()).order_by("-created_date")[0]
            except:
                queryset =  queryset.filter(discount_code = discount_code, expiry_date__lt = datetime.now())


        serializer = DiscountSerializer(queryset, many=False)

        return Response(serializer.data, status=status.HTTP_200_OK)

class CartUpdateAPIView(generics.UpdateAPIView):
    permisson_classes = (permissions.IsAuthenticated,)
    serializer_class = CartUpdateDiscountSerializer

    def patch(self, request):
        user = self.request.user
        cart = Cart.objects.get(user=user, complete=False)
        if cart.discount_percent == 0:
            serializer = self.get_serializer(data=request.data)
            if serializer.is_valid():
                cart.discount_percent = serializer.validated_data["discount_percent"]
                cart.save()
                return Response(
                    {"message": "Discount percent updated successfully"},
                    status=status.HTTP_200_OK,
                )
        else:
            return Response(
                    {"message": "Discount has been already added to your cart"},
                    status=status.HTTP_200_OK,
                )
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class WishlistListCreateAPIView(generics.ListCreateAPIView):
    """
    Endpoint for this api - "api/cart/wishlist"  - GET method
                          - "api/cart/wishlist/<int:id>" - POST method
    """    

    def get(self, request, *args, **kwargs):
        user = self.request.user
        queryset = user.whislist.all()
        serializer = WishlistSerializer(queryset, many=True)

        return Response(serializer.data)

    def post(self, *args, **kwargs):
        id = self.kwargs.get("id")
        product = Product.objects.get(id=id)
        obj, created = Whislist.objects.get_or_create(user=self.request.user, product=product)
        if not created:
            obj.delete()
            return Response({"message":"Unliked"})
        return Response({"message":"Liked"})
