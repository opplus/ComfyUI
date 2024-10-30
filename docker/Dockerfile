FROM  registry.cn-hangzhou.aliyuncs.com/dlm-business/comfyui:init
LABEL authors="oplus"

RUN mkdir -p /app/comfyui

ENV TERM=linux

WORKDIR /app/comfyui

EXPOSE 8765
ENTRYPOINT ["top","-b"]
