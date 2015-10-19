# rpi-openvswitch-builder

Builder for Open vSwitch packages compatible to the Raspberry Pi.

It consequently follows the official build instructions on https://github.com/openvswitch/ovs/blob/master/INSTALL.Debian.md

## Step 1: build the builder Docker Image
`./build.sh`
```bash
#!/bin/sh -x
docker build -t hypriot/rpi-openvswitch-builder .
```

## Step 2: run the builder, compile Open vSwitch, create .deb packages, copies the created .deb packages to the host machine
Here we're loading all kernel modules for Open vSwitch before running the builder in a Docker Container. With `--cap-add NET_ADMIN` the container can access the `openvswitch` kernel modules.

For compiling and running all tests use
```
'DEB_BUILD_OPTIONS="parallel=8" fakeroot debian/rules binary
```
Compiling w/o tests just use
```
'DEB_BUILD_OPTIONS="parallel=8 nocheck" fakeroot debian/rules binary
```

`./run-builder.sh`
```bash
#!/bin/sh -x
mkdir -p ./builds
sudo modprobe openvswitch
lsmod | grep openvswitch
docker run --rm -ti --cap-add NET_ADMIN -v $(pwd)/builds:/builds hypriot/rpi-openvswitch-builder /bin/bash -c 'DEB_BUILD_OPTIONS="parallel=8" fakeroot debian/rules binary && cp /src/*.deb /builds/ && chmod a+rw /builds/*'
```

## Results
Can be found in directory `./builds`
```bash
ls -al ./builds/
```
```
total 39584
drwxr-xr-x  13 dieter  staff      442 Mar 10 11:57 .
drwxr-xr-x   4 dieter  staff      136 Mar 10 11:56 ..
-rw-r--r--   1 dieter  staff   787546 Mar 10 11:57 openvswitch-common_2.3.90-1_armhf.deb
-rw-r--r--   1 dieter  staff  3857686 Mar 10 11:57 openvswitch-datapath-dkms_2.3.90-1_all.deb
-rw-r--r--   1 dieter  staff  4017030 Mar 10 11:57 openvswitch-datapath-source_2.3.90-1_all.deb
-rw-r--r--   1 dieter  staff  8890172 Mar 10 11:57 openvswitch-dbg_2.3.90-1_armhf.deb
-rw-r--r--   1 dieter  staff    39632 Mar 10 11:57 openvswitch-ipsec_2.3.90-1_armhf.deb
-rw-r--r--   1 dieter  staff    32828 Mar 10 11:57 openvswitch-pki_2.3.90-1_all.deb
-rw-r--r--   1 dieter  staff  1877584 Mar 10 11:57 openvswitch-switch_2.3.90-1_armhf.deb
-rw-r--r--   1 dieter  staff    49564 Mar 10 11:57 openvswitch-test_2.3.90-1_all.deb
-rw-r--r--   1 dieter  staff   409438 Mar 10 11:57 openvswitch-testcontroller_2.3.90-1_armhf.deb
-rw-r--r--   1 dieter  staff   191142 Mar 10 11:57 openvswitch-vtep_2.3.90-1_armhf.deb
-rw-r--r--   1 dieter  staff    92960 Mar 10 11:57 python-openvswitch_2.3.90-1_all.deb
```
