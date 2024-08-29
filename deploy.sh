echo "port：$1"
echo "device：$2"
port=$1
device_id=$2
kill -9 $(netstat -nlp | grep :$port | awk '{print $7}' | awk -F"/" '{ print $1 }')

# 启动uvicorn服务器
nohup python main.py --port $port --listen 0.0.0.0 --cuda-device $device_id --disable-smart-memory --disable-metadata  > $port.log &
