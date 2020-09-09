mkdir -p ./for_post_sim
write_sdf -edges check_edge \
	-setuphold split \
	./for_post_sim/top.sdf


saveNetlist \
	 -excludeCellInst {WT3TM FILE64TM FILE32TM FILE16TM FILE8TM FILE4TM FIL32TM FIL16TM FIL8TM FIL4TM FIL2TM FIL1TM IFILLER10FS IFILLER5FS IFILLER1FS IFILLER0FS ICORNERFS} \
	 -excludeTopCellPGPort  {VDD VSS VDDIO VSSIO VDDA VSSA} \
	 -excludeLeafCell \
	 -topModuleFirst \
	 ./for_post_sim/top.v

