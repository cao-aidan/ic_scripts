###########################################
## Using Tempus, Signoff Timing Analysis ##
###########################################
#Setting
ecoRoute

setDelayCalMode -engine aae -SIAware true
setSIMode -reset
setSIMode -initial_si_iteration_tw infinite
setSIMode -analysisType aae
setSIMode -detailedReports false
setSIMode -separate_delta_delay_on_data true
setSIMode -delta_delay_annotation_mode lumpedOnNet
setSIMode -num_si_iteration 4
setSIMode -enable_glitch_report true

###########################################
set_analysis_view   -setup [list slow_Cmax_view ] \
                    -hold  [list fast_Cmin_view ]
signoffTimeDesign -outDir ./signoffTimingReports/Cmax_Cmin
saveDesign DB1/signoff1.enc

###########################################
set_analysis_view   -setup [list slow_RCmax_view] \
                    -hold  [list fast_RCmin_view]
signoffTimeDesign -outDir ./signoffTimingReports/RCmax_RCmin

saveDesign ./DB1/signoff2.enc
###########################################
set_analysis_view   -setup [list typical_view ] \
                    -hold  [list typical_view ]
signoffTimeDesign -outDir ./signoffTimingReports/typical
saveDesign DB1/signoff3.enc






