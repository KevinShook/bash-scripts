#!/bin/bash
echo 'num_sloughs total_basin_area max_slough_area max_slough_volume InitialState precip final_vol final_area delta_vol outflow_volume volfrac areafrac rof' > AreaVolume_Loop1.txt
echo 'num_sloughs total_basin_area max_slough_area max_slough_volume InitialState precip final_vol final_area delta_vol outflow_volume volfrac areafrac rof' > AreaVolumeROP_Loop1.txt


for precip in `seq 1 1 9`;
  do
# fill sloughs
   ./PCM areas.txt volumes.txt  direct.txt  empty $precip.0 1.0  $precip'mmSloughAreas.txt'  >> AreaVolume_Loop1.txt

# add 1mm to get ROP
   j=$(( $precip + 1 ))
   ./PCM areas.txt volumes.txt direct.txt $precip'mmSloughAreas.txt' 1.0 1.0 $j'mmSloughAreas.txt' >> AreaVolumeROP_Loop1.txt 
 done 


for precip in `seq 10 10 310`;
  do
# fill sloughs
   ./PCM areas.txt volumes.txt  direct.txt  empty $precip.0 1.0  $precip'mmSloughAreas.txt' >> AreaVolume_Loop1.txt
# add 1mm to get ROP
   j=$(( $precip + 1 ))
   ./PCM areas.txt volumes.txt direct.txt $precip'mmSloughAreas.txt' 1.0 1.0  $j'mmSloughAreas.txt' >> AreaVolumeROP_Loop1.txt 
 done 



# do evap
for evap in `seq -10 -10 -800`;
  do
# evaporate sloughs
   j=$((evap*-1))
   ./PCM areas.txt volumes.txt direct.txt 300mmSloughAreas.txt $evap.0 1.0 '300_'$j'mmSloughAreas.txt' >> AreaVolume_Loop1.txt

# add 1mm to get ROP

   ./PCM areas.txt volumes.txt  direct.txt '300_'$j'mmSloughAreas.txt' 1.0 1.0 '300_'$j'_1_mmSloughAreas.txt' >> AreaVolumeROP_Loop1.txt
 done 

