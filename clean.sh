#!/bin/bash

docker rm -f $(docker ps -aq)

images=( web insurance-peer patient government-peer hospital-ca vendor-ca government-ca insurance-ca hospital-peer vendor-peer )

for i in "${images[@]}"

do

	echo Removing image : $i

  docker rmi -f $i

done


#docker rmi -f $(docker images | grep none)

images=( dev-hospital-peer dev-government-peer dev-insurance-peer dev-vendor-peer)

for i in "${images[@]}"

do

	echo Removing image : $i

  docker rmi -f $(docker images | grep $i )

done

