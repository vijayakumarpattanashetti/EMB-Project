set -eu


dockerFabricPull() {

  local FABRIC_TAG=$1

  for IMAGES in peer patient ccenv; do

      echo "==> FABRIC IMAGE: $IMAGES"

      echo

      docker pull hyperledger/fabric-$IMAGES:$FABRIC_TAG

      docker tag hyperledger/fabric-$IMAGES:$FABRIC_TAG hyperledger/fabric-$IMAGES

  done

}


dockerCaPull() {

      local CA_TAG=$1

      echo "==> FABRIC CA IMAGE"

      echo

      docker pull hyperledger/fabric-ca:$CA_TAG

      docker tag hyperledger/fabric-ca:$CA_TAG hyperledger/fabric-ca

}


BUILD=

DOWNLOAD=

if [ $# -eq 0 ]; then

    BUILD=true

    PUSH=true

    DOWNLOAD=true

else

    for arg in "$@"

        do

            if [ $arg == "build" ]; then

                BUILD=true

            fi

            if [ $arg == "download" ]; then

                DOWNLOAD=true

            fi

    done

fi


if [ $DOWNLOAD ]; then

    : ${CA_TAG:="x86_64-1.1.0"}

    : ${FABRIC_TAG:="x86_64-1.1.0"}


    echo "===> Pulling fabric Images"

    dockerFabricPull ${FABRIC_TAG}


    echo "===> Pulling fabric ca Image"

    dockerCaPull ${CA_TAG}

    echo

    echo "===> List out hyperledger docker images"

    docker images | grep hyperledger*

fi


if [ $BUILD ];

    then

    echo '############################################################'

    echo '# BUILDING CONTAINER IMAGES #'

    echo '############################################################'

    docker build -t patient:latest patient/

    docker build -t insurance-peer:latest insurancePeer/

    docker build -t government-peer:latest governmentPeer/

    docker build -t vendor-peer:latest vendorPeer/

    docker build -t hospital-peer:latest hospitalPeer/

    docker build -t web:latest web/

    docker build -t insurance-ca:latest insuranceCA/

    docker build -t government-ca:latest governmentCA/

    docker build -t vendor-ca:latest vendorCA/

    docker build -t hospital-ca:latest hospitalCA/

fi