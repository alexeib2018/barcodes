#!/bin/sh

rm -r -f ../venv3
rm -r -f ../barcodes

mkdir ../barcodes
chmod 777 ../barcodes

virtualenv ../venv3 --python=python3
cd ../venv3/bin
pwd
source activate
pip install pdf417gen
pip install pillow
