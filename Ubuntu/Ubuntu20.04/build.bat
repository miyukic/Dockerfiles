@echo off
chcp 65001
IF NOT "%~1"=="" (
    echo %1
    docker build . --build-arg PASSWD=%1 -t ubuntu:20.04-basic-x86
) ELSE (
    echo pass
    docker build . --build-arg PASSWD=pass -t ubuntu:20.04-basic-x86
)
pause
