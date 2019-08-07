# helper script for Shiny app SIRmodel
# VBitsouni
# 30 Jan 2018

library(deSolve)


###########################################################
# define TwoSIR for ODEs

TwoSIR	<- function(t, state, parameters) {
	with( as.list(c(state, parameters)),
		{
		  dSn<-  lambdac-betacc*Sn*In-(1-epsi)*betacc*Sn*Iv-mu*Sn
		  dSv<-  lambdav-(1-epss)*betacc*Sv*In-(1-epss)*(1-epsi)*betacc*Sv*Iv-mu*Sv
		  dIn<-  betacc*Sn*In +(1-epsi)*betacc*Sn*Iv-(gammac+d+mu)*In
		  dIv<-  (1-epss)*betacc*Sv*In +(1-epss)*(1-epsi)*betacc*Sv*Iv-(gammac/(1-epsg)+mu)*Iv
		  dRn<-  gammac*In-mu*Rn
		  dRv<-  gammac/(1-epsg)*Iv-mu*Rv
		  
		  #return the six derivatives in a list
		  list(c(dSn,dSv,dIn,dIv,dRn,dRv))            }
		
	)
}


run_TwoSIR_model <- function(N=1, I0=0.001,p=1, epss=0.5,epsi=0.5,epsg=0.5, betacc=0.12, gammac=0.01785, lambdac=0.0017, lambdav=0.0007, mu=0.0017, d=0.001, tinc=0.5, tmax=1000) {

	parameters <- c(epss=epss,epsi=epsi,p=p,epsg=epsg, betacc=betacc, gammac=gammac, lambdac=lambdac, lambdav=lambdav, mu=mu, d=d)
	state      <- c(Sn=(1-p)*(1-I0),Sv=p*(1-I0), In=(1-p)*I0,Iv=p*I0, Rn=0, Rv=0)
	times      <- seq(0, tmax, by = tinc)

	# run a model
	res <- ode(y = state, times = times, func = TwoSIR, parms = parameters)

	return( res )
}

###########################################################

getTimeOfPeakIn <- function( res ) {
	tc <- res[which.max(res[,4]),1]
	return( tc )
}

getValueOfPeakIn <- function( res ) {
	return( max(res[,4]))
}
###########################################################

getTimeOfPeakIv <- function( res ) {
	tv <- res[which.max(res[,5]),1]
	return( tv )
}

getValueOfPeakIv <- function( res ) {
	return( max(res[,5]))
}
###########################################################

plotSIR <- function( res ) {
	# plot model

	minVal <- 0
	maxVal <- max(res[,2:7]) + 1

	plot(res[,1], res[,2], type="l", ylim=c(minVal,maxVal), 
	     xlab="Time", ylab="Proportion", main="SIR Plot ", col="orange")
	lines(res[,1], res[,3], col="blue")
	lines(res[,1], res[,4], col="red")
	lines(res[,1], res[,5], col="black")
	lines(res[,1], res[,6], col="green")
	lines(res[,1], res[,7], col="magenta")
	
	
	legend("topright",c("Unvaccinated susceptible (Sn)","Vaccinated susceptible (Sv)","Unvaccinated infected (In)",
	                    "Vaccinated infected (Iv)","Unvaccinated recovered (Rn)","Vaccinated recovered (Rv)"),lty=1,col=c("orange","blue","red","black","green","magenta"),bty="n")
}

###########################################################


plotI <- function( res, maxVal=-1, strain=1,
				   add.to.plot=FALSE, show.info=FALSE,
					cols=c("red","blue"), colCount=1 )  {
	if (add.to.plot) {
		lines(res[,1], res[,3+strain], col=cols[strain])
	} else {
		if (maxVal < 0) {
			maxVal <- max(res[,4:5])
		}
		plot(res[,1], res[,3+strain], type="l", ylim=c(0,maxVal),
			xlab="Time", ylab="Proportion", main="Proportion of Infecteds", col=cols[strain])
	}
	
	if (show.info) {
		tc <- paste("Unvaccinated (In): t=",getTimeOfPeakIn(res),"max=", round(getValueOfPeakIn(res),digits = 2))
		tv <- paste("Vaccinated (Iv): t=",getTimeOfPeakIv(res),"max=", round(getValueOfPeakIv(res),digits = 2))
		legend("topright",c(tc,tv),lty=1,col=cols,bty="n")
	}
		
}
