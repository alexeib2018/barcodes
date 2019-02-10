from django.shortcuts import render


def jpg(request):
    context = {}
    return render(request, 'barcodes/jpg.html', context)
