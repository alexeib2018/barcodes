from django.urls import path

from . import views

urlpatterns = [
    path('index/', views.index, name='index'),
    path('generate/', views.generate, name='generate'),
    path('png/', views.png, name='png'),
]
