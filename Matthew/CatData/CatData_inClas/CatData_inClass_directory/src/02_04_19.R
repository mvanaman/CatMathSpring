setwd("~/Documents/Class/CatMathSpring/Matthew/CatData/CatData_inClas/CatData_inClass_directory")
library('ProjectTemplate')
load.project()

for (dataset in project.info$data)
{
  message(paste('Showing top 5 rows of', dataset))
  print(head(get(dataset)))
}

### 04/01/19
leaveclass <- as.data.frame(matrix(c(1,1,0,0,
                      1,0,1,0,
                      96,220,609,1060), 
                     ncol = 3, nrow = 4))
colnames(leaveclass) <- c("SFC", "IA", "Count")
(class_mod_log <- glm(SFC ~ IA, weights =  Count, leaveclass, family = binomial(link = "logit")))
(class_mod_prob <- glm(SFC ~ IA, weights =  Count, leaveclass, family = binomial(link = "probit")))
# note that the fit is not that different
logLik(class_mod_log)
logLik(class_mod_prob)

## elisa data
(summary(glm(hiv ~ mar, weights = count, elisa_test_roc, family = binomial())))
logLik((glm(hiv ~ mar, weights = count, elisa_test_roc, family = binomial())))

### 03/25/19
## beta blocker data
# poission
beta_long <- matrix(c(0,0,1,1,
                      0,1,1,0,
                      787,152,98,847),
                    nrow = 4, ncol = 3)
colnames(beta_long) <- c("trial", "death", "count")
beta_long <- as.data.frame(beta_long)
(beta_fit_poisson <- glm(count ~ trial *death , data =  beta_long, family = poisson(link="log")))

# run as bournoulli with counts as weights
(beta_fit_binom <- glm(death ~ trial, data = beta_long, weights = count, family = binomial(link="logit")))

## soccer data
soccer_rates <- cbind(soccer, as.data.frame(soccer$arrests / soccer$attendance))
# poisson
socc_poss <- summary(glm(arrests ~ log(attendance), soccer_rates, family = poisson(link = "log")))
# negative binomial
(socc_negbin <- summary(glm(arrests ~ attendance, soccer_rates, family = negative.binomial(theta = 1.75))))



### 03/18/19

fit_sal <- glm(observed ~ doseofquinoline + logd, data = salmonella.Sheet1, family = poisson(link = "log"))
fit_sal_sum <- summary(fit_sal)
fit_sal$
fit_sal_sum





################################################################################################################
#### 02/04/19
# Binomial Likelihood: Plots likelihood over varying values of p 
# for fixed y and n
p <- seq(.01:.99, by=.01)

#Unnormalized likelihood
ul10 <- (p^8) * ((1 - p)^(10-8)) * choose(10,8) 
ul1000 <- (p^800) * ((1 - p)^(1000-800)) * choose(1000,200)

#Normalize the likelihood with respect to the maximum value

nl10 <- ul10/max(ul10)                
nl1000 <- ul1000/max(ul1000)             


#Natural log of normalized likelihood---actually we'll look at -2*lognl 

lognl10 <- log(nl10)
lognl1000 <- log(nl1000)



#Now make plots: http://www.statmethods.net/advgraphs/layout.html

par(mfrow=c(2,2))        

plot(p,ul10,"l",xlab="p",ylab="ul(p)",main="Unnormalized Likelihood",lwd=2,col=2)       #unnormalized likelihood
lines(p,ul1000,"l",lty = 2,lwd=2,col=3)
abline(h = 0)
abline(v=0.8,lty=3)
leg = c("N = 10","N = 1000")
legend(0.05,0.3,legend=leg,lty=c(1,2),col=c(2,3))


plot(p,nl10,"l",xlab="p",ylab="nl(p)",main="Normalized Likelihood",lwd=2,col=2)       #normalized likelihood
lines(p,nl1000,"l",lty = 2,lwd=2,col=3)
abline(h = 0)
abline(v = 0.8,lty=3)
abline(h = 0.15,lty=3)


plot(p,-lognl,"l",xlab="p",ylab="lognl(p)",main="-2*log-Normalized Likelihood",lwd=2,col=2)    
lines(p,-lognl1000,"l",lty = 2,lwd=2,col=3)
abline(h = 0)
abline(v = 0.8, lty=3)
abline(h = -2*log(0.15),lty=3)


plot(p,-lognl,"l",xlab="p",ylab="-2*logL(p)",main="-2*log-L vs. Quadratic Approx.",lwd=2,col=2)     
lines(p,-lognl1000,"l",lty = 2,lwd=2,col=3)
lines(p,(10/(.8*.2))*(p - 0.8)^2,lwd=1,col=2,lty=5)
lines(p,(1000/(.8*.2))*(p - 0.8)^2,lwd=1,col=3,lty=5)
abline(h = 0)
abline(v = 0.8,lty=3)
abline(h = -2*log(0.15),lty=3)

#Big Trouble: A non-regular likelihood

l0of10 = (p^0) * ((1 - p)^(10)) * choose(10,0) 
logl0of10 = log(l0of10)

par(mfrow=c(1,2))        

plot(p,l0of10,"l",xlab="p",ylab="ul(p)",main="Unnormalized Likelihood",lwd=2,col=2, xlim = c(0,.5))       
abline(h = 0)
abline(h = 0.15,lty=3)

plot(p,-2*logl0of10,"l",xlab="p",ylab="ul(p)",main="Unnormalized Likelihood",lwd=2,col=2, xlim=c(0,.5),ylim=c(0,20))       
abline(h = 0)
abline(h = 3.84,lty=3)
abline(h = -2*log(0.15),lty=3)

#Transforming helps (or it can).

par(mfrow=c(1,2))

plot(log(p/(1-p)),nl10,"l",xlab="logit(p)",ylab="nl(p)",main="Normalized Likelihood",lwd=2,col=2, xlim=c(-5,5))       #normalized likelihood
lines(log(p/(1-p)),nl1000,"l",lty = 2,lwd=2,col=3)
abline(h = 0)
abline(v = 0.8,lty=3)
abline(h = 0.15,lty=3)

plot(log(p/(1-p)),-lognl10,"l",xlab="logit(p)",ylab="-2*logL(p)",main="-2*log-Normalized Likelihood",lwd=2,col=2, xlim=c(-5,5))     
lines(log(p/(1-p)),-lognl1000,"l",lty = 2,lwd=2,col=3)
abline(h = 0)
abline(v = 0.8,lty=3)
abline(h = -2*log(0.15),lty=3)


