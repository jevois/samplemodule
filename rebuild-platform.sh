#!/bin/bash
# USAGE: rebuild-platform.sh [cmake opts]

set -e

# Let's build it:
sudo /bin/rm -rf pbuild
mkdir pbuild
cd pbuild
cmake "$@" -DJEVOIS_PLATFORM=ON ..
make -j
sudo make install
cd ..

jevois-jvpkg `cat pbuild/jvpkg-args`
