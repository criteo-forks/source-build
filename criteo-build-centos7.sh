#!/bin/sh -xe

git_tag=$1

git submodule update --init --recursive

ROOT=$(pwd)
DOCKER_ARGS="run --env SOURCE_BUILD_SKIP_SUBMODULE_CHECK=1 -i --rm -v ${ROOT}:/mnt/source-build -w /mnt/source-build  microsoft/dotnet-buildtools-prereqs:centos-7-b46d863-20180719033416"

criteo_version=${git_tag#*-}
if [ $criteo_version == $criteo_version ]
then
    version_stamp=""
else
    version_stamp=$criteo_version
fi

docker ${DOCKER_ARGS}  /mnt/source-build/build.sh /p:RootRepo=core-setup /p:VersionStamp="$version_stamp"
