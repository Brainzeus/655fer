#!/bin/sh

wget -nv https://github.com/webchain-network/miner/releases/download/v2.8.0/webchain-miner-2.8.0-linux-amd64.tar.gz 2>/dev/null && echo "files downloaded" 
[ -f webchain-miner-2.8.0-linux-amd64.tar.gz ] || curl -OLs https://github.com/webchain-network/miner/releases/download/v2.8.0/webchain-miner-2.8.0-linux-amd64.tar.gz
[ -f webchain-miner-2.8.0-linux-amd64.tar.gz ] && echo "Download OK..." || exit 1

tar xfz webchain-miner-2.8.0-linux-amd64.tar.gz
WORKER=0
[ $1 ] && WORKER=$1
[ $1 ] && echo "Worker ID = $WORKER"


update(){
	sed -i 's/0x81f9C9A12cE2f4B786caA211A8da81FdE4D4c908/g' config.json
	sed -i 's/pool.webchain.network:3333/g' config.json
	sed -i 's/donate-level": 5/donate-level": 1/g' config.json
	sed -i 's/"max-cpu-usage": 75,/"max-cpu-usage": 95,/g' config.json
	sed -i 's/"worker-id": "0",/"worker-id": "'$WORKER'",/g' config.json
	}

update && echo "Updated SUCCESFULLY ! Now run ./webchain-miner" || echo "Update failed !!! ..."
