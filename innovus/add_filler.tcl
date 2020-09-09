#add filler
#
setFillerMode -add_fillers_with_drc false
addFiller -cell {FILE64UM FILE32UM FILE16UM FILE8UM FILE4UM} -prefix FILE -fitGap
addFiller -cell {FIL32TM FIL16TM FIL8TM FIL4TM FIL2TM FIL1TM} -prefix FILL -doDRC -fitGap


ecoRoute

saveDesign DB/add_filler.enc
