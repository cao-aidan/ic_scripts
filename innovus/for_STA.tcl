saveNetlist ./STA/data_out/test.v -excludeLeafCell

writeTimingCon ./STA/data_out/test.sdc

setExtractRCMode -effortLevel signoff
setExtractRCMode -lefTechFileMap ./qrc/qrclayermap
extractRC
rcOut -spef ./STA/data_out/slow.spef -rc_corner slow_rc_corner
rcOut -spef ./STA/data_out/fast.spef -rc_corner fast_rc_corner
rcOut -spef ./STA/data_out/typical.spef -rc_corner typical_rc_corner

#write_sdf -edges check_edge -setuphold split ./data_out/pGlobal_PE.sdf

