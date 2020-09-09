####################################################
# File Name : design_import.tcl
# Function  : init design
# Created by: Xugang Cao
####################################################
# Global Settings
suppressMessage ENCEXT-2799
setDesignMode -process 55
setMultiCpuUsage -local 72
#[exec cat /proc/cpuinfo | grep 'process' | sort | uniq | wc -l]
# cpf file
#set init_cpf_file ./cpf/top_synth.cpf

# lef files
set mem_lef [exec find ./technology/mem_tech/ -name *CM?.lef]
set dll_lef ./technology/DLL/DLL.lef
set sc_lef [list\
    	/workspace/technology/umc/55nm_201908/SC/functional_lib/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055LSCLPMVBDR-LIBRARY_TAPE_OUT_KIT-Ver.B01_P.B/lef/tf/u055lsclpmvbdr_7m0t1f.lef \
	/workspace/technology/umc/55nm_201908/SC/functional_lib/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055LSCLPMVBDR-LIBRARY_TAPE_OUT_KIT-Ver.B01_P.B/lef/u055lsclpmvbdr.lef \
	/workspace/technology/umc/55nm_201908/SC/functional_lib/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055LSCLPMVBDH-LIBRARY_TAPE_OUT_KIT-Ver.B01_P.B/lef/u055lsclpmvbdh.lef \
	/workspace/technology/umc/55nm_201908/SC/functional_lib/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055LSCLPMVBDL-LIBRARY_TAPE_OUT_KIT-Ver.A01_PB/lef/u055lsclpmvbdl.lef \
	/workspace/technology/umc/55nm_201908/IO/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055GIOLP25MVIRFS-LIBRARY_TAPE_OUT_KIT-Ver.B06_PB/lef/u055giolp25mvirfs_7m0t1f.lef\
	${dll_lef}	]
	
set init_lef_file [concat $sc_lef $mem_lef ]
set init_pwr_net {VDD VDDA VDDIO}
set init_gnd_net {VSS VSSA VSSIO}
set init_verilog ./p+r_enc/*synth.v
set init_top_cell ASIC
set init_mmmc_file ./script/mmmc.tcl

# init design
init_design

# Read Power Intent CPF
#read_power_intent -cpf ./cpf/top_synth.cpf
#commit_power_intent
#loadCPF ./cpf/aes.cpf
#commitCPF -keepRows -powerDomain -power_switch

# set analysis mode
setAnalysisMode -analysisType onChipVariation -cppr both -checkType setup
# set report format
set_global report_timing_format {instance pin cell net fanout load slew delay arrival user_derate }
# set path group
createBasicPathGroups -reset
createBasicPathGroups -expanded

# check design
checkDesign -all

# saveDesign
saveDesign ./DB/design_import.enc


