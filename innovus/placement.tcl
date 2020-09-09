###############
## Placement ##
###############
#Settings
setMultiCpuUsage -localCpu 32
setAnalysisMode -analysisType onChipVariation -skew true -cppr both
setRouteMode -earlyGlobalMaxRouteLayer 6 -earlyGlobalMinRouteLayer 1

#Placement with optimization
#place_opt_design -out_dir ./timingReports/place_opt/
placeDesign
saveDesign ./DB/placement.enc

#add Tie cell
setTieHiLoMode -cell { TIE1TM TIE0TM} -maxFanOut 4 -honorDontTouch false -createHierPort false
addTieHiLo -cell {TIE1TM TIE0TM} -prefix TIE

#opt
optDesign -preCTS -outDir ./timingReports/place_opt/

saveDesign ./DB/placement_opt.enc
