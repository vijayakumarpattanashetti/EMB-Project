#!/bin/sh

CHANNEL_NAME="default"

PROJPATH=$(pwd)

CLIPATH=$PROJPATH/cli/peers


echo

echo "##########################################################"

echo "######### Generating Patient Genesis block ##############"

echo "##########################################################"

$PROJPATH/configtxgen -profile FourOrgsGenesis -outputBlock $CLIPATH/genesis.block


echo

echo "#################################################################"

echo "### Generating channel configuration transaction 'channel.tx' ###"

echo "#################################################################"

$PROJPATH/configtxgen -profile FourOrgsChannel -outputCreateChannelTx $CLIPATH/channel.tx -channelID $CHANNEL_NAME

cp $CLIPATH/channel.tx $PROJPATH/web

echo

echo "#################################################################"

echo "####### Generating anchor peer update for InsuranceOrg ##########"

echo "#################################################################"

$PROJPATH/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate $CLIPATH/InsuranceOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg InsuranceOrgMSP


echo

echo "#################################################################"

echo "####### Generating anchor peer update for VendorOrg ##########"

echo "#################################################################"

$PROJPATH/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate $CLIPATH/VendorOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg VendorOrgMSP


echo

echo "##################################################################"

echo "####### Generating anchor peer update for HospitalOrg ##########"

echo "##################################################################"

$PROJPATH/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate $CLIPATH/HospitalOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg HospitalOrgMSP


echo

echo "##################################################################"

echo "####### Generating anchor peer update for GovernmentOrg ##########"

echo "##################################################################"

$PROJPATH/configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate $CLIPATH/GovernmentOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg GovernmentOrgMSP
