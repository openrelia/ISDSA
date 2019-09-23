# The gears data for Figure 1 was obtained from the smithdat folder on SuperSMITH installation.
# This figure is only demonstrating the simplicity of producing a Quick Fit plot using WeibullR

gears<-c(4325.816,  6089.124,  6281.571,  6713.278,  7329.370,  
	7586.772,  7956.710, 7971.265,  8361.412,  9136.757,  9794.200,
	10939.030, 10942.620, 11090.460, 11329.730, 11635.250, 12160.140,
	13057.690, 14307.810, 15801.410)

require(WeibullR)
MRRln2p(gears,T,T)