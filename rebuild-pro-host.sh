#!/bin/sh

# Build everything:
sudo /bin/rm -rf phbuild \
    && mkdir phbuild \
    && cd phbuild \
    && cmake "$@" -DJEVOIS_HARDWARE=PRO .. \
    && make -j \
    && sudo make install
