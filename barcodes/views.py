from pdf417gen import encode, render_image
from django.shortcuts import render
from django.http import HttpResponse


def index(request):
    return render(request, 'barcodes/index.html', {})


def generate(request):
    job_reset = request.GET.get('job_reset', '')
    job_id = request.GET.get('job_id', '')
    part_id = request.GET.get('part_id', '')
    ideal_cycle_time = request.GET.get('ideal_cycle_time', '')
    takt_time = request.GET.get('takt_time', '')
    target_set_time = request.GET.get('target_set_time', '')
    scale_factor1 = request.GET.get('scale_factor1', '')
    scale_factor2 = request.GET.get('scale_factor2', '')
    executes_program = request.GET.get('executes_program', '')
    count_of_barcodes = request.GET.get('count_of_barcodes', '')

    # 25;2|                 - job reset = 2
    # 40;1;252;1;99571|     - job id = 99571
    # 40;1;253;1;92-0912|   - part_id = 92-0912
    # 33;10|                - ideal cycle time = 10 sec
    # 37;10;1|              - takt time = 10 sec
    # 17;1;18;600000|       - target set time = 10 min (600000ms)
    # 36;1;1|               - scale factor1 1:1
    # 36;2;1.0|             - scale factor2 2:1.0
    # 7;900                 - executes program: 900

    cmd = list()
    cmd.append('25;%s' % job_reset)
    cmd.append('40;1;252;1;%s' % job_id)
    cmd.append('40;1;253;1;%s' % part_id)
    cmd.append('33;%s' % ideal_cycle_time)
    cmd.append('37;%s;1' % takt_time)
    cmd.append('17;1;18;%s' % (int(target_set_time) * 60 * 1000))
    cmd.append('36;%s' % scale_factor1.replace(':',';'))
    cmd.append('36;%s' % scale_factor2.replace(':',';'))
    cmd.append('7;%s' % executes_program)

    barcode = '|'.join(cmd)
    barcode = barcode.replace(':', '%2A')
    barcode = barcode.replace(';', '%2B')
    barcode = barcode.replace('|', '%7C')

    context = {
        'barcode': barcode,
        'count': list(range(0,int(count_of_barcodes)))
    }

    return render(request, 'barcodes/generate.html', context)


def png(request):
    text = request.POST.get('text', request.GET.get('text', ''))

    codes = encode(text)

    # Generate barcode as image
    image = render_image(codes)  # Pillow Image object
    response = HttpResponse(content_type='image/png')
    image.save(response, 'png')
    return response
