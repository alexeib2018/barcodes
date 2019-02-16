from pdf417gen import encode, render_image
from django.shortcuts import render
from django.http import HttpResponse


def index(request):
    context = {}
    return render(request, 'barcodes/index.html', context)


def png(request):
    text = request.POST.get('text', request.GET.get('text', ''))

    codes = encode(text)

    # Generate barcode as image
    image = render_image(codes)  # Pillow Image object
    response = HttpResponse(content_type='image/png')
    image.save(response, 'png')
    return response
