cp ./binary_windows/* .

export FABRIC_CFG_PATH=$PWD

sh ./generate-certs.sh

sh ./docker-images.sh

docker-compose up -d

