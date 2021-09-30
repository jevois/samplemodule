#!/bin/sh

/bin/rm -rf hbuild \
    && mkdir hbuild \
    && cd hbuild \
    && cmake "$@" .. \
    && make -j \
    && sudo make install
