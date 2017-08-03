#!/bin/bash

if [[ -z "${REDIS_SECRET// }" ]]; then
  echo "REDIS_SECRET env variable must be set with Redis master password";
  exit 1
fi

rm -f ./redis-secret.yaml;
cp ./secret-template.yaml ./redis-secret.yaml

ENCODED_SECRET=`echo -n ${REDIS_SECRET} | base64`
sed -i "s/%redis-secret%/${ENCODED_SECRET}/" ./redis-secret.yaml

# Create conf
kubectl create configmap sd-redis-master-conf --from-file ./conf/redis-master.conf

# Create secret
kubectl apply -f ./redis-secret.yaml

# Create master
kubectl apply -f ./redis-master.yaml

rm -f ./redis-secret.yaml;
