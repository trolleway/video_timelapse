#!/bin/sh

#mkdir $1/texted
mkdir -p $1/videoframes
mkdir -p $1/videoframes/texted

echo "1 (3)"
#ls -d $1/*.JPG | parallel --bar convert -crop 4608x2592+0+0  "{}" "$1/videoframes/{/}"    # {/} - extract filename from path in parallel

echo "2 (3)"
ls -d $1/*.JPG |  parallel --bar ./print_streetname.sh {}

echo "3 (3)"
ffmpeg  -pattern_type glob -i "$1/videoframes/*.JPG" -c:v libx264 -preset faster -crf 22 -framerate 24 -c:a copy -y $1/out.mp4
#rm -rf $1/videoframes
#rm -rf $1/videoframes/texted

echo $1/out.mp4