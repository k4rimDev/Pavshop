from rest_framework import generics, permissions, status, authentication
from rest_framework_simplejwt.views import TokenObtainPairView
from django.http import JsonResponse
from rest_framework.views import APIView

from api.users.serializers import (
    RegisterSerializer, 
    LoginUserSerializer,
    UserSerializer,
    PasswordChangeSerializer,
    ChangeProfilePicSerializer,
    )
from django.contrib.auth import get_user_model
from rest_framework.response import Response
from django.shortcuts import get_object_or_404
from knox.models import AuthToken

User = get_user_model()



class LoginUserApiView(generics.CreateAPIView):

    """ 
    Endpoint for this api - "api/user/login/"  

    """

    permission_classes = (permissions.AllowAny,)
    serializer_class = LoginUserSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)

        if not serializer.is_valid():
            return JsonResponse(serializer.errors, status=400)

        user = serializer.validated_data
        response = JsonResponse(
            {
                "user": UserSerializer(
                    user, context=self.get_serializer_context()
                ).data,
                "token": AuthToken.objects.create(user)[1],
            }
        )

        return response



class UserCreateView(generics.CreateAPIView):
    """ 
    Endpoint for this api - "api/user/register"  

    """

    serializer_class = RegisterSerializer
    queryset = User.objects.all()



class UpdateProfilePicAPIView(generics.UpdateAPIView):
    """
    Endpoint for this api - “api/user/change-profilepic 
    """
    permisson_classes = (permissions.IsAuthenticated,)
    serializer_class = ChangeProfilePicSerializer

    def patch(self, request):
        user = self.request.user
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            print(serializer.validated_data["new_image"])
            user.profile_image = serializer.validated_data["new_image"]
            print(user.profile_image)
            user.save()
            return Response(
                {"message": "Picture updated successfully"},
                status=status.HTTP_200_OK,
            )
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)




class PasswordUpdateView(generics.UpdateAPIView):
    """
    Endpoint for this api - "api/user/change-password"
    """
    
    serializer_class = PasswordChangeSerializer
    permission_classes = (permissions.IsAuthenticated, )
    
    def update(self, request, *args, **kwargs):
        user = self.request.user
        serializer = self.get_serializer(data=request.data)

        if serializer.is_valid():
            user.set_password(serializer.validated_data["new_password"])
            user.save()
            return Response(
                {"message": "Password updated successfully"},
                status=status.HTTP_200_OK,
            )

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
