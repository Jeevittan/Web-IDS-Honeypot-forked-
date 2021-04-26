#!/bin/bash
until $(curl --output /dev/null --silent --head --fail http://honeypots/login); do
    echo 'Waiting on servers to load..'
    sleep 5
done
echo "Testing Ping"
ping -c 4 honeypots
echo "Settings up Virtual framebuffer "
Xvfb :100 & 
sleep 5
export DISPLAY=:100
echo "Testing QVNCServer"
echo "test" | vncviewer -autopass honeypots
python3 testing.py
echo "Testing NMAP #1"
nmap honeypots
#nmap honeypots -sV -sS -PN -O -T4 --top-ports 250