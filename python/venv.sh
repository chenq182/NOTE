#!/bin/bash

python3 -m venv -h
sudo apt-get install python3-venv  ## optional
python3 -m venv ~/myvenv

source ~/myvenv/bin/activate
pip3 freeze
deactivate
