#ocv timing derate
set_timing_derate -early 0.9 -late 1.0 -delay_corner slow_Cmax_delay_corner
set_timing_derate -early 1.0 -late 1.1 -delay_corner fast_Cmin_delay_corner
set_timing_derate -early 0.9 -late 1.0 -delay_corner slow_delay_corner
set_timing_derate -early 1.0 -late 1.1 -delay_corner fast_delay_corner
set_timing_derate -early 1.0 -late 1.0 -delay_corner typical_delay_corner
