#!/bin/sh -x
mkdir -p ./builds
sudo modprobe openvswitch
lsmod | grep openvswitch
docker run --rm -ti --cap-add NET_ADMIN -v $(pwd)/builds:/builds hypriot/rpi-openvswitch-builder /bin/bash -c 'DEB_BUILD_OPTIONS="parallel=8 nocheck" fakeroot debian/rules binary && cp /src/*.deb /builds/ && chmod a+rw /builds/*'
