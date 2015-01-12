#!/bin/bash

GMOCK="gmock-1.7.0"
LIB_DIR="lib"
GMOCK_DIR="$LIB_DIR/$GMOCK"
GMOCK_ZIP="${GMOCK}.zip"
GMOCK_ZIP_URL="https://googlemock.googlecode.com/files/${GMOCK_ZIP}"

function setup_build_directory()
{
  build_name=$1
  dir_name=$(echo $build_name | tr '[:upper:]' '[:lower:]')
  if [ ! -d "$dir_name" ]; then
    echo ">> creating $dir_name directory..."
    mkdir $dir_name
  fi
  echo ">> running cmake in ${dir_name}..."
  cd $dir_name 
  if ! cmake .. -DCMAKE_BUILD_TYPE=$build_name \
    -DGMOCK_ROOT=$GMOCK_DIR > /dev/null; then
  echo ">> error running cmake!"
  exit 1
fi
cd ..
}

function setup_gmock()
{
  if [ ! -d "$GMOCK_DIR" ]; then
    echo ">> downloading gmock..."
    mkdir -p "$LIB_DIR"
    cd "$LIB_DIR"
    if ! wget $GMOCK_ZIP_URL > /dev/null; then
      echo ">> error running wget!"
      exit 1
    fi
    echo ">> uncompressing zip..."
    if ! unzip $GMOCK_ZIP > /dev/null; then
      echo ">> error running unzip!"
      exit 1
    fi
    echo ">> building gmock and gtest..."
    cd $GMOCK
    if ! cmake -Bbuild -H. > /dev/null; then
      echo ">> error running cmake!"
      exit 1
    fi
    cd build
    if ! make -j4 > /dev/null; then
      echo ">> error running make!"
      exit 1
    fi
    cd ../../../
  fi
}

setup_gmock
#setup_build_directory "Debug"
#setup_build_directory "Release"

exit 0
