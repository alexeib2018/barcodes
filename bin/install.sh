#!/bin/sh

virtualenv ../.venv --python=python2
../.venv/bin/pip install pdf417gen
mkdir ../barcodes
chmod 777 ../barcodes
