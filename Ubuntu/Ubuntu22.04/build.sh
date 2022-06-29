#!/usr/bin/env bash
from=`pwd`
cd `dirname $0`

if [ "$#" = "1" ]; then
    echo $1
    docker build . --build-arg PASSWD=$1 -t ubuntu:22.04-basic-x86
else
    echo pass
    docker build . --build-arg PASSWD=pass -t ubuntu:22.04-basic-x86
fi
cd $from
