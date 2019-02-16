from django.contrib import admin
from django.urls import include, path

from barcodes.views import index

urlpatterns = [
    path('barcodes/', include('barcodes.urls')),
    path('admin/', admin.site.urls),
    path('', index, name='index'),
]
