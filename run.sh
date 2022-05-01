source .env

cd ${FULL_PATH} && java -server  -XX:ParallelGCThreads=8 -Xms4G -Xmx40G -jar server.jar

