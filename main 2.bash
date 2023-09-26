#!/bin/sh

tarballer() {
    echo Welcome to the Tarballer 1.0!
    echo Please specifiy the path to your tarball.
    read tarball 
    if $tar = /* ; then
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
