#!/bin/bash
# do CRHM runs
source DRIdoruns.sh

# go to output directory
cd ./Output
# do R and map processing
#1. process by HRU 
Rscript  ~/Rcode/BatchCRHMSummary.r "CRHM_output_*_CropRotation.txt"
 
source do_HRUMeanMoistureMaps.sh CRHM_MeanSoilMoistRatio_SWE3.txt
source do_HRUMinMoisturemaps.sh CRHM_MinSoilMoistRatio_SWE3.txt
source do_HRUOutflowmaps.sh CRHM_NormalizedOutflowRatio_SWE3.txt
source do_HRURunoffmaps.sh CRHM_MeltRunoffRatio_SWE3.txt
source do_HRUSWEmaps.sh CRHM_PeakRatio_SWE3.txt

#2. process fallow/stubble
Rscript  ~/Rcode/BatchFallowStubblePlots.r "CRHM_output_*_CropRotation.txt"
source FallowStubbleMeanMoistureMaps.sh CRHM_MeanSoilMoistRatio_Fallow.txt
source FallowStubbleMeanMoistureMaps.sh CRHM_MeanSoilMoistRatio_Stubble.txt
source FallowStubbleMinMoistureMaps.sh CRHM_MinSoilMoistRatio_Fallow.txt
source FallowStubbleMinMoistureMaps.sh CRHM_MinSoilMoistRatio_Stubble.txt
Rscript  ~/Rcode/BatchFallowStubbleExceedenceDataSets.r "CRHM_output_*_CropRotation.txt"
source FallowStubbleSWEMaps.sh CRHM_SWEPeakRatio_Fallow.txt
source FallowStubbleSWEMaps.sh CRHM_SWEPeakRatio_Stubble.txt
