####################################################
# File Name : for_calibre_verify.tcl
# Function  : export GDS and verilog files for DRC&LVS in calibre
# Created by: Xugang Cao
####################################################

set output_dir ./for_calibre_verify

#streamOut
streamOut ${output_dir}/top.gds \
	-mapFile ./technology/map_file/streamout.map_file \
	-libName DesignLib \
	-uniquifyCellNames \
	-units 2000 \
	-mode ALL

#save netlist
saveNetlist -phys \
	-includePowerGround \
	-excludeLeafCell  \
	 ${output_dir}/top.v 


