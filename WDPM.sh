#!/bin/bash
# do curve 1

precip=1
delta=1
  nice -19 ./WDPMCL add SubBasin3_fixed.asc NULL $precip'_0_0_0_u.asc' NULL $delta'.0' 1.0 100.0 1 1 | tee $precip'_0_0_0_u.txt'
  nice -19 ./WDPMCL drain SubBasin3_fixed.asc $precip'_0_0_0_u.asc' $precip'_0_0_0_d.asc' $precip'_0_0_0_d_backup.asc' 0.001 0.1 1 1 | tee $precip'_0_0_0_d.txt'
  nice -19 ./WDPMCL add SubBasin3_fixed.asc $precip'_0_0_0_d.asc' $precip'_0_1_0_u.asc' NULL 1.0 1 100.0 1 1 | tee $precip'_0_1_0_u.txt'
  nice -19 ./WDPMCL drain SubBasin3_fixed.asc $precip'_0_1_0_u.asc' $precip'_0_1_0_d.asc' $precip'_0_1_0_d_backup.asc' 0.001 0.1 1 1 | tee $precip'_0_1_0_d.txt'


oldprecip=1
for precip in 5 10 20 50 100 200 300
do
  delta=`expr $precip - $oldprecip`
  nice -19 ./WDPMCL add SubBasin3_fixed.asc $oldprecip'_0_0_0_d.asc' $precip'_0_0_0_u.asc' NULL $delta'.0' 1.0 100.0 1 1 | tee $precip'_0_0_0_u.txt'
  nice -19 ./WDPMCL drain SubBasin3_fixed.asc $precip'_0_0_0_u.asc' $precip'_0_0_0_d.asc' $precip'_0_0_0_d_backup.asc' 0.001 0.1 1 1 | tee $precip'_0_0_0_d.txt'
  nice -19 ./WDPMCL add SubBasin3_fixed.asc $precip'_0_0_0_d.asc' $precip'_0_1_0_u.asc' NULL 1.0 1 100.0 1 1 | tee $precip'_0_1_0_u.txt'
  nice -19 ./WDPMCL drain SubBasin3_fixed.asc $precip'_0_1_0_u.asc' $precip'_0_1_0_d.asc' $precip'_0_1_0_d_backup.asc' 0.001 0.1 1 1 | tee $precip'_0_1_0_d.txt'
  oldprecip=$precip
  rm $precip'_0_0_0_d_backup.asc'
done

