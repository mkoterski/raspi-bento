# This file is generated from information provided by the datasource.  Changes
# to it will not persist across an instance reboot.  To disable cloud-init's
# network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    version: 2
    wifis:
        renderer: networkd
        wlan0:
            access-points:
                Treehouse:
                    password: 0c2c58aed5c1984a46cd0d35bae7391a41eadba608de1771dd73a>
            dhcp4: true
            optional: true
