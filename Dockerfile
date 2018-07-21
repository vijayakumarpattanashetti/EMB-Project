FROM docker.io/hyperledger/fabric-patient:x86_64-1.1.0 
RUN mkdir /patient
COPY crypto /patient/crypto