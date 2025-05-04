from django.urls import path
from rest_framework.routers import DefaultRouter
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView, TokenBlacklistView

from .views import UserModelViewSet, WarehouseModelViewSet, ProductsModelViewSet, \
    DelModelViewSet

router = DefaultRouter()
router.register('users', UserModelViewSet)
router.register('warehouses', WarehouseModelViewSet)
router.register(r'products', ProductsModelViewSet, basename='products')
router.register(r'del', DelModelViewSet, basename='del')
urlpatterns = [
]

urlpatterns.extend(router.urls)