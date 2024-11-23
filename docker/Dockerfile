################################################################################
# 下载地址改用国内源（不再适合 GitHub CI）。
# 注意，构建时仍需访问 download.pytorch.org
#
# 使用 CUDA 12.4, Python 3.12, GCC 13
# 容器内将以 root 用户运行，以便于 rootless 部署
################################################################################
# 提交容器为镜像
# docker commit 3da6c3dfcce5 registry.cn-hangzhou.aliyuncs.com/dlm-business/comfyui:2024111501
# docker build --no-cache -t registry.cn-hangzhou.aliyuncs.com/dlm-business/comfyui:20241115_nodepn .
# 该基础镜像声明不含仓库前缀，因而会先尝试使用本地镜像
FROM registry.cn-hangzhou.aliyuncs.com/dlm-business/comfyui:torch251_cuda121

LABEL maintainer="oplus@deeplink.com"

RUN set -eu

# 配置使用国内源，安装 Python 包
ENV PIP_INDEX_URL="https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple"

################################################################################
# HuggingFace 使用国内源

ENV HF_ENDPOINT=https://hf-mirror.com
################################################################################
RUN mkdir -p /root/.cache/torch/hub/checkpoints
RUN mkdir -p /root/.cache/huggingface/hub/models--QuanSun--EVA-CLIP

COPY runner-scripts/.  /runner-scripts/
COPY models/alexnet-owt-7be5be79.pth  /root/.cache/torch/hub/checkpoints/alexnet-owt-7be5be79.pth
COPY models/models--QuanSun--EVA-CLIP   /root/.cache/huggingface/hub/models--QuanSun--EVA-CLIP

RUN mkdir -p /root/comfyui/models
RUN mkdir -p /root/comfyui/custom_nodes
RUN mkdir -p /root/comfyui/workspace
RUN mkdir -p /root/comfyui/my_workflows

USER root
VOLUME /root/comfyui
WORKDIR /root/comfyui
EXPOSE 8188
ENV CLI_ARGS="--disable-smart-memory --disable-metadata "
CMD ["bash","/runner-scripts/entrypoint.sh"]
