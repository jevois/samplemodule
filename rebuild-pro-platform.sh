#!/bin/bash
# USAGE: rebuild-pro-platform-pdeb.sh [cmake opts]

# Let's build it:
sudo /bin/rm -rf ppdbuild \
    && mkdir ppdbuild \
    && cd ppdbuild \
    && cmake -DJEVOIS_HARDWARE=PRO -DJEVOIS_PLATFORM=ON -DJEVOIS_MODULES_TO_STAGING=ON $@ .. \
    && make -j \
    && sudo make install \
    && sudo cpack

