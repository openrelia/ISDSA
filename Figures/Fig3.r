
# This data is from a trial of 42 leukaemia patients. Some were treated 
# with the drug 6-mercaptopurine and the rest are controls. The trial was 
# designed as matched pairs, both withdrawn from the trial when either 
# came out of remission.

# This data was published on CRAN in package MASS (one of the foundational
# contributed packages) supporting Venables and Ripley's 2002 book
# "Modern Applied Statistics with S". This dataset has been around for
# a long time. Sources include:
# Gehan, E.A. (1965) A generalized Wilcoxon test for comparing arbitrarily single-censored samples. Biometrika 52, 203–233
# Cox, D. R. and Oakes, D. (1984) Analysis of Survival Data. Chapman & Hall

control<-read.csv("https://raw.githubusercontent.com/openrelia/WeibullR.gallery/master/data/compare_6-MP/control.csv")
treat6mp<-read.csv("https://raw.githubusercontent.com/openrelia/WeibullR.gallery/master/data/compare_6-MP/treat6mp.csv")

# The intent of this script is to demonstrate generation of contour maps for multiple wblr objects on a single plot.

require(WeibullR)
obj1<-wblr(control, col="orange")
obj1<-wblr.fit(obj1, method.fit="mle-rba")
obj1<-wblr.conf(obj1, method.conf="lrb")

obj2<-wblr(treat6mp, col="purple")
obj2<-wblr.fit(obj2, method.fit="mle-rba")
obj2<-wblr.conf(obj2, method.conf="lrb")

contour.wblr(list(obj1,obj2))
mtext("Treatment with Drug 6-MP Improved Time in Remission\n\n")
text(10,1.9,"Control")
text(45,1.9,"6-MP Treated")