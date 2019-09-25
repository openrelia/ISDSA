# This data was contributed by a WeibullR user in exactly the two csv files as used here.
# Since WeibullR is viewed as a first experience with R for many users, the example of 
# data wrangling to place this extensive data into a time/event/quantity dataframe may prove instructive.

# The generation of the contour plot on this data was considerably challenging until log-transforms were
# used on the beta and eta values and the points on the plot were obtained using polar coordinates.

daf<-read.csv("https://raw.githubusercontent.com/openrelia/WeibullR.gallery/master/data/contour_challenge/daTEST.csv", header=FALSE)
das<-read.csv("https://raw.githubusercontent.com/openrelia/WeibullR.gallery/master/data/contour_challenge/dasuspendedTEST.csv", header=FALSE)

fdf<-as.data.frame(table(daf[,1]))
ft<-as.numeric(levels(fdf[,1]))
fq<-fdf[,2]
sdf<-as.data.frame(table(das[,1]))
st<-as.numeric(levels(sdf[,1]))
sq<-sdf[,2]
fail_edata<-data.frame(time=ft, event=rep(1,length(ft)), qty=fq)
sus_edata<-data.frame(time=st, event=rep(0, length(st)), qty=sq)
teq_frame<-rbind(fail_edata, sus_edata)
teq_frame

# The objective of this script was to  demonstrate the nature of accuracy of the simple weibayes function, 
# that has no likelihood calculation at all, to the comprehensive likelihood contour calculations.

# Plotting points onto a generated wblr object plot and use of R's legend function to annotate
# provide new R users with additional insight as to R capabilities.

require(WeibullR)
contour.wblr(wblr(teq_frame,
main.contour="Comparing the Simple Weibayes Function to a Challenging MLE Contour"),
col="lightblue"
)

# simple weibayes function	
beta_range<-seq(2.5, 7, by=0.5)	
wbpts<-NULL	
for(b in beta_range)  {	
	eta<-weibayes(teq_frame, beta=b)
	this_pt<-c(eta, b)
	wbpts<-rbind(wbpts, this_pt)
}	
	
points(wbpts, pch=8, col="red")	
legend(10000,7, legend="Weibayes points\n tracking the ridge of the mle contour",
bg="lemonchiffon",col="red", pch=8, text.font=2)