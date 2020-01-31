#!/bin/bash
VIMSERVER=$(vim --serverlist| tail -1)
if [ -z $VIMSERVER ]
then
    echo "No vim instance running"
    exit 1
fi

DIR=$(vim --servername $VIMSERVER --remote-expr "expand('%:p:h')")/graphics
if [ ! -d $DIR ] 
then
    mkdir $DIR
fi
NAME=$(date +%Y-%m-%d_%H%M%S)_$1
if [ -f $1 ]
then
    cp $1 $DIR/$NAME
    vim --servername $VIMSERVER --remote-send \
    "<ESC>o\\includegraphics[width=.8\\textwidth]{graphics/$NAME}<ESC>"
else
    echo "No such file $1"
    exit 1
fi
