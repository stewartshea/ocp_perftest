#!/bin/sh
# Note: I've written this using sh so it works in the busybox container too


# start service in background here
phoronix-test-suite start-remote-gui-server

echo "[hit enter key to exit] or run 'docker stop <container>'"
read

# stop service and clean up here
echo "stopping phoronix-test-suite"
phoronix-test-suite stop-remote-gui-server

echo "exited $0"
