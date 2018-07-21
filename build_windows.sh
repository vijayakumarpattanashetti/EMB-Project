cp ./binary_windows/* .
export FABRIC_CFG_PATH=$PWD
sh ./ibm_fabric.sh
sh ./docker-images.sh
sleep 5
docker-compose up -d