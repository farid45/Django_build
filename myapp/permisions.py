from rest_framework import permissions

class IsSupplierOrReadOnly(permissions.BasePermission):
    def has_permission(self, request, view):
        if request.user and request.user.is_authenticated:
            user_role = request.user.role.role if request.user.role else None
            if user_role == "Supplier":
                return True
            elif request.method in permissions.SAFE_METHODS:
                return True
        return bool(request.user and request.user.is_staff)

class IsCustomerOrReadOnly(permissions.BasePermission):
    def has_permission(self, request, view):
        if request.user and request.user.is_authenticated:
            user_role = request.user.role.role if request.user.role else None
            if user_role == "Customer":
                return True
            elif request.method in permissions.SAFE_METHODS:
                return True
        return bool(request.user and request.user.is_staff)

