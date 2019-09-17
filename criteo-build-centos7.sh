#!/bin/sh -xe

git submodule update --init tools-local/arcade-services

ROOT=$(pwd)
DOCKER_ARGS="run --env SOURCE_BUILD_SKIP_SUBMODULE_CHECK=1 -i --rm -v ${ROOT}:/mnt/source-build -w /mnt/source-build  microsoft/dotnet-buildtools-prereqs:centos-7-d485f41-20173404063424"
docker ${DOCKER_ARGS}  /mnt/source-build/build.sh /p:RootRepo=core-setup
