##power plan
##power ring 
ddRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -center 1 -stacked_via_top_layer AL_RDL -type core_rings -jog_distance 0.1 -threshold 0.1 -nets {VDD VSS} -follow core -stacked_via_bottom_layer ME1 -layer {bottom ME7 top ME7 right ME6 left ME6} -width 12 -spacing 2 -offset 0.1
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -center 1 -stacked_via_top_layer AL_RDL -type core_rings -jog_distance 0.1 -threshold 0.1 -nets {VDD VSS} -follow core -stacked_via_bottom_layer ME1 -layer {bottom ME5 top ME5 right ME4 left ME4} -width 12 -spacing 2 -offset 0.1
##block pin
sroute -connect { blockPin padPin padRing } -layerChangeRange { ME3 ME5 } -blockPinTarget { nearestTarget } -connectAlignedBlockAndPadPin { padPinAsTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -allowJogging 1 -crossoverViaLayerRange { ME1 AL_RDL } -allowLayerChange 1 -nets { VDDA VSSA } -blockPin useLef -targetViaLayerRange { ME1 AL_RDL }
sroute -connect { padPin padRing } -layerChangeRange { ME1 ME7 } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -allowJogging 1 -crossoverViaLayerRange { ME1 AL_RDL } -allowLayerChange 1 -nets { VDD VSS } -targetViaLayerRange { ME1 AL_RDL }
##power stripe


#floowpins
sroute -connect { corePin } -layerChangeRange { ME1 ME7 } -blockPinTarget { nearestTarget } -corePinTarget { stripe } -allowJogging 1 -crossoverViaLayerRange { ME1 AL_RDL } -allowLayerChange 1 -nets { VDD VSS } -targetViaLayerRange { ME1 AL_RDL }

