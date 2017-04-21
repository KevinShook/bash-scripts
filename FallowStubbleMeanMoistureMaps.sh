#!/bin/bash

for f in $1
 do
  echo $f
  for i in `seq 3 47`;
   do
    year=$[$i+1958]
    echo $year
    
    bar=(`echo $f | tr '_' ' '`)
    type=${bar[1]}
    rest=${bar[2]}
    bar2=(`echo $rest | tr '.' ' '`)
    hru=${bar2[0]}
    
# grid data & mask area outside prairies
    gmtconvert $f -F0,1,$i -N | surface -GSWE.grd -I0.1 -R-115/-96/49/55 -Ll0.001
    grdmath prairie_mask.grd SWE.grd MUL = MaskedSWE.grd

# do contour map
    psbasemap -R-115/-96/49/55 -JM20 -K -Ba2f1 -Y5c> $type"_"$hru"_"$year"_Masked_Contour.ps"
    grdcontour MaskedSWE.grd -R-115/-96/49/55 -C0.1 -A0.2 -Gd5c -JM20 -O -K -Bg30:."$year": >>  $type"_"$hru"_"$year"_Masked_Contour.ps"
    psxy prairie.xy -R-115/-96/49/55 -JM20 -O >>  $type"_"$hru"_"$year"_Masked_Contour.ps"

# do shaded map
    psbasemap -R-115/-96/49/55 -JM20 -K -Ba2f1 -Y5c  > $type"_"$hru"_"$year"_map.ps"
    grdimage MaskedSWE.grd -Cnormal4.cpt -R-115/-96/49/55  -JM20 -K -O -Bg30:."$year": >> $type"_"$hru"_"$year"_map.ps"
    psscale -O -D10c/-1c/12c/1ch -Cnormal4.cpt -Li -B:"Mean soil moisture/Normal mean soil moisture": >> $type"_"$hru"_"$year"_map.ps"
#convert to raster$type"_"$hru
   ps2raster -Tg -P $type"_"$hru"_"$year"_map.ps" 
   done
done
