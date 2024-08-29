kill -9 $(netstat -nlp | grep :7861 | awk '{print $7}' | awk -F"/" '{ print $1 }')
kill -9 $(netstat -nlp | grep :7865 | awk '{print $7}' | awk -F"/" '{ print $1 }')
kill -9 $(netstat -nlp | grep :7869 | awk '{print $7}' | awk -F"/" '{ print $1 }')
kill -9 $(netstat -nlp | grep :5544 | awk '{print $7}' | awk -F"/" '{ print $1 }')
# 启动uvicorn服务器
nohup python main.py --port 7865 --listen 0.0.0.0 --cuda-device 0 --disable-smart-memory  --disable-metadata  > 7865.log &
#nohup python main.py --port 5544 --listen 0.0.0.0 --cuda-device 1 --disable-smart-memory  --disable-metadata  > 5544.log &
nohup python main.py --port 7869 --listen 0.0.0.0 --cuda-device 2 --disable-smart-memory   --disable-metadata > 7869.log &
nohup python main.py --port 7861 --listen 0.0.0.0 --cuda-device 3 --disable-smart-memory   --disable-metadata  > 7861.log &
