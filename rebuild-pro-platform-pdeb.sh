#!/bin/bash
# USAGE: rebuild-pro-platform-pdeb.sh [cmake opts]

# Let's build it:
sudo /bin/rm -rf ppdbuild \
    && mkdir ppdbuild \
    && cd ppdbuild \
    && cmake -DJEVOIS_HARDWARE=PRO -DJEVOIS_PLATFORM=ON -DJEVOISPRO_PLATFORM_DEB=ON $@ .. \
    && make -j \
    && sudo make install \
    && sudo cpack

