## This script requires WeibullR development version 1.0.11.7
## It implements a developmental function LRbounds3pw that is not intended to be supported in future.
## It is expected that the functionality will be incorporated in LRbounds with an npar argument of 3.
## It is uncertain how limitation of tz points will be established over the long term.

## The w2test data set was prepared randomly and used in some of the earliest development
## of WeibullR and its precursor abrem. It became a test set of particular interest during 
## development of confidence  bounds for 3-parameter models.

 w2test<-c(40.57903, 51.5263, 54.01269, 90.70031, 110.56461,		
            117.86191, 137.16324, 147.69461, 160.77858, 187.4198)		
require(WeibullR)
  LRbounds3pw(w2test, tzpoints=c(10,100,10), show=c(T,T))
 