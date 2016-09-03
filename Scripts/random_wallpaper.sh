#!/bin/sh
dir='/home/jacek/Images/wallpapers'
file=`/bin/ls -1 "$dir" | sort --random-sort | head -1`
path=`readlink --canonicalize "$dir/$file"` # Converts to full path
echo "The randomly-selected file is: $path"
feh  --bg-scale $path 
