#!/bin/bash

# 输出传入的参数
echo "port: $1"
echo "device: $2"
echo "auto-restart: $3"

# 设置变量
port=$1
device_id=$2
auto_restart=$3

# 工作目录
wk_dir='/home/star/ssd/ssd_1/comfy/ComfyUI'

# 检查端口是否被占用
pid=$(netstat -nlp | grep ":$port " | awk '{print $7}' | awk -F'/' '{print $1}')
if [ -n "$pid" ]; then
    # 尝试优雅地关闭进程
    echo "Killing process with PID $pid on port $port..."
    kill "$pid" && sleep 2
    # 如果进程仍然存在，则强制终止
    if ps -p "$pid" > /dev/null ; then
        echo "Process $pid did not terminate gracefully, forcing kill..."
        kill -9 "$pid"
    fi
else
    echo "No process found using port $port."
fi

# 启动新的uvicorn服务器
start_server() {
    echo "Starting uvicorn server on port $port with device ID $device_id..."
    nohup python "$wk_dir/main.py" --port "$port" --listen 0.0.0.0 --cuda-device "$device_id" --disable-smart-memory --disable-metadata > "$port.log" 2>&1 &
    echo "Server started. Logs can be found at $port.log"
}

start_server

# 自动重启功能
if [ "$auto_restart" = "true" ]; then
    echo "Auto-restart is enabled."
      # 检查是否已经有重启服务
    apid=$(pgrep -f "bash -c while true; do.* $port")
    if [ -n "$apid" ]; then
        # 尝试优雅地关闭进程
        echo "Killing Auto-restart  process with PID $apid ..."
        kill "$apid" && sleep 2
        # 如果进程仍然存在，则强制终止
        if ps -p "$apid" > /dev/null ; then
            echo "Auto-restart Process $apid did not terminate gracefully, forcing kill..."
            kill -9 "$apid"
        fi
    fi

    # 使用 nohup 直接运行整个循环
    nohup bash -c 'while true; do
        sleep 60  # 每10秒检查一次
        pid=$(ps aux | grep "python.*main.py.*--port '$port'" |grep -v "while true;" |grep "listen" | awk "{print $2}")
        if [ -z "$pid" ]; then
            echo "Process on port '$port' has exited. Restarting..."
            nohup python "'$wk_dir'/main.py" --port '$port' --listen 0.0.0.0 --cuda-device '$device_id' --disable-smart-memory --disable-metadata > "'$port'.log" 2>&1 &
        else
            echo "Process Alive on port '$port' in $pid"
        fi
    done' > auto_restart_$port.log 2>&1 &
    echo "Auto-restart script is running in the background. Logs can be found at auto_restart.log"
else
    echo "Auto-restart is disabled."
fi