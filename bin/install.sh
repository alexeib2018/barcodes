#!/bin/sh

rm -r -f ../.venv
rm -r -f ../barcodes
virtualenv ../.venv --python=python3
../.venv/bin/pip install pdf417gen
mkdir ../barcodes
chmod 777 ../barcodes
