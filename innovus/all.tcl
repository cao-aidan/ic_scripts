#optDesign -preCTS -outDir ./timingReports/place_opt/
#saveDesign ./DB/placement_opt.enc

source ./script/placement.tcl

source ./script/cts.tcl
source ./script/route.tcl
source ./script/signoff.tcl

#report_timing -from inst_top_asyncFIFO_wr_fifo_async/dout_reg[16]/Q  -to IO_spi_data_wr0_pad[16] -unconstrained
