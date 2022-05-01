SERVER_FOLDER=minecraft_1_16_5
FULL_PATH=~/Desktop/mine/serv/${SERVER_FOLDER}
 
SERVER_PROPERTIES=(
    'enable-command-block=true'
    'gamemode=survival'
    'level-name=survival-server'
    'online-mode=false'
    'use-native-transport=false'
)

URL_1_16_5=https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar
URL_1_18_1=https://launcher.mojang.com/v1/objects/125e5adf40c659fd3bce3e66e67a16bb49ecc1b9/server.jar

SERVER_DOWNLOAD_URL=$URL_1_16_5
NGROK_DOWNLOAD_URL=https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
 
# ------------------------------------------------------------------------------
 
mkdir -p ${FULL_PATH}
if [ ! -f ${FULL_PATH}/server.jar ]; then
    echo " >> downloading server.jar"
    wget -O ${FULL_PATH}/server.jar ${SERVER_DOWNLOAD_URL}
fi
if [ ! -f ${FULL_PATH}/ngrok ]; then
    echo " >> downloading ngrok"
    wget -O ${FULL_PATH}/ngrok.zip -q -c -nc ${NGROK_DOWNLOAD_URL}
    unzip -qq -n ${FULL_PATH}/ngrok.zip -d ${FULL_PATH}
    rm -rf ${FULL_PATH}/ngrok.zip
fi
chmod 777 ${FULL_PATH}/ngrok
 
cat server.properties > ${FULL_PATH}/server.properties 
if [ ! -f ${FULL_PATH}/eula.txt ]; then
    echo " >> setup server files"
    cd ${FULL_PATH} && java -jar server.jar
fi

if [ -f .env ]; then
    source .env
fi
if [ "$NGROK_AUTH_TOKEN" = "" ]; then
    echo "you need to place ngrok auth token to enviroment variable $NGROK_AUTH_TOKEN or to .env file in current directory"
    echo "to get ngrok auth token - register on https://ngrok.com website"
    exit 1
fi

echo " >> clearing ngrok junk"
rm -rf ~/.ngrok2
 
echo " >> configurating server properties"
touch ${FULL_PATH}/args.tmp
for opt in "${SERVER_PROPERTIES[@]}"
do
    python3 -c "(command, value)='${opt}'.split('='); print(f's/{command}.*/{command}={value}/')" >> ${FULL_PATH}/args.tmp
done
sed -i -f ${FULL_PATH}/args.tmp ${FULL_PATH}/server.properties
sed -i "s/false/true/" ${FULL_PATH}/eula.txt
rm ${FULL_PATH}/args.tmp
 
echo " >> saving variables"
touch .env
touch env.json
echo "FULL_PATH=${FULL_PATH}" > .env
echo "NGROK_AUTH_TOKEN=${NGROK_AUTH_TOKEN}" >> .env
echo "{\"FULL_PATH\":\"${FULL_PATH}\",\"NGROK_AUTH_TOKEN\":\"${NGROK_AUTH_TOKEN}\"}" > env.json
echo " >> done"
