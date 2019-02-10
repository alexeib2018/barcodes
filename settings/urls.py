from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('barcodes/', include('barcodes.urls')),
    path('admin/', admin.site.urls),
]
