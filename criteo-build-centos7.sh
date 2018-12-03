#!/bin/sh -xe

git submodule update --init src/coreclr
git submodule update --init src/corefx
git submodule update --init src/standard
git submodule update --init src/core-setup
git submodule update --init src/newtonsoft-json
git submodule update --init src/linker
cd src/linker
git submodule update --init cecil
cd - 

ROOT=$(pwd)
DOCKER_ARGS="run --env SOURCE_BUILD_SKIP_SUBMODULE_CHECK=1 -i --rm -v ${ROOT}:/mnt/source-build -w /mnt/source-build  microsoft/dotnet-buildtools-prereqs:centos-7-b46d863-20180719033416"
docker ${DOCKER_ARGS}  /mnt/source-build/build.sh /p:Configuration=Debug /p:RootRepo=core-setup
