#!/bin/sh
mkdir -p /security
if [ ! -f /security/server.key ]; then
	echo "No SSL key found. generating new key and certificate"
	openssl req \
		-new \
		-newkey rsa:2048 \
		-days 365 \
		-nodes\
		-x509 \
		-subj "/CN=localhost" \
		-keyout /security/server.key \
		-out /security/server.crt
fi

echo "Goint to download $FACTORIO_VERSION"

curl -L -k https://www.factorio.com/get-download/$FACTORIO_VERSION/headless/linux64 -o /tmp/factorio_$FACTORIO_VERSION.tar.xz
tar Jxf /tmp/factorio_$FACTORIO_VERSION.tar.xz
rm /tmp/factorio_$FACTORIO_VERSION.tar.xz
    
	
nohup nginx &
cd /opt/factorio-server-manager
./factorio-server-manager -dir '/opt/factorio'
