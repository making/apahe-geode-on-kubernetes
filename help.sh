#!/bin/bash

type=$(kubectl get svc locator-public -o jsonpath='{.spec.type}')
if [[ $type == "NodePort" ]] ; then
  address=$(minikube ip 2>/dev/null)
  if [[ "$address" == "" ]] ; then
    address=127.0.0.1
  fi
  port=$(kubectl get svc locator-public -o jsonpath='{.spec.ports[?(@.name == "http")].nodePort}')
else
  address=$(kubectl get svc locator-public -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
  if [[ $address == "" ]] ; then
    echo "External IP is not yet available, try in a few ..."
    exit 1
  fi
  port=$(kubectl get svc locator-public -o jsonpath='{.spec.ports[?(@.name == "http")].port}')
fi

cat <<EOF
gfsh
connect --use-http=true --url=http://$address:$port/geode-mgmt/v1
start pulse --url=http://$address:$port/pulse
EOF
