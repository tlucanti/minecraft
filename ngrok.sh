source .env
rm -rf ~/.ngrok2
${FULL_PATH}/ngrok authtoken ${NGROK_AUTH_TOKEN}
${FULL_PATH}/ngrok tcp 25565
