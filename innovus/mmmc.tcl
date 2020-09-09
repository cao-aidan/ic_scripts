####################################################
# File Name : mmmc.tcl
# Function  : multi-mode-multi-corner
# Created by: Xugang Cao
####################################################
set qrc_dir /workspace/technology/umc/55nm_201908/pdk/FDK/calibre/LPE/QRC
set mem_dir ./technology/mem_tech
set sc_dir  /workspace/technology/umc/55nm_201908
set sdc_file /workspace/home/caoxg/PKU_VLSI_202008/CNN_0814_100M_4x4.7_before_modify/DB/for_calibre.enc.dat/libs/mmmc/default_constraint_mode.sdc
#[exec find ./p+r_enc/ -name *.sdc]
set dll_lib ./technology/DLL/dll.lib
####################################################
# worst case analysis @125
####################################################
# slow library at 125C
set slow_memory_libs [exec find $mem_dir -name *ss*125*.lib]
set slow_standard_libs [list \
	/workspace/technology/umc/55nm_201908/SC/functional_lib/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055LSCLPMVBDR-LIBRARY_TAPE_OUT_KIT-Ver.B01_P.B/synopsys/ccs/u055lsclpmvbdr_108c125_wc_ccs.lib \
	/workspace/technology/umc/55nm_201908/SC/functional_lib/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055LSCLPMVBDH-LIBRARY_TAPE_OUT_KIT-Ver.B01_P.B/synopsys/ccs/u055lsclpmvbdh_108c125_wc_ccs.lib \
	/workspace/technology/umc/55nm_201908/SC/functional_lib/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055LSCLPMVBDL-LIBRARY_TAPE_OUT_KIT-Ver.A01_PB/synopsys/ccs/u055lsclpmvbdl_108c125_wc_ccs.lib \
  	/workspace/technology/umc/55nm_201908/IO/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055GIOLP25MVIRFS-LIBRARY_TAPE_OUT_KIT-Ver.B06_PB/synopsys/u055giolp25mvirfs_297c125_wc.lib \
	${dll_lib} ]
set slow_libs [concat $slow_memory_libs $slow_standard_libs]


# slow library set 125C
create_library_set \
	-name 	slow_library_set\
   	-timing $slow_libs
   
# add CDB file for SI analysis
update_library_set \
	-name 	slow_library_set\
   	-si 	[exec find $sc_dir -name *u055lsclpmvbd*108c125_wc.cdb]
# create rc corner, RCmax and Cmax
create_rc_corner \
	-name slow_RCmax_rc_corner\
   	-preRoute_res 1\
   	-postRoute_res 1\
   	-preRoute_cap 1\
   	-postRoute_cap 1\
   	-postRoute_xcap 1\
   	-preRoute_clkres 0\
   	-preRoute_clkcap 0\
   	-T 125\
   	-qx_tech_file ${qrc_dir}/RCmax/qrcTechFile
create_rc_corner \
	-name slow_Cmax_rc_corner\
	-preRoute_res 1\
	-postRoute_res 1\
   	-preRoute_cap 1\
   	-postRoute_cap 1\
   	-postRoute_xcap 1\
   	-preRoute_clkres 0\
   	-preRoute_clkcap 0\
   	-T 125\
   	-qx_tech_file ${qrc_dir}/Cmax/qrcTechFile
# create delay corner
create_delay_corner \
	-name 		    slow_RCmax_delay_corner\
   	-library_set 	slow_library_set\
   	-opcond_library u055lsclpmvbdr_108c125_wc\
   	-opcond 	    u055lsclpmvbdr_108c125_wc\
   	-rc_corner 	    slow_RCmax_rc_corner

create_delay_corner \
	-name 		    slow_Cmax_delay_corner\
   	-library_set 	slow_library_set\
   	-opcond_library u055lsclpmvbdr_108c125_wc\
   	-opcond 	    u055lsclpmvbdr_108c125_wc\
   	-rc_corner 	    slow_Cmax_rc_corner
   	
#####################################################
# worst case analysis @-40
#####################################################   	
# slow library at -40C
set slow_40_memory_libs [exec find $mem_dir -name *ss*40c.lib]
set slow_40_standard_libs [list \
	/workspace/technology/umc/55nm_201908/SC/functional_lib/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055LSCLPMVBDR-LIBRARY_TAPE_OUT_KIT-Ver.B01_P.B/synopsys/ccs/u055lsclpmvbdr_108-40_wc_ccs.lib \
	/workspace/technology/umc/55nm_201908/SC/functional_lib/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055LSCLPMVBDH-LIBRARY_TAPE_OUT_KIT-Ver.B01_P.B/synopsys/ccs/u055lsclpmvbdh_108-40_wc_ccs.lib \
	/workspace/technology/umc/55nm_201908/SC/functional_lib/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055LSCLPMVBDL-LIBRARY_TAPE_OUT_KIT-Ver.A01_PB/synopsys/ccs/u055lsclpmvbdl_108-40_wc_ccs.lib \
  	/workspace/technology/umc/55nm_201908/IO/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055GIOLP25MVIRFS-LIBRARY_TAPE_OUT_KIT-Ver.B06_PB/synopsys/u055giolp25mvirfs_297c125_wc.lib \
	${dll_lib} ]
set slow_40_libs [concat $slow-40_memory_libs $slow-40_standard_libs]

# slow library set, -40C
create_library_set \
	-name 	slow_40_library_set\
   	-timing $slow_40_libs	
   	
# add CDB file for SI analysis
update_library_set \
	-name 	slow_40_library_set\
   	-si 	[exec find $sc_dir -name *u055lsclpmvbd*108c-40_wc.cdb]
# create rc corner, RCmax and Cmax
create_rc_corner \
	-name slow_40_RCmax_rc_corner\
   	-preRoute_res 1\
   	-postRoute_res 1\
   	-preRoute_cap 1\
   	-postRoute_cap 1\
   	-postRoute_xcap 1\
   	-preRoute_clkres 0\
   	-preRoute_clkcap 0\
   	-T -40\
   	-qx_tech_file ${qrc_dir}/RCmax/qrcTechFile
create_rc_corner \
	-name slow_40_Cmax_rc_corner\
	-preRoute_res 1\
	-postRoute_res 1\
   	-preRoute_cap 1\
   	-postRoute_cap 1\
   	-postRoute_xcap 1\
   	-preRoute_clkres 0\
   	-preRoute_clkcap 0\
   	-T -40\
   	-qx_tech_file ${qrc_dir}/Cmax/qrcTechFile
# create delay corner
create_delay_corner \
	-name 		    slow_40_RCmax_delay_corner\
   	-library_set 	slow_40_library_set\
   	-opcond_library u055lsclpmvbdr_108-40_wc\
   	-opcond 	    u055lsclpmvbdr_108-40_wc\
   	-rc_corner 	    slow_40_RCmax_rc_corner

create_delay_corner \
	-name 		    slow_40_Cmax_delay_corner\
   	-library_set 	slow_40_library_set\
   	-opcond_library u055lsclpmvbdr_108-40_wc\
   	-opcond 	    u055lsclpmvbdr_108-40_wc\
   	-rc_corner 	    slow__40_Cmax_rc_corner
   	   	

#####################################################
# best case analysis
#####################################################
# fast library
set fast_memory_libs [exec find $mem_dir -name *ff*1p32*40*.lib]
set fast_standard_libs [list \
	/workspace/technology/umc/55nm_201908/SC/functional_lib/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055LSCLPMVBDR-LIBRARY_TAPE_OUT_KIT-Ver.B01_P.B/synopsys/u055lsclpmvbdr_132c-40_bc.lib \
    /workspace/technology/umc/55nm_201908/SC/functional_lib/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055LSCLPMVBDH-LIBRARY_TAPE_OUT_KIT-Ver.B01_P.B/synopsys/u055lsclpmvbdh_132c-40_bc.lib \
    /workspace/technology/umc/55nm_201908/SC/functional_lib/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055LSCLPMVBDL-LIBRARY_TAPE_OUT_KIT-Ver.A01_PB/synopsys/u055lsclpmvbdl_132c-40_bc.lib \
  	/workspace/technology/umc/55nm_201908/IO/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055GIOLP25MVIRFS-LIBRARY_TAPE_OUT_KIT-Ver.B06_PB/synopsys/u055giolp25mvirfs_363c-40_bc.lib \
	${dll_lib} ]
set fast_libs [concat $fast_memory_libs $fast_standard_libs]

create_library_set \
	-name 	fast_library_set\
   	-timing $fast_libs

update_library_set \
	-name 	fast_library_set\
	-si  	[exec find $sc_dir -name *u055lsclpmvbd*132*bc.cdb]

create_rc_corner \
	-name 		    fast_RCmin_rc_corner\
   	-preRoute_res 	1\
   	-postRoute_res 	1\
   	-preRoute_cap 	1\
   	-postRoute_cap 	1\
   	-postRoute_xcap 1\
   	-preRoute_clkres 0\
   	-preRoute_clkcap 0\
   	-T -40\
   	-qx_tech_file ${qrc_dir}/RCmin/qrcTechFile

create_rc_corner \
	-name fast_Cmin_rc_corner\
   	-preRoute_res 1\
   	-postRoute_res 1\
   	-preRoute_cap 1\
   	-postRoute_cap 1\
   	-postRoute_xcap 1\
   	-preRoute_clkres 0\
   	-preRoute_clkcap 0\
   	-T -40\
   	-qx_tech_file ${qrc_dir}/Cmin/qrcTechFile

create_delay_corner \
	-name 		    fast_RCmin_delay_corner\
   	-library_set 	fast_library_set\
   	-opcond_library u055lsclpmvbdr_132c-40_bc\
   	-opcond 	    u055lsclpmvbdr_132c-40_bc \
   	-rc_corner 	    fast_RCmin_rc_corner

create_delay_corner \
	-name 		    fast_Cmin_delay_corner\
   	-library_set 	fast_library_set\
   	-opcond_library u055lsclpmvbdr_132c-40_bc\
   	-opcond 	    u055lsclpmvbdr_132c-40_bc\
   	-rc_corner 	    fast_Cmin_rc_corner
#####################################################
# typical case analysis
#####################################################
set typical_memory_libs [exec find $mem_dir -name *tt*1p2v25*.lib]
set typical_standard_libs [list \
   	/workspace/technology/umc/55nm_201908/SC/functional_lib/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055LSCLPMVBDR-LIBRARY_TAPE_OUT_KIT-Ver.B01_P.B/synopsys/u055lsclpmvbdr_120c25_tc.lib\
    /workspace/technology/umc/55nm_201908/SC/functional_lib/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055LSCLPMVBDL-LIBRARY_TAPE_OUT_KIT-Ver.A01_PB/synopsys/u055lsclpmvbdl_120c25_tc.lib\
    /workspace/technology/umc/55nm_201908/SC/functional_lib/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055LSCLPMVBDH-LIBRARY_TAPE_OUT_KIT-Ver.B01_P.B/synopsys/u055lsclpmvbdh_120c25_tc.lib\
  	/workspace/technology/umc/55nm_201908/IO/G-9LT-LOGIC_MIXED_MODE55N-LP_LOW_K_UM055GIOLP25MVIRFS-LIBRARY_TAPE_OUT_KIT-Ver.B06_PB/synopsys/u055giolp25mvirfs_330c25_tc.lib \
	${dll_lib} ]

set typical_libs [concat $typical_memory_libs $typical_standard_libs]

create_library_set \
	-name 	typical_library_set\
   	-timing $typical_libs
   	
update_library_set \
	-name   typical_library_set\
	-si     $typical_libs	

create_rc_corner -name typical_rc_corner\
   	-preRoute_res 1\
   	-postRoute_res 1\
   	-preRoute_cap 1\
   	-postRoute_cap 1\
   	-postRoute_xcap 1\
   	-preRoute_clkres 0\
   	-preRoute_clkcap 0\
   	-T 25\
   	-qx_tech_file ${qrc_dir}/Typ/qrcTechFile

create_delay_corner \
	-name 		    typical_delay_corner\
   	-library_set 	typical_library_set\
   	-opcond_library u055lsclpmvbdr_120c25_tc\
   	-opcond 	    u055lsclpmvbdr_120c25_tc\
   	-rc_corner 	    typical_rc_corner

#####################################################
# ocv corner
#####################################################
#Normally, use one library for ovc analysis instead of max and min libraries, the following ocv_delay_corner is too pessimistic
create_delay_corner \
	-name 			        ocv_delay_corner\
   	-early_library_set 	    fast_library_set\
   	-late_library_set 	    slow_library_set \
   	-early_opcond_library 	u055lsclpmvbdr_132c-40_bc\
   	-late_opcond_library 	u055lsclpmvbdr_108c125_wc \
   	-early_opcond 		    u055lsclpmvbdr_132c-40_bc\
   	-late_opcond 		    u055lsclpmvbdr_108c125_wc \
   	-rc_corner 		        slow_Cmax_rc_corner

#####################################################
# SDC
#####################################################
create_constraint_mode \
	-name 		default_constraint_mode \
   	-sdc_files  $sdc_file
   	
#####################################################
# create analysis view
#####################################################
create_analysis_view -name slow_RCmax_view      -constraint_mode default_constraint_mode -delay_corner slow_RCmax_delay_corner
create_analysis_view -name slow_Cmax_view       -constraint_mode default_constraint_mode -delay_corner slow_Cmax_delay_corner
create_analysis_view -name slow_40_RCmax_view   -constraint_mode default_constraint_mode -delay_corner slow_40_RCmax_delay_corner
create_analysis_view -name slow_40_Cmax_view    -constraint_mode default_constraint_mode -delay_corner slow_40_Cmax_delay_corner
create_analysis_view -name typical_view         -constraint_mode default_constraint_mode -delay_corner typical_delay_corner
create_analysis_view -name fast_RCmin_view      -constraint_mode default_constraint_mode -delay_corner fast_RCmin_delay_corner
create_analysis_view -name fast_Cmin_view       -constraint_mode default_constraint_mode -delay_corner fast_Cmin_delay_corner
create_analysis_view -name ocv_view             -constraint_mode default_constraint_mode -delay_corner ocv_delay_corner

#####################################################
# set analysis view
#####################################################
# to reduce runtime, only two analysis views are activated
# WC_BC analysis mode
set_analysis_view -setup slow_Cmax_view -hold fast_Cmin_view

# during signoff phse, activate all corners
#set_analysis_view \
    -setup [list typical_view  slow_Cmax_view slow_RCmax_view fast_RCmin_view fast_Cmin_view] \
    -hold  [list typical_view  slow_Cmax_view slow_RCmax_view fast_RCmin_view fast_Cmin_view]
