# Shiny ui.R for SIRmodel
# VBitsouni
# 30 Jan 2018

shinyUI(fluidPage(

  titlePanel("Prophylactic mass vaccination"),

  sidebarLayout(
    sidebarPanel(
	helpText("Parameters for SIR Simulation"),
	
	radioButtons("plotType", "Plot Type:",
	  			   c("SIR" = "SIR", 
	  			     "I-only" = "Ionly"),
	  			     inline=TRUE),
		
	#	sliderInput("N",
	#	            "Total proportion of animals:",
	#	            min = 0,
	#	            max = 1,
	#	            value = 1, 
	#	            step = 0.0001),
	
	#	  sliderInput("initIc",
	#	  			  "Initial unvacc infecteds (I_n0):",
	#	  			  min=0,
	#	  			  max=1,
	#	  			  value=0, step=0.001),
	
	sliderInput("I0",
	            "Initially infecteds (I_0):",
	            min=0,
	            max=1,
	            value=0.001, step=0.001),
	
	sliderInput("p",
	            "Vaccine coverage (p):",
	            min=0,
	            max=1,
	            value=1, step=0.001),
	
	sliderInput("epss",
	            "Vaccine-induced sterilizing immunity (ε_s):",
	            min=0,
	            max=1,
	            value=0, step=0.001),
	
	sliderInput("epsi",
	            "Vaccine-induced reduction in host infectivity (ε_i):",
	            min=0,
	            max=1,
	            value=0, step=0.001),
	
	sliderInput("epsg",
	            "Vaccine-induced increase in recovery rate (ε_γ):",
	            min=0,
	            max=0.9999,
	            value=0, step=0.001),
	
	
	
	sliderInput("betacc",
	            "Transmission rate between unvaccinated animals (β_nn):",
	            min=0,
	            max=0.5,
	            value=0.12, step=0.001),
	
	#	  			  	sliderInput("betacv",
	#	  			  	            "β_NV (Transmission):",
	#	  			  	            min=0,
	#	  			  	            max=0.5,
	#	  			  	            value=0.12, step=0.001),
	
	sliderInput("gammac",
	            "Recovery rate of unvaccinated animals (γ_n):",
	            min = 0,
	            max = 0.2,
	            value = 0.01785,
	            step=0.001),
	
	#	  			  	sliderInput("gammav",
	#	  			  	            "γ_V (Recovery of vacc):",
	#	  			  	            min = 0,
	#	  			  	            max = 0.2,
	#	  			  	            value = 0.01785,
	#	  			  	            step=0.001),
	
	sliderInput("lambdac",
	            "Replacement rate of unvaccinated animals (λ_n):",
	            min = 0,
	            max = 0.0017,
	            value = 0,
	            step = 0.0001),
	
	sliderInput("lambdav",
	            "Replacement rate of vaccinated animals (λ_v):",
	            min = 0,
	            max = 0.0017,
	            value = 0.0017,
	            step = 0.0001),
	
	sliderInput("mu",
	            "Death rate (μ):",
	            min = 0,
	            max = 0.0017,
	            value = 0.0017,
	            step = 0.0001),
	
	sliderInput("d",
	            "Death rate due to disease (d):",
	            min = 0,
	            max = 0.005,
	            value = 0.001,
	            step = 0.0001),
	
	helpText("The initial conditions are:", 
	         br(),
	         "Sn(0)=(1-p)(1-I_0), In(0)=(1-p)I_0, Rn(0)=0,",
	         br(),
	         "Sv(0)=p(1-I_0), Iv(0)=pI_0, Rv(0)=0,",
	         br(),
	         "where I0>0 the total proportion of infecteds with the field pathogen.")
	
	
    ),




    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("SIRPlot")
    )

  )


))
