#!/bin/sh

lat=$(exiftool -gpslatitude -n -short3 $1)
lon=$(exiftool -gpslongitude -n -short3 $1)

url="http://geocoder.nextgis.com/reverse.php?format=json&lat=$lat&lon=$lon&zoom=16"

road=$(curl -s "$url" | jq '.address.road'| tr -d '"'| tr -d 'null')
city=$(curl -s "$url" | jq '.address.city'| tr -d '"'| tr -d 'null')
village=$(curl -s "$url" | jq '.address.village'| tr -d '"'| tr -d 'null')

text="$village\n$city\n$road"

echo $road

filename=$(basename -s .JPG "$1")
echo "$text" > "$filename".txt
textfile="$filename".txt
text=$(cat $textfile)
convert $1 -pointsize 100 -fill white -undercolor gray -gravity SouthWest -annotate +266+235 "$text" texted/$1