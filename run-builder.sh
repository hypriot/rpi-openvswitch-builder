#!/bin/sh -x
mkdir -p ./builds
docker run --rm -ti -v $(pwd)/builds:/builds hypriot/rpi-openvswitch-builder /bin/bash -c 'cp /src/*.deb /builds/; chmod a+rw /builds/*'
