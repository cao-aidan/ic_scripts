####################################################
# File Name : floorplan.tcl
# Function  : pre floorplan
# Created by: Xugang Cao
####################################################

# Global net connect
# VDD VSS VDDIO VSSIO VDDA VSSA (for PLL)

globalNetConnect VDDIO -type pgpin -pin VDDIO -inst * -all
globalNetConnect VSSIO -type pgpin -pin VSSIO -inst * -all

globalNetConnect VDDA -type pgpin -pin VDDA -inst * -all
globalNetConnect VSSA -type pgpin -pin VSSA -inst * -all

globalNetConnect VDD -type pgpin -pin VDD -inst * -all
globalNetConnect VSS -type pgpin -pin VSS -inst * -all
globalNetConnect VDD -type pgpin -pin VCC -inst * -all
globalNetConnect VSS -type pgpin -pin GND -inst * -all
globalNetConnect VDD -type tiehi -pin VDD -inst * -all
globalNetConnect VSS -type tielo -pin VSS -inst * -all

# Floorplan size
set die_width 4000.0
set die_height 4000.0
set core_to_io 32.0
set pad_height 88.8
floorPlan \
    -site CORE_7T \
    -b 	0.00 							    0.00 							    [expr $die_width] 	                            [expr $die_height] \
	    $pad_height 					    $pad_height						    [expr $die_width-$pad_height] 	                [expr $die_height-$pad_height] \
		[expr $pad_height+$core_to_io]      [expr $pad_height+$core_to_io]      [expr $die_width-$pad_height-$core_to_io] 		[expr $die_height-$pad_height-$core_to_io]

#loadIoFile ./backup/pulpino_top_io.save.io

# plan design
#setPlanDesignMode -fixPlacedMacros true -macroSpacing 2.8 -macroPaddingFactor 4
#planDesign

#end cap #welltap
addEndCap -preCap FILE4TM -postCap FILE4TM -prefix ENDCAP

addWellTap -cell WT3TM -cellInterval 60 -skipRow 1 -prefix WELLTAP
addWellTap -cell WT3TM -cellInterval 60 -inRowOffset 30 -startRowNum 2 -skipRow 1 -prefix WELLTAP

# ME8 blockage
createRouteBlk -box 0.0000 0.0000 4000.0000 4000.0000
selectRouteBlk -box 0.0000 0.0000 4000.0000 4000.0000 defLayerBlkName -layer 8


set die_width [dbget top.fplan.box_sizex]
set die_height [dbget top.fplan.box_sizey]
set pad_height 88.8
addInst -cell ICORNERFS -inst corner_lower_left  -loc 0                             0                               -ori R0
addInst -cell ICORNERFS -inst corner_lower_right -loc [expr $die_width-$pad_height] 0                               -ori R90
addInst -cell ICORNERFS -inst corner_top_right   -loc [expr $die_width-$pad_height] [expr $die_height-$pad_height]  -ori R180
addInst -cell ICORNERFS -inst corner_top_left    -loc  0                            [expr $die_height-$pad_height]  -ori R270
addIoFiller -cell IFILLER10FS IFILLER5FS IFILLER1FS IFILLER0FS

