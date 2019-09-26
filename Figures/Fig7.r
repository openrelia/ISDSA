
## This script requires WeibullR version 1.0.11.7
## It implements a developmental function LRbounds3pw that is not intended to be supported in future.
## It is expected that the functionality will be incorporated in LRbounds with an npar argument of 3.
## It is uncertain how limitation of negative tz point candidates will be established over the long term.

## The w2test data set was prepared randomly and used in some of the earliest development
## of WeibullR and its precursor abrem. It became a test set of particular interest during 
## development of confidence  bounds for 3-parameter models.

 w2test<-c(40.57903, 51.5263, 54.01269, 90.70031, 110.56461,		
            117.86191, 137.16324, 147.69461, 160.77858, 187.4198)		
require(WeibullR)
LRbounds3pw(w2test, tzpoints=c(10,100,10), show=c(T,F))

## This is as far as current WeibullR code can take us. The bounds are
## calculated below by technical code that has not yet been incorporated
## into WeibullR.  Look for a version 1.1 to be released on CRAN

## set data,confidence and fit parameters in terms of Gelissen's code		
time<-w2test		
event<-rep(1, length(w2test))		
##fit<-xfit(obj)$fit
fit<-mlefit(mleframe(w2test), npar=3)		
mu<-log(fit[1])             # log(Eta)		
sigma<-1/fit[2]             # 1/Beta		
gamma<-xfit(obj)$fit[3]  	# t0		
## confidence interval fixed here at 95%		
alpha<-1-.95		
		
## smallest extreme value functions used from package SPREDA		
spreda.dsev<-function (z) {    exp(z - exp(z))}		
spreda.psev<-function (z) {    1 - exp(-exp(z))}		
spreda.qsev<-function (p)   {		
	p = ifelse(p >= 0.99999999999999, 0.99999999999999, p)	
	p = ifelse(p <= 1 - 0.99999999999999, 1 - 0.99999999999999, p)	
	log(-log(1 - p))	
}		
		
## The code below is adapted from a blog by Stefan Gelissen	(Corrections applied at lines 71 and 72 below.)	
## http://blogs2.datall-analyse.nl/2016/02/17/rcode_three_parameter_weibull/		
		
## a log likelihood function for 3p weibull		
llikweibull <- function (theta, y, d) {		
  mu <- theta[1]		
  sigma <- theta[2]		
  gamma <- theta[3]		
  subset <- y-gamma>0		
  ys <- y[subset]		
  ds <- d[subset]		
  sum(log((( 1/(sigma*(ys-gamma)) * spreda.dsev( ((log(ys-gamma)-mu)/sigma) )) ^ds)*		
            ( (1-spreda.psev( ((log(ys-gamma)-mu)/sigma) )) ^(1-ds) )))		
}		
## get the hessian using optim with seed parameters pre-optimized by mlefit
hessian<-optimHess(c(mu, sigma, gamma), llikweibull,		
           control=list(fnscale=-1), y=time, d=event)		
		
#predict quantiles (including normal-approximation confidence intervals)		
weibullQp <- function (vcov, mu, sigma, gamma, p, alpha=.05){		
  Qp <- as.vector(exp(mu + spreda.qsev(p)*sigma) + gamma)		
  #take partial derivatives of the function q=exp(mu+qsev(p)*sigma)+gamma		
  dq.dmu <- exp(mu+spreda.qsev(p)*sigma) #with respect to mu		
  dq.dsigma <- spreda.qsev(p)*exp(mu+spreda.qsev(p)*sigma) #with respect to sigma		
  dq.dgamma <- 1 #with respect to gamma		
  dq.dtheta <- c(dq.dmu, dq.dsigma, dq.dgamma)		
		
  #delta method		
  seQ <- sqrt(t(dq.dtheta)%*%vcov%*%dq.dtheta)		
  #compute confidence interval		
	w<-exp((qnorm(1-alpha/2) * seQ) / Qp)	
	lcl<-Qp / w	
	ucl<- Qp * w	
  c(p=p, Quantile=Qp, std.err=seQ, lcl=lcl, ucl=ucl)		
}		
		
## these descriptive percentiles match Minitab unchangeable defaults		
dp=c(seq(.01,.09,by=.01),seq(.10,.90,by=.10),seq(.91,.99, by=.01))		
		
#predict quantiles at specified percentiles		
Qps <- data.frame(t(sapply(dp, weibullQp, vcov=solve(-1*hessian),		
                           mu=mu, sigma=sigma, gamma=gamma, alpha=alpha)))	

## add bound lines from weibullQp using same proportions as Minitab
lines(Qps$lcl-gamma,p2y(Qps$p), lwd=3, col="purple")
lines(Qps$ucl-gamma,p2y(Qps$p), lwd=3, col="purple")						   
