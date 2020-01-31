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
NAME=$(date +%Y-%m-%d_%H%M%S)_from_clip.jpeg
scrot $DIR/$NAME -s 
vim --servername $VIMSERVER --remote-send \
"<ESC>o\\includegraphics[width=.8\\textwidth]{graphics/$NAME}<ESC>"
