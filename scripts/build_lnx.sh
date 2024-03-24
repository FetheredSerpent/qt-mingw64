#!/bin/sh

echo -e "nameserver 1.1.1.1\nnameserver 8.8.8.8\nnameserver 8.8.4.4\n" > /etc/resolv.conf
apk update
apk add alpine-sdk cmake perl ninja-build ninja-is-really-ninja openssl-dev ffmpeg-dev clang14-libclang

cd /work
cd qtbase
mkdir out && cd out
../configure --help
