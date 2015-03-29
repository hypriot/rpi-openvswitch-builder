# rpi-openvswitch-builder

Just following the build instructions in https://github.com/openvswitch/ovs/blob/master/INSTALL.Debian.md

## Step 1: build the builder Docker Image, compile Open vSwitch, create .deb packages
```bash
./build.sh
```

# Step 2: run the builder just copies the created .deb packages to the host machine
```bash
./run-builder.sh
```
