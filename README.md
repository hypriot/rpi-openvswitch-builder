# rpi-openvswitch-builder

Just following the build instructions in https://github.com/openvswitch/ovs/blob/master/INSTALL.Debian.md

## Step 1: build the builder Docker Image, compile Open vSwitch, create .deb packages
`./build.sh`
```bash
#!/bin/sh -x
docker build -t hypriot/rpi-openvswitch-builder .
```

## Step 2: run the builder just copies the created .deb packages to the host machine
`./run-builder.sh`
```bash
#!/bin/sh -x
mkdir -p ./builds
docker run --rm -ti -v $(pwd)/builds:/builds hypriot/rpi-openvswitch-builder /bin/bash -c 'cp /src/*.deb /builds/; chmod a+rw /builds/*'
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
