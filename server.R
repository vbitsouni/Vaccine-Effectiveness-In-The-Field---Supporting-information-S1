# Shiny server.R for TwoSIRmodel
# VBitsouni
# 30 Jan 2018

############################################################
# compile custom functions
# only run once, e.g. read in data files etc

source("helper.R")


results 				<- reactiveValues()
results$res			<- run_TwoSIR_model()
results$timeToPeakc 	<- 0
results$maxIn		<- 0
results$timeToPeakv <- 0
results$maxIv		<- 0

# default values
N  <- 1
p <- 1
I0  <-  0.001
epss <- 0.5
epsi <- 0.5
epsg <- 0.5 
betacc <- 0.12
gammac <- 0.01785 
lambdac <- 0.0017 
lambdav <- 0.0007 
mu <- 0.0017 
d <- 0.001
tmax <- 1000
tinc <- 0.5


############################################################
# SHINY server

shinyServer(function(input, output, session) {

	# this is compiled on launch
	# also for user session information
	
	observe({
		res <- run_TwoSIR_model(  N=input$N,  I0=input$I0, 
		                          epss=input$epss,epsi=input$epsi,p=input$p,epsg=input$epsg, betacc=input$betacc, gammac=input$gammac, 
		                          lambdac=input$lambdac, lambdav=input$lambdav, mu=input$mu, d=input$d, tinc=tinc, tmax=tmax)
		results$res 			<- res
		results$timeToPeakc 	<- getTimeOfPeakIn(res)
		results$maxIn 		<- round(getValueOfPeakIn(res))
		results$timeToPeakv <- getTimeOfPeakIv(res)
		results$maxIv 		<- round(getValueOfPeakIv(res))
		
	})
	
	output$SIRPlot <- renderPlot({ 

		# this is done every time the results change
		if (input$plotType=="SIR") {
        		plotSIR( results$res )
        } else {
        		plotI(results$res, strain=1, show.info=TRUE)
        		plotI(results$res, strain=2, add.to.plot=TRUE)
        }

     })
     

})