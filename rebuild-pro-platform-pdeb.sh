#!/bin/bash
# USAGE: rebuild-pro-platform-pdeb.sh [cmake opts]

# On JeVoisPro, limit the number of compile threads to not run out of memory:
ncpu=`grep -c processor /proc/cpuinfo`
if [ `grep -c JeVois /proc/cpuinfo` -gt 0 ]; then ncpu=4; fi

# Let's build it:
sudo /bin/rm -rf ppdbuild \
    && mkdir ppdbuild \
    && cd ppdbuild \
    && cmake -DJEVOIS_HARDWARE=PRO -DJEVOIS_PLATFORM=ON -DJEVOIS_MODULES_TO_STAGING=ON -DJEVOISPRO_PLATFORM_DEB=ON $@ .. \
    && make -j ${ncpu} \
    && sudo make install \
    && sudo cpack

