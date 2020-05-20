#!/bin/sh

lat=$(exiftool -gpslatitude -n -short3 $1)
lon=$(exiftool -gpslongitude -n -short3 $1)

url="http://geocoder.nextgis.com/reverse.php?format=json&lat=$lat&lon=$lon&zoom=16"

road=$(curl -s "$url" | jq '.address.road'| tr -d '"'| tr -d 'null')
city=$(curl -s "$url" | jq '.address.city'| tr -d '"'| tr -d 'null')
village=$(curl -s "$url" | jq '.address.village'| tr -d '"'| tr -d 'null')

text="$village\n$city\n$road"

#echo $road

#filename=$(basename -s .JPG "$1")
#echo "$text" > "$filename".txt
#textfile="$filename".txt
#text=$(cat $textfile)

frame_path=$(dirname "$1")
frame_name=$(basename -s .JPG "$1")
frame_full_path=$frame_path/videoframes/$frame_name
#mkdir -p $frame_path/texted
#convert $1 -crop 4608x2592+0+0 -pointsize 100 -fill white -undercolor gray -gravity SouthWest -annotate +266+235 "$text" $frame_full_path.JPG
convert $1 -crop 4608x2592+0+0 -pointsize 100 -fill white -undercolor gray -gravity NorthWest -annotate +266+2100 "$text" $frame_full_path.JPG