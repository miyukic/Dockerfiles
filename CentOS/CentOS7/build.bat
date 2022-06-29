@echo off
chcp 65001
IF NOT "%~1"=="" (
    echo %1
    docker build . --build-arg PASSWD=%1 -t centos:centos7-basic-x86
) ELSE (
    echo pass
    docker build . --build-arg PASSWD=pass -t centos:centos7-basic-x86
)
pause
