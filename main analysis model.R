#############################################################################
#### The Overlooked Health Impacts of Extreme Rainfall Exposure in 32 East Asian cities
#### DLM. Main effects of extreme rainfall events with a 5-year return period as “r5” in the time series data
#### Cheng He, Jan. 2024
#### Fudan University & Helmholtz Zentrum Muenchen 
#############################################################################

library(mgcv)
library(rmeta)
library(dlnm)
library(splines)
library(mvmeta)
library(tidyverse)

#### 1. Read time-series data for the 32 cities
data_sample <- read.csv("data.csv")

#### 2. Restrict the dataset in warm season
data_sample <- subset(data_sample, month >= 5 & month <= 10)

#### 3. Restrict the dataset in citites matched extreme rianfall events during the study period (r5>0)
group_sum <- aggregate(data_sample$r5, by = list(data_sample$regnames), FUN = sum)
all_groups <- unique(data_sample$regnames)
zero_sum_groups <- setdiff(all_groups, group_sum$Group.1[group_sum$x > 0])
print(zero_sum_groups)
data_sample <- subset(data_sample, !(regnames %in% zero_sum_groups))

#### 4. Main analysis model
regions <- as.character(unique(data_sample$regnames))
data <- lapply(regions,function(x)
  data_sample[data_sample$regnames==x,])
names(data) <- regions
m <- length(regions)
ranges <- t(sapply(data, function(x)
  range(x$r5,na.rm=T)))
bound <- colMeans(ranges)
## 4.1 Build matrix to store coefficient and covariance
yall <- matrix(NA,length(data),1,dimnames=list(regions,paste("b",seq(1),sep="")))
yrain <- matrix(NA,length(data),4,dimnames=list(regions,paste("b",seq(4),sep="")))
Sall <- vector("list",length(data))
names(Sall) <- regions
Srain <- Sall
options(warn=-1)
## 4.2 Input parameters of main model
lag <- 14
lagnk <- 3
lagknots <- logknots(lag,df=4,int=T)
arglag <- list(fun="ns",knots=lagknots)
# Loop for cities
for(i in seq(data)) {
  sub <- data[[i]]
  cbr5 <- crossbasis(sub$r5,lag=lag,argvar=list(fun="lin"),arglag=arglag)
  vk <- equalknots(sub$tmean,fun="bs",df=4,degree=2)
  cbtemp <- crossbasis(sub$tmean,lag=lag,argvar=list(fun="bs",knots=vk,degree=2),
                       arglag=list(knots=logknots(lag,lagnk)))
  mfirst <- gam(death ~
                  cbr5+cbtemp+as.factor(dow)+as.factor(holiday)+ns(time,df=4*length(unique(sub$year))),family=quasipoisson(),sub)
  crall <- crossreduce(cbr5,mfirst)
  crrain <- crossreduce(cbr5,mfirst,type="var",value=1,cen=0)
  yall[i,] <- coef(crall)
  Sall[[i]] <- vcov(crall)
  yrain[i,] <- coef(crrain)
  Srain[[i]] <- vcov(crrain)
}
options(warn=0)

#### 5. Meta-analysis to pool the overall cumulative association and lag-response relationship
method <- "reml"
control=list(showiter=T)
## 5.1 Univariate meta-analysis to pool the overall cumulative association
mvall <- mvmeta(yall~1,S=Sall,method=method)
## 5.2 Multivariate meta-analysis to pool the lag-response relationship
mvrain <- mvmeta(yrain~1,Srain,method=method)

#### 6. Display estimated associations
xvar <- seq(bound[1],bound[2],by=1)
bvar <- do.call("onebasis",c(list(x=xvar),attr(cbr5,"argvar")))
xlag <- 0:14
blag <- do.call("onebasis",c(list(x=xlag),attr(cbr5,"arglag")))
cpall.cl1 <- crosspred(bvar,coef=coef(mvall),vcov=vcov(mvall),
                       model.link="log",by=1,from=bound[1],to=bound[2],cen=0)
cpcold.cl1 <- crosspred(blag,coef=coef(mvrain),vcov=vcov(mvrain),
                        model.link="log",at=0:140/10,cen=0)
## Display the RR estimate
round(with(cpall.cl1,cbind(allRRfit,allRRlow,allRRhigh)["1",]),3)


