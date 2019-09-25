# This is the data that was used to produce Figure 3.13 in Abernethy's "The New Weibull Handbook"
# There it was demonstrating a better lognormal fit than weibull, but when this multi-distribution
# plot was made surprisingly it was even better fit as a 3-parameter weibull.

# As far as we know this was just some random values.
	
F3.13da <- c(3.46623,3.732711,4.052996,4.628703,4.8157,5.84517,5.888313,5.892967,
       8.168362,10.02799,10.06062,10.49785,11.11493,11.87369,12.21122,12.51854,
	   12.91357,18.04246,18.20712,19.57305,21.20873,30.03917,34.88001,36.87355,53.91168)
	   
The objective of this script is to demonstrate multiple fits in a single wblr object.
	   
require(WeibullR)
my_object <- wblr(F3.13da)
my_object<- wblr.fit(my_object, dist="lognormal", col="magenta")
my_object<-wblr.fit(my_object, dist="weibull2p",  col="blue")
my_object<-wblr.fit(my_object, dist="weibull3p", col="red")
plot(my_object , main=("Multi-distribution Plot"))