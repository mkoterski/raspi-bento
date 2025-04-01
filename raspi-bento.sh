#!/bin/bash

[ "$(whoami)" == "root" ] || { echo "Raspi Bento requires to be run as sudo!"; exit 1; }
