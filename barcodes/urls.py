from django.urls import path

from . import views

urlpatterns = [
    path('jpg/', views.jpg, name='jpg'),
]
