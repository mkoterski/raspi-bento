#!/bin/bash

# Check if script is run as root
[ "$(whoami)" == "root" ] || { echo "raspi-bento requires to be run as sudo!"; exit 1; }

# Menu
Raspi Bento - v0.04                                          2025-01-18 - 13:58
calypso | Ubuntu 24.04.1 LTS | aarch64      Raspberry Pi 3 Model B Plus Rev 1.3

1 - Internet Test       Internet                    Network
                        Ping: 28.975 ms             Connection(s): eth0, wlan0
                        Download: 47.86 Mbit/s      Local IP: 192.168.1.132
                        Upload: 52.54 Mbit/s        Public IP: 80.12.34.88
2 - CPU Test            CPU             Threads         Memory
                        time: 10.0014s  time: 10.0133s  time: 1.4694s
                        min: 1.39       min: 54.33      min: 0.00
                        avg: 1.41       avg: 54.75      avg: 0.00
                        max: 2.02       max: 56.02      max: 0.34
                                                        3072.00 MiB transferred
                                                        (2070.30 MiB/sec)
3 - SD Card Test        DD WRITE test               DD READ test
                        537 MB / 512 MiB copied,    537 MB / 512 MiB copied,
                        52.8301 s, 10.2 MB/s        22.9001 s, 23.4 MB/s
                        max. read speed: 68 MB in  3.03 seconds =  22.44 MB/sec

Press number to run test or 'q' to quit:
                   