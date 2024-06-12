#!/bin/bash
# USAGE: rebuild-platform.sh [--jvpkg] [cmake opts]
#
# If --jvpkg is specified, then a jevois .jvpkg package will also be created

set -e

create_jvpkg="no"
if [ "X$1" = "X--jvpkg" ]; then create_jvpkg="yes"; shift; fi

# Get the external contributed packages if they are not here or are outdated:
./Contrib/check.sh

# Let's build it:
sudo /bin/rm -rf pbuild
mkdir pbuild
cd pbuild
cmake "$@" -DJEVOIS_PLATFORM=ON ..
make -j
sudo make install
cd ..

if [ $jvpkg = "yes" ]; then jevois-jvpkg `cat pbuild/jvpkg-args`; fi
