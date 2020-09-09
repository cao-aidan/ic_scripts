##################
## Optimization ##
##################
#ecoPlace

#ecoRoute

#source ./script/for_calibre_verify.tcl
setExtractRCMode -effortLevel signoff
setExtractRCMode -lefTechFileMap ./technology/map_file/qrclayermap
setOptMode -fixCap true -fixTran true -fixFanoutLoad true -setupTargetSlack 0.25 -holdTargetSlack 0.08

setDelayCalMode -engine aae -SIAware true
setSIMode -reset
setSIMode -initial_si_iteration_tw infinite
setSIMode -analysisType aae
setSIMode -detailedReports false
setSIMode -separate_delta_delay_on_data true
setSIMode -delta_delay_annotation_mode lumpedOnNet
setSIMode -num_si_iteration 4
setSIMode -enable_glitch_report true

#opt setup
set_analysis_view   -setup [list slow_Cmax_view ] -hold  [list slow_Cmax_view ]
optDesign -postRoute -setup -outDir timingReports/opt_setup
saveDesign ./DB1/opt_setup.enc
#opt drv
#optDesign -postRoute -drv -outDir timingReports/opt_drv
#saveDesign ./DB1/opt_drv.enc

#opt hold
set_analysis_view   -setup [list fast_Cmin_view]  -hold  [list fast_Cmin_view]
optDesign -postRoute -hold -outDir timingReports/opt_hold
saveDesign ./DB1/opt_hold.enc

ecoRoute

#opt hold
#set_analysis_view   -setup [list fast_Cmin_view] -hold  [list fast_Cmin_view]
#optDesign -postRoute -hold -outDir timingReports/opt_hold
#saveDesign ./DB/opt_hold.enc

#Fix DRC 
 

saveDesign ./DB1/opt_eco.enc

#set_analysis_view -setup [list slow_Cmax_view] -hold [list fast_Cmin_view]
#source ./script/for_post_sim.tcl


source ./script/signoff.tcl

