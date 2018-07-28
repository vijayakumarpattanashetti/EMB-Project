#!/bin/sh

set -e


echo

echo "#################################################################"

echo "####### Generating cryptographic material ##########"

echo "#################################################################"

PROJPATH=$(pwd)

CLIPATH=$PROJPATH/cli/peers

PATIENTS=$CLIPATH/patientOrganizations

PEERS=$CLIPATH/peerOrganizations


rm -rf $CLIPATH

$PROJPATH/cryptogen generate --config=$PROJPATH/crypto-config.yaml --output=$CLIPATH


sh generate-cfgtx.sh


rm -rf $PROJPATH/{patient,insurancePeer,governmentPeer,hospitalPeer,vendorPeer}/crypto

mkdir $PROJPATH/{patient,insurancePeer,governmentPeer,hospitalPeer,vendorPeer}/crypto

cp -r $PATIENTS/patient-org/patients/patient0/{msp,tls} $PROJPATH/patient/crypto

cp -r $PEERS/insurance-org/peers/insurance-peer/{msp,tls} $PROJPATH/insurancePeer/crypto

cp -r $PEERS/government-org/peers/government-peer/{msp,tls} $PROJPATH/governmentPeer/crypto

cp -r $PEERS/hospital-org/peers/hospital-peer/{msp,tls} $PROJPATH/hospitalPeer/crypto

cp -r $PEERS/vendor-org/peers/vendor-peer/{msp,tls} $PROJPATH/vendorPeer/crypto

cp $CLIPATH/genesis.block $PROJPATH/patient/crypto/


INSURANCECAPATH=$PROJPATH/insuranceCA

GOVERNMENTCAPATH=$PROJPATH/policeCA

HOSPITALCAPATH=$PROJPATH/repairShopCA

VENDORCAPATH=$PROJPATH/shopCA


rm -rf {$INSURANCECAPATH,$GOVERNMENTCAPATH,$HOSPITALCAPATH,$VENDORCAPATH}/{ca,tls}

mkdir -p {$INSURANCECAPATH,$GOVERNMENTCAPATH,$HOSPITALCAPATH,$VENDORCAPATH}/{ca,tls}

cp $PEERS/insurance-org/ca/* $INSURANCECAPATH/ca

cp $PEERS/insurance-org/tlsca/* $INSURANCECAPATH/tls

mv $INSURANCECAPATH/ca/*_sk $INSURANCECAPATH/ca/key.pem

mv $INSURANCECAPATH/ca/*-cert.pem $INSURANCECAPATH/ca/cert.pem

mv $INSURANCECAPATH/tls/*_sk $INSURANCECAPATH/tls/key.pem

mv $INSURANCECAPATH/tls/*-cert.pem $INSURANCECAPATH/tls/cert.pem


cp $PEERS/government-org/ca/* $GOVERNMENTCAPATH/ca

cp $PEERS/government-org/tlsca/* $GOVERNMENTCAPATH/tls

mv $GOVERNMENTCAPATH/ca/*_sk $GOVERNMENTCAPATH/ca/key.pem

mv $GOVERNMENTCAPATH/ca/*-cert.pem $GOVERNMENTCAPATH/ca/cert.pem

mv $GOVERNMENTCAPATH/tls/*_sk $GOVERNMENTCAPATH/tls/key.pem

mv $GOVERNMENTCAPATH/tls/*-cert.pem $GOVERNMENTCAPATH/tls/cert.pem


cp $PEERS/hospital-org/ca/* $HOSPITALCAPATH/ca

cp $PEERS/hospital-org/tlsca/* $HOSPITALCAPATH/tls

mv $HOSPITALCAPATH/ca/*_sk $HOSPITALCAPATH/ca/key.pem

mv $HOSPITALCAPATH/ca/*-cert.pem $HOSPITALCAPATH/ca/cert.pem

mv $HOSPITALCAPATH/tls/*_sk $HOSPITALCAPATH/tls/key.pem

mv $HOSPITALCAPATH/tls/*-cert.pem $HOSPITALCAPATH/tls/cert.pem


cp $PEERS/vendor-org/ca/* $VENDORCAPATH/ca

cp $PEERS/vendor-org/tlsca/* $VENDORCAPATH/tls

mv $VENDORCAPATH/ca/*_sk $VENDORCAPATH/ca/key.pem

mv $VENDORCAPATH/ca/*-cert.pem $VENDORCAPATH/ca/cert.pem

mv $VENDORCAPATH/tls/*_sk $VENDORCAPATH/tls/key.pem

mv $VENDORCAPATH/tls/*-cert.pem $VENDORCAPATH/tls/cert.pem


WEBCERTS=$PROJPATH/web/certs

rm -rf $WEBCERTS

mkdir -p $WEBCERTS

cp $PROJPATH/patient/crypto/tls/ca.crt $WEBCERTS/patientOrg.pem

cp $PROJPATH/insurancePeer/crypto/tls/ca.crt $WEBCERTS/insuranceOrg.pem

cp $PROJPATH/governmentPeer/crypto/tls/ca.crt $WEBCERTS/governmentOrg.pem

cp $PROJPATH/hospitalPeer/crypto/tls/ca.crt $WEBCERTS/hospitalOrg.pem

cp $PROJPATH/vendorPeer/crypto/tls/ca.crt $WEBCERTS/vendorOrg.pem

cp $PEERS/insurance-org/users/Admin@insurance-org/msp/keystore/* $WEBCERTS/Admin@insurance-org-key.pem

cp $PEERS/insurance-org/users/Admin@insurance-org/msp/signcerts/* $WEBCERTS/

cp $PEERS/vendor-org/users/Admin@vendor-org/msp/keystore/* $WEBCERTS/Admin@vendor-org-key.pem

cp $PEERS/vendor-org/users/Admin@vendor-org/msp/signcerts/* $WEBCERTS/

cp $PEERS/government-org/users/Admin@government-org/msp/keystore/* $WEBCERTS/Admin@government-org-key.pem

cp $PEERS/government-org/users/Admin@government-org/msp/signcerts/* $WEBCERTS/

cp $PEERS/hospital-org/users/Admin@hospital-org/msp/keystore/* $WEBCERTS/Admin@hospital-org-key.pem

cp $PEERS/hospital-org/users/Admin@hospital-org/msp/signcerts/* $WEBCERTS/
