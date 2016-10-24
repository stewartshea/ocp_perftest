#!/bin/sh

# Start service in background here
phoronix-test-suite start-phoronix-server

 
while [1]
do
	wait 5
done

#echo "[hit enter key to exit] or run 'docker stop <container>'"
#read


# stop service and clean up here
#echo "stopping phoronix-test-suite"
#phoronix-test-suite stop-remote-gui-server

echo "exited $0"
