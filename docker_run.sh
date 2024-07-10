#!/bin/bash
source activate comfy
python main.py --port 7865 --listen 0.0.0.0 --cuda-device $CUDA_VISIBLE_DEVICES --disable-smart-memory
