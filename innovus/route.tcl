#############
## Routing ##
#############
#Routing Setting
setAttribute -net PORE -skip_routing true
#setAnalysisMode -usefulSkew false
setAnalysisMode -analysisType onChipVariation  -cppr both
setNanoRouteMode -reset
setNanoRouteMode -routeInsertDiodeForClockNets true 
setNanoRouteMode -drouteFixAntenna true  -routeAntennaCellName {ANTTM} -routeInsertAntennaDiode true
setNanoRouteMode -routeWithTimingDriven true  -routeWithEco true
#-routeTopRoutingLayer 7
#Routing
routeDesign

#Report timing
timeDesign -postRoute -numPaths 100 -outDir timingReports/postRoute -prefix postRoute
timeDesign -hold -postRoute -numPaths 100 -outDir timingReports/postRoute -prefix postRouteHold
 
saveDesign ./DB/route.enc

##################
## Optimization ##
##################
setExtractRCMode -effortLevel high
setExtractRCMode -lefTechFileMap ./technology/map_file/qrclayermap
setOptMode -fixCap true -fixTran true -fixFanoutLoad true -setupTargetSlack 0.0 -holdTargetSlack 0.00

#opt setup
optDesign -postRoute -setup -outDir timingReports/opt_setup
saveDesign ./DB/opt_setup.enc

#opt hold
optDesign -postRoute -hold -outDir timingReports/opt_hold
saveDesign ./DB/opt_hold.enc

#opt drv
optDesign -postRoute -drv -outDir timingReports/opt_drv
saveDesign ./DB/opt_drv.enc

#opt hold
optDesign -postRoute -hold -outDir timingReports/opt_hold
saveDesign ./DB/opt_hold.enc

#Fix DRC 
ecoRoute 

saveDesign ./DB/opt_eco.enc

