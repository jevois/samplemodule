#!/bin/bash
# USAGE: rebuild-platform.sh [--jvpkg] [cmake opts]
#
# If --jvpkg is specified, then a jevois .jvpkg package will also be created

set -e

create_jvpkg="no"
if [ "X$1" = "X--jvpkg" ]; then create_jvpkg="yes"; shift; fi

# Let's build it:
sudo /bin/rm -rf pbuild
mkdir pbuild
cd pbuild
cmake "$@" -DJEVOIS_PLATFORM=ON ..
make -j
sudo make install
cd ..

if [ $create_jvpkg = "yes" ]; then jevois-jvpkg `cat pbuild/jvpkg-args`; fi
