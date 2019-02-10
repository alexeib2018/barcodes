from pdf417gen import encode, render_image

# Some data to encode
text = """Beautiful is better than ugly.
Explicit is better than implicit.
Simple is better than complex.
Complex is better than complicated."""

# Convert to code words
codes = encode(text)

# Generate barcode as image
image = render_image(codes)  # Pillow Image object
image.save('barcode.jpg')
