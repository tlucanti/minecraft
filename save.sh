
source .env

git add .
git commit -m "${LEVEL_NAME} :: $(date '+%Y.%m.%d-%H:%M')"
git push origin master
