#!/bin/bash
# maps .asc files of water and converts them to .png

files=("$@")
# strip extension


for f in "${files[@]}"
do
  echo $f 
  filename=${f%.*}
# convert to .tif
  gdaldem color-relief $f ~/bin/water.pal $filename'.tif'
# convert .tif to .png
  convert -quiet $filename'.tif' $filename'.png'
# delete .tif
  rm $filename'.tif'
done

