#'Efficient estimator is the estimator that needs the less data and has the same properties
#'Sometimmes it is not necessary to use the entire dataset to estimate the effect
#'so you can save data
#'Montte Carlo: use computers to estimate e.g. an OLS
#'estimate y while setting beta yourself! then use simulated data and draw ranndom samples
#'then use another estimator and compare the results in terms of efficiency etc
#'(computation time) and compare the estimated beta to the real beta that you set before
#'inn the end we can estimate the intercept y
#'
#'Adding a big L behind something, tells are that the number is an integer and not
#'a flow number.
#'
## ------------------------------------------------------------------------
# read dataset into R
economics <- read.csv("../data/economics.csv")
# have a look at the data
head(economics, 2)
# create a 'large' dataset out of this
for (i in 1:3) {
     economics <- rbind(economics, economics)
}
dim(economics)


## ------------------------------------------------------------------------
# Naïve approach (ignorant of R)
deflator <- 1.05 # define deflator
# iterate through each observation
pce_real <- c()
n_obs <- length(economics$pce)
for (i in 1:n_obs) {
  pce_real <- c(pce_real, economics$pce[i]/deflator)
}

# look at the result
head(pce_real, 2)



## ------------------------------------------------------------------------
# Naïve approach (ignorant of R)
deflator <- 1.05 # define deflator
# iterate through each observation
pce_real <- list()
n_obs <- length(economics$pce)
time_elapsed <-
     system.time(
         for (i in 1:n_obs) {
              pce_real <- c(pce_real, economics$pce[i]/deflator)
})

time_elapsed


## ------------------------------------------------------------------------

time_per_row <- time_elapsed[3]/n_obs
time_per_row


## ------------------------------------------------------------------------
# in seconds
(time_per_row*100^4) 
# in minutes
(time_per_row*100^4)/60 
# in hours
(time_per_row*100^4)/60^2 


## ------------------------------------------------------------------------
# Improve memory allocation (still somewhat ignorant of R)
deflator <- 1.05 # define deflator
n_obs <- length(economics$pce)
# allocate memory beforehand
# Initiate the vector in the right size
pce_real <- rep(NA, n_obs)
# iterate through each observation
time_elapsed <-
     system.time(
         for (i in 1:n_obs) {
              pce_real[i] <- economics$pce[i]/deflator
})



## ------------------------------------------------------------------------

time_per_row <- time_elapsed[3]/n_obs
time_per_row


## ------------------------------------------------------------------------
# in seconds
(time_per_row*100^4) 
# in minutes
(time_per_row*100^4)/60 
# in hours
(time_per_row*100^4)/60^2 


## ------------------------------------------------------------------------
# Do it 'the R wqy'
deflator <- 1.05 # define deflator
# Exploit R's vectorization!
time_elapsed <- 
     system.time(
     pce_real <- economics$pce/deflator
          )
# same result
head(pce_real, 2)


## ------------------------------------------------------------------------

time_per_row <- time_elapsed[3]/n_obs

# in seconds
(time_per_row*100^4) 
# in minutes
(time_per_row*100^4)/60 
# in hours
(time_per_row*100^4)/60^2 


