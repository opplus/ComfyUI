#!/bin/bash

# 定义端口号
port=$1

# 检查端口号是否已提供
if [ -z "$port" ]; then
    echo "Usage: $0 <port>"
    exit 1
fi

# 使用 ps 命令找到所有包含特定命令行参数的进程
# 这里我们假设命令行参数包括 "--port 7861"
# 可以根据实际情况调整 grep 的模式
command_line="main.py --port $port --listen 0.0.0.0 --cuda-device"

# 获取所有包含特定命令行参数的进程PID
pids=$(ps aux | grep "[p]ython.*$command_line" | awk '{print $2}')

echo "find PID: $pids"

# 去掉最后一个空格
pids=${pids% }

# 遍历所有PID并杀死
for pid in $pids; do
    if [ -n "$pid" ]; then
        echo "Killing process with PID: $pid"
        kill -9 $pid
    fi
done

