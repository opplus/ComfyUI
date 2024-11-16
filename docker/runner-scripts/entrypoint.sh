#!/bin/bash

set -e
echo "########################################"
echo "[INFO] 启动 ComfyUI..."
echo "########################################"

# 使得 .pyc 缓存文件集中保存
export PYTHONPYCACHEPREFIX="/root/.cache/pycache"
# 使得 PIP 安装新包到 /root/.local
export PIP_USER=true
# 添加上述路径到 PATH
export PATH="${PATH}:/root/.local/bin"
# 不再显示警报 [WARNING: Running pip as the 'root' user]
export PIP_ROOT_USER_ACTION=ignore
# 启用 HuggingFace Hub 高速传输
# https://huggingface.co/docs/huggingface_hub/hf_transfer
export HF_HUB_ENABLE_HF_TRANSFER=1
cd /root/comfyui/workspace
rm -rf input output
rm -rf my_workflows && ln -s /root/comfyui/my_workflows my_workflows
rm -rf custom_nodes && ln -s /root/comfyui/custom_nodes custom_nodes
rm -rf models && ln -s /root/comfyui/models models

python3 main.py --listen --port 8188 ${CLI_ARGS}
