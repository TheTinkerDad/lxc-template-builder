#!/bin/sh

if [ -z $1 ]; then
  echo "Usage: build-container.sh <folder-with-your-packer-build-config> [<folder-to-store-the-final-tar-gz-file>]"
  exit
fi

if [ ! -d $1 ]; then
  echo "Provided config folder does not exist or not a folder at all."
  exit
fi
CONTAINER=$(basename $1)

TEMPLATE_STORE=.
if [ ! -z $2 ]; then
  if [ ! -d $2 ]; then
    echo "Provided target folder does not exist or not a folder at all."
    exit
  else
    TEMPLATE_STORE=$2
  fi
fi

TEMPLATE_STORE=$(cd $TEMPLATE_STORE;pwd)
echo "Generated template will be stored in $TEMPLATE_STORE"

TEMPLATE_DT=$(date +%Y-%m-%d-%H-%M-%S)
CURRENT_FOLDER=$(pwd)

cd $1
packer build build.pkr.hcl

if [ ! $? -eq 0 ]; then
  echo "Packer build failed - exiting. Please check the logs above!"
  exit
fi

mkdir $TEMPLATE_STORE/$CONTAINER-$TEMPLATE_DT

# We need to repackage the template because of https://github.com/hashicorp/packer-plugin-lxc/issues/7
cd output-ct
tar xzf rootfs.tar.gz
cd rootfs
tar zcf $TEMPLATE_STORE/$CONTAINER-$TEMPLATE_DT/$CONTAINER-$TEMPLATE_DT.tar.gz .
cd ../
rm -rf rootfs

cp lxc-config $TEMPLATE_STORE/$CONTAINER-$TEMPLATE_DT/$CONTAINER-$TEMPLATE_DT.conf

cd $CURRENT_FOLDER
