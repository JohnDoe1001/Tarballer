#!/bin/sh

tarballer() {
    echo Welcome to the Tarballer 0.3.3!
    echo Please specifiy the path to your tarball.
    read tarball 
    if $tarball = /* ; then
        tar -zxvf $tarball || tar -jxvf $tarball
        cd $tarball
        ./configure
        make
        sudo make install
    else
        clear
        tarballer()
    fi
}
tarballer()
