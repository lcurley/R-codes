# scatterplots

# basic plot
plot(x,y)
plot(x, y, main="Title", xlab = "x axis name", ylab="y axis name")

# add fit lines
abline(lm(y~x), col="red") # regression line (y~x)
lines(lowess(x,y), col="blue") # lowess line (x,y)

library(car)
scatterplot(y ~ x | z, data=mydata, xlab="lable", ylab="label", main="Title", labels=row.names(mydata))

# Basic Scatterplot Matrix
pairs(~mpg+disp+drat+wt,data=mtcars, 
      main="Simple Scatterplot Matrix")

# Scatterplot Matrices from the car Package
library(car)
scatterplot.matrix(~mpg+disp+drat+wt|cyl, data=mtcars,
                   main="Three Cylinder Options")

# Scatterplot Matrices from the lattice Package 
# scale on a factor
library(lattice)
splom(mtcars[c(1,3,5,6)], groups=cyl, data=mtcars,
      panel=panel.superpose, 
      key=list(title="Three Cylinder Options",
               columns=3,
               points=list(pch=super.sym$pch[1:3],
                           col=super.sym$col[1:3]),
               text=list(c("4 Cylinder","6 Cylinder","8 Cylinder"))))


# Scatterplot Matrices from the glus Package 
library(gclus)
dta <- mtcars[c(1,3,5,6)] # get data 
dta.r <- abs(cor(dta)) # get correlations
dta.col <- dmat.color(dta.r) # get colors
# reorder variables so those with highest correlation
# are closest to the diagonal
dta.o <- order.single(dta.r) 
cpairs(dta, dta.o, panel.colors=dta.col, gap=.5,
       main="Variables Ordered and Colored by Correlation" )
