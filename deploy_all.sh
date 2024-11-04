kill -9 $(netstat -nlp | grep :10000 | awk '{print $7}' | awk -F"/" '{ print $1 }')
kill -9 $(netstat -nlp | grep :10002 | awk '{print $7}' | awk -F"/" '{ print $1 }')
kill -9 $(netstat -nlp | grep :10005 | awk '{print $7}' | awk -F"/" '{ print $1 }')
kill -9 $(netstat -nlp | grep :10008 | awk '{print $7}' | awk -F"/" '{ print $1 }')
# 启动uvicorn服务器
nohup python main.py --port 10000 --listen 0.0.0.0 --cuda-device 0 --disable-smart-memory  --disable-metadata  > 10000.log &
nohup python main.py --port 10002 --listen 0.0.0.0 --cuda-device 1 --disable-smart-memory   --disable-metadata > 10002.log &
nohup python main.py --port 10005 --listen 0.0.0.0 --cuda-device 2 --disable-smart-memory   --disable-metadata  > 10005.log &
#nohup python main.py --port 10008 --listen 0.0.0.0 --cuda-device 3 --disable-smart-memory   --disable-metadata  > 10008.log &
