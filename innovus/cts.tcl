####################################################
# File Name : cts.tcl
# Function  : clock tree synthesis
# Created by: Xugang Cao
####################################################

#Create Non Default Rule
add_ndr -width {M1 0.18 M2 0.2 M3 0.2 M4 0.2 M5 0.4 M6 0.4 } -name 2W1S
add_ndr -init 2W1S -spacing {M1 0.18 M2 0.2 M3 0.2 M4 0.2 M5 0.4 M6 0.4 } -name 2W2S
add_ndr -width {M5 0.4  M6 0.8  M7 0.8} -spacing { M5 0.8 M6 0.8 M7 0.8} -name 4W4S

#Shielding setting
setAttribute -net *reset* -shield_net VSS -non_default_rule 2W2S 
setAttribute -net *rst_n* -shield_net VSS -non_default_rule 2W2S 

#Ccopt setting
set_ccopt_property use_inverters true
set_ccopt_property inverter_cells {CKINVM2TM CKINVM3TM CKINVM4TM CKINVM6TM CKINVM8TM CKINVM12TM CKINVM16TM CKINVM20TM CKINVM24TM  }
set_ccopt_property buffer_cells {CKBUFM2TM CKBUFM3TM CKBUFM4TM CKBUFM6TM CKBUFM8TM CKBUFM12TM CKBUFM16TM CKBUFM20TM CKBUFM24TM }

set_ccopt_property routing_top_min_fanout 10000

create_route_type -name top_rule   -non_default_rule 4W4S -top_preferred_layer M6 -bottom_preferred_layer M5 -shield_net VSS -bottom_shield_layer M5
create_route_type -name trunk_rule -non_default_rule 2W2S -top_preferred_layer M6 -bottom_preferred_layer M5 -shield_net VSS -bottom_shield_layer M5
create_route_type -name leaf_rule  -non_default_rule 2W1S -top_preferred_layer M6 -bottom_preferred_layer M4
set_ccopt_property route_type top_rule   -net_type top 
set_ccopt_property route_type trunk_rule -net_type trunk 
set_ccopt_property route_type leaf_rule  -net_type leaf 

set_ccopt_property -net_type top   target_max_trans 0.3ns
set_ccopt_property -net_type trunk target_max_trans 0.3ns
set_ccopt_property -net_type leaf  target_max_trans 0.25ns
set_ccopt_property target_skew auto
create_ccopt_clock_tree_spec -file ./script/cts.spec

#Set timing derate
source ./script/timing_derate.tcl

#Clock Tree Synthesis with opt
ccopt_design -cts -outDir ./timingReports/ccopt_cts

saveDesign ./DB/postCTS.enc

#opt, fix hold time 
set_interactive_constraint_modes default_constraint_mode
set_clock_latency -source  0 [get_pins DLL_i/OUTCLK] -clock clock_clk
set_clock_latency -source  0 [get_pins O_spi_sck_PAD_rd0/DI] -clock clock_sck

setOptMode -fixCap true -fixTran true -fixFanoutLoad true -verbose true -allEndPoints true
optDesign -postCTS -setup -outDir timingReports/cts_setup
saveDesign ./DB/postCTS_setup.enc

optDesign -postCTS -hold -outDir timingReports/cts_hold
saveDesign ./DB/postCTS_hold.enc

optDesign -postCTS -drv -outDir timingReports/cts_drv
saveDesign ./DB/postCTS_drv.enc

# report
mkdir -p ./CTS
report_ccopt_clock_trees -file ./CTS/clock_trees.rpt

#Report on skew groups to check insertion delay and skew.
report_ccopt_skew_groups -file ./CTS/skew_groups.rpt

# saveDesign
saveDesign ./DB/postCTS_opt.enc
