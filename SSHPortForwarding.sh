#! /bin/bash

# Well, it would be easier to explain what it does with an example. Imagine that you got a powerful PC, and a weak VPS. What you could do is simply connecting your PC to the VPS via VPN, and then forward a local port via ssh.

IP=$1
PORT=$2

ssh -L $PORT:$IP:$PORT -N -o GatewayPorts=yes auser@$IP
