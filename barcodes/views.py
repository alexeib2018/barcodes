from django.shortcuts import render


def index(request):
    context = {}
    return render(request, 'barcodes/index.html', context)


def jpg(request):
    context = {}
    return render(request, 'barcodes/jpg.html', context)
