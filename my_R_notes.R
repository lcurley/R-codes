# make a function

myfunction <- function(x) {
     y <- rnorm(100)
     mean(y)
}

# make another function and print the result

second <- function(z) {
     x + rnorm(length(z))
}

print (z)

# get integers 1 to 20
y <- 1:20

# numbers are generally numeric
# if you want a number to be an integer, you have to add the suffix "L"
# ex. 1 = numeric, 1L = integer

# Inf = infinity
# NaN = missing number

# making vectors of different types
# vectors can only contain one type of object
a <- c(0.5,0.6)
b <- c(T,F) # or c(TRUE, FALSE)
c <- c(1+0i, 2+4i)
d <- c("a","b", "c")
e <- 9:27

# when you mix objects in a vector, coercion occurs so all elements are the same class
y <- c(1.7, "a") # character
y <- c(TRUE,2) # numeric
y <- c("a", TRUE) # character

# explicit coercion using as.numeric(), as.logical(), etc.
x <- 0:6 # integer
as.numeric(x) 
as.character(x)
# when coercion doesn't work you get a vector of "NA" and a warning

# lists can contain objects of different classes
x <- list(1, "a", TRUE, 1 + 4i)
print(x)
# each element is printed as its own vector since they're of a different type

# matrices have a dimension attribute
m <- matrix(nrow=2, ncol=3)
print(m)
dim(m) # attributes(m) returns $dim

# matrices are constructed column-wise starting in the upper left hand corner (fill first column, second, etc.)
m <- matrix(1:6, nrow=2, ncol=3)
print(m)

# transform vector into matrix of 2 rows and 5 columns
m <- 1:10
dim(m) <- c(2,5)

# column and row binding
x <- 1:3
y <- 10:12
# bind into 2 columns, x is column 1 and y is column 2
cbind(x,y)
# bind into 2 rows, x is row 1 and y is row 2
rbind(x,y)

# factors represent categorical data
# can be unordered or ordered
# treated specially by modelling fucntions like lm() and glm()
# factors > integers because they are self-describing, i.e. male/ female is better than 1/2

x <- factor(c("yes", "yes", "no", "yes", "no"))
x # prints vector and levels (yes/no)
table(x) # shows levels and number of each underneath in table form

# can explicity define which is the base level, in this case "yes" is the baseline
x <- factor(c("yes", "yes", "no", "yes", "no"), levels = c("yes", "no"))

unclass(x)
# turns yes/no into 1/2

# is.na() ad is.nan() test for missing values
# NA values have a class, NaN value is also NA but does not have a class

x <- c(1, 2, NA, 10, 3)
is.na(x) # returns logical vector testing for NA's - third item is TRUE
y <- c(1, 2, NA, NaN, 4) # is.na() and is.nan() return specific logical vectors

# data frames
# store tablular data, special type of list where every element of the list has the same length
# can store different classes of objects in each column
# row.names attribute
# created by calling read.table() or read.csv()
# converted into matrix with data.matrix()

x <- data.frame(foo=1:4, bar = c(T,T,F,F))
nrow(x)
ncol(x)

# names of objects, for all R objects
x <- 1:3
names(x) <- c("a", "b", "c")

x<-list (a=1, b=2, c=3) # list with names of letters

m <- matrix(1:4, nrow=2, ncol=2) 
dimnames(m) <- list(c("a","b"), c("c", "d")) # matrix with names of letters

# reading and writing tabular data

# read.table/ write.table   for tabular data, separated by space
# read.csv/write.csv        for tabular data, separated by comma
# readLines                 for lines of a text file
# dget/dput       reading in R code files
# source/dump     reading in R code files
# load            reading in saved workspaces

data <- read.table("foo.txt")

# for larger datasets (if dataset larger than RAM on computer), stop
# telling data what type of data is in each column saves time, use colClasses argument and set nrows

initial <- read.table("data.txt", nrows=100)
classes <- sapply(initial, class)
tabAll <- read.table("data.txt", 
                     colClasses = classes)

# textual formats
# dumping and dputing; edit-able and potentially recoverable (preserve metadata)
y <- data.frame(a=1, b="a")
dput(y)
dput(y, file="y.R")
new.y <- dget("y.R")

# pass names (x and y) and file name to store objects under into dump
x <- "foo"
y <- data.frame(a=1, b="a")
dump(c("x","y"), file= "data.R")
rm(x,y) # remove objects

# open saved file with data
source("data.R")

# interfacing, connecting to outside world, environment
# file, gzfile, url opens connection to different files, webpages

con <- gzfile("words.gz") # connections are useful for reading parts of the file
x <- readLines(con,10) # reading 10 lines of the compressed gz file

con <- url("http://www.jhsph.edu", "r")
x <- readLines(con)
head(x) # calls heading of webpage

# subsetting basics
# [ always returns an object of the same type as the original
# [[ is used to extrat a single element of a list or data frame
# $ is used to extract elements of a list or data frame by name

x <- c("a", "b", "c", "d", "e")
x[1]
x[2:4]
x[x>"a"] # returns all items in x greater than "a"
u <- x>"a" # returns a logical vector for every item of x, indicating whether it matches the criteria

# subsetting lists
x <- list(foo = 1:4, bar = 0.6)
x[1] # returns $foo and [1] 1 2 3 4
x[[1]] # returns [1] 1 2 3 4
x$bar # returns [1] 0.6
x[["bar"]] # same
x["bar"] # same

# single brackets = extract multiple elements of list

x <- list(a = list(10, 12, 14), b = c(3.14, 2.81))
x[[x(1, 3)]] # returns 14
x[[c(2,1)]] # returns 3.14

# subsetting matrices

x <- matrix(1:6, 2, 3)
# index with row, column
x[1, 2] # returns 3
x[2, 1] # returns 2
# indices can also be missing
x[1, ] # returns first row
x[, 2] # returns second column

x[1, 2, drop = FALSE] # overrides TRUE default, returns a 1 by 1 matrix with "3" inside
x[1, , drop = FALSE] # overrides TRUE default, returns 1 by 3 matrix with "1, 3, 5" inside

# partial matching

x <- list(aardvark = 1:5)
# $ looks for item that matches
x$a # returns [1] 1 2 3 4 5
x[["a"]] # returns NULL = needs an exact match
x[["a", exact = FALSE]] # returns [1] 1 2 3 4 5, overrides default exact match

# removing missing values (NA, NaN)

x <- c(1, 2, NA, 4, NA, 5)
bad <- is.na(x)
newdata = x[!bad] # returns new vector without NAs

y <- c("a", "b", NA, "d", NA, "f")
good <- complete.cases(x,y) # returns logical vector where both x and y have data
x[good] # returns only complete data from x where y also has data
y[good]

airquality[1:6, ] # show the first 6 rows
good <- complete.cases(airquality) # keep the complete rows
airquality[good, ][1:6, ] #show first 6 rows of filtered data

# vectorized operations

x <- 1:4; y <- 6:9
x + y # returns vector of length x and/or y
x > 2 # returns vector of logicals
y == 8 # returns vector of logicals
x * y # returns vector of length x and/or y
x/y #  returns vector of length x and/or y

x <- matrix(1:4,2,2); y<- matrix(rep(10,4),2,2)
x*y
x/y
x %*% y ## true matrix multiplication

# read in csv
data = read.csv("hw1_data.csv", header = TRUE)

# quiz 1

# headers = ozone, solar.R, wind, temp, month, day
# 153 rows, some NA data
# extract first 2 rows
data[1:2, ]
# find ozone in 47th row
data[47,1]
ncol(data)
nrow(data)
# how many missing ozone values?
ozone = data[ ,1]
bad_oz <- is.na(ozone)
sum(bad_oz) # returns number of TRUE values in bad_oz, the number of NA
good_oz <- ozone[!bad] # keep good data
mean(good_oz)
# subset of rows where ozone>31 and temp>90
# mean of solar.R in this subset?
sub <- subset(data, data[,1] > 31 & data[,4] . 90)
# what is the mean of temp when month = 6
subtm <- subset(data, data[,5] ==6)
mean(subtm[,4])
# what is the max ozone in may (month = 5)
subtm <- subset(data, data[,5] ==5)
newsubtm <- subtm[!is.na(subtm$Ozone), ] # remove NA from Ozone column
ozone <- newsubtm[,1]
max(ozone)


# control structures

# if/else - test a condition
# for - execute a loop a fixed number of times
# while - execute a loop while a condition is true
# repeat - execute an infinite loop
# break - break execution of a loop
# next - skip an iteration of a loop
# return - exit a function

if(<condition>) {
     ## do something
} else {
     ## do something else
}

if (x>3) {
     y <- 10
} else {
     y <-0
}

y <- if(x>3){
     10
} else {
     0
}

# for loops
for(i in 1:10) {
     print(i)
}

# the 4 following loops are equialent
x <- c("a", "b", "c", "d")

for(i in 1:4) {
     print(x[i])
}

for(i in seq_along(x)){
     print(x[i])
}

for(letter in x){
     print (letter)
}

for(i in 1:4) print (x[i]) # if the loop has a single statement, you can put it on one line


# nested for loops

x <- matrix(1:6, 2, 3)

for (i in seq_len(nrow(x))){
     for(j in seq_len(ncol(x))) {
          print(x[i, j]) # prints each element of the matrix
     }
}

# while loops

count <- 0
while(count < 10) {
     print(count)
     count <- count +1
}

z <- 5
while(z >=3 && z<=10) {
     print(z)
     coin <- rbinom(1,1,0.5) ## fair coin flip
     
     if(coin == 1) { ## random walk
          z <- z+1
     } else {
          z <- z-1
     }
}

# repeat, next, break
# repeat initates an infinite loop, break is the only thing that can end it

x0 <- 1
tol <- 1e-8
# format used often in optimization problems
# usually better to set a hard limit of iterations

repeat {
     x1 <- computesomeEstimate()
     
     if(abs(x1-x0) < tol){
          break
     } else {
          x0 <- x1
     }
}

for(i in 1:100) {
     if(i <= 20) {
          ## skip first 20 iterations
          next
     }
     ## do something else here
}

# functions
add2 <- function (x,y){
     x+y
} # function returns whatever the last expression is

above10 <- function(x){ #input vector x
     use <- x > 10 # logical vector of TRUE/FALSE with items greater than 10
     x[use] # subset those items greater than 10
}

aboveNum <- function(x,n){ 
     use <- x > n # specificy minimum value n
     x[use]
}

# set default n to 10 but it can be specified
aboveNum <- function(x,n=10){ 
     use <- x > n # specificy minimum value n
     x[use]
}

colmean <- function(x, removeNA=TRUE){ # default to remove NA values
     #y is a dataframe or matrix
     nc <- ncol(x)
     means <- numeric(nc) # intialize empty vector
     for(i in 1:nc) {
          means[i] <- mean(x[i], na.rm=removeNA)
     }
     means # output returned
}

# colmean(airquality)
# colmean(airquality, FALSE)

mydata <- rnorm(100)
# the following 3 commands are equivalent, na.rm default is FALSE
# arguments can be matched by name or position
sd(mydata)
sd(x=mydata)
sd(x=mydata, na.rm=FALSE)

args(lm)
# no defaults for first 5 arguments = need to be specified

# function (formula, data, subset, weights, na.action, method = "qr", 
# model = TRUE, x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE, 
# contrasts = NULL, offset, ...) 
# NULL

# equivalent examples
lm(data=mydata, y-x, model=FALSE, 1:100)
lm(y-x, mydata, 1:100, model=FALSE)
# specifying arguments by name is better/safer

f <- function (a, b=1, c=2, d=NULL) {
     # b, c, and d have defaults specified
}

f <- function(a,b) {
     a^2
}
f(2) # b is never used, 2 is positionally matched to 'a'

f <- function(a,b) {
     print(a)
     print(b)
}
f(45) # prints 45, then gives error that b is missing

# ...
# default plot has many arguements; when you put in '...' 
# it absorbs the other arguments in the plot function
# used when extending other functions - adapting 'plot' with 'myplot'
myplot <- function(x, y, type="1", ...) {
     plot(x, y, type=type, ...)
}
# ... used in generic functions and when num arguments are not known in advance
# examples below
args(paste)
args(cat)
# always need to explicity name arguments after the '...'

paste("a", "b", sep=":") # prints a:b
paste("a", "b" se=":") # prints a b :

# functions inside functions
make.power <- function(n){
     pow <- function(x){
          x^n
     }
     pow
}

cube <-make.power(3)
square <- make.power(2)
cube(3) # returns 27
square(3) # returns 9

# look an envr a function was defined in by calling ls(environment(cube))
# get("n", environment(cube)) returns "3"

# dynamic functions
y <- 10
f <- function(x) {
     y <- 2
     y^2 + g(x)
}

g <- function(x) {
     x*y
}

f(3) # with lexical scoping in the global envr y = 10, with dynamic scoping y = 2
# when function defined in globa envr and called from the global envr, they are the same

# dates and times

# dates are represented by the DATE class
# times are represented by the POSIXct or POSIXlt class
# stored as date/time since 1970-01-01

x <- as.Date("1970-01-01") # prints looking like a string
unclass(x) # returns 0 since its 0 days from baseline
unclass(as.Date("1970-01-02")) # returns 1 since its 1 day after baseline

# POSIXct is a large integer, good for data frame
# POSIClt is a list, stores info like week, day of year, month, day of the month, etc.

x <- Sys.time() # returns "2013-01-24 22:04:14 EST" or whatever the day/time is
p <- as.POSIXlt(x) # converts format
names(unclass(p)) # lists subset of date info stored
p$sec # call the seconds from p
unclass(x) # converts to larger integer, from baseline

# you can compare dates to see if they match but can't mix types
# plotting functions usually recognize dates

# loop functions
# lappy, sapply, apply, tapply, mapply

# lappy takes 3 arguments; a list, function, and other arguments
x <- list(a = 1:5, b = rnorm(10))
lapply(x,mean)
# lapply always returns a list regardless of the class input

x <- 1:4
lapply(x, runif) # runif is the function input
lapply(x, runif, min=0, max=10) # specify function arguments

x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
lapply(x, function(elt) elt[,1]) # write function that takes first column
# anonymous function inside lapply (elt), fined in lapply and has no name

# sapply is a variant of lapply but tries to simplify the result
# can return a vector or matrix rather than a list
x <- list(a=1:4, b=rnorm(10), c=rnorm(20,1), d=rnorm(100,5))
sapply(x, mean)
# returns vector with 4 values rather than a list with 4 elements

# nested functions

f <- function(x){
     g <- function(y){
          y + z
     }
     z <- 4
     x + g(x)
}

# if I run this:
z <-10
f(3)
# it returns 10

# loop functions; apply
# used to apply a function to rows or columns of a matrix
# input argumebts; an array, margins, functions and other arguments

str(apply)
x <- matrix(rnorm(200), 20 ,10)
apply(x, 2, mean) # returns mean of each column (10 values)
apply(x, 1, sum) # returns sum across rows (20 values)

# shortcuts (below) are faster for large matrices

# rowSums = apply(x, 1, sum)
# rowMeans = apply(x, 1, mean)
# colSums = apply(x, 2, sum)
# colMeans = apply(x, 2, mean)

x <- matrix(rnorm(200), 20, 10)
apply(x, 1, quantile, probs = c(0.25, 0.75)) # calculate quantiles, which needs quantile arguements
# returns matrix with 2 values for each if the 20 rows, 25th and 75th quantile

a <- array(rnorm(2 * 2 * 10), c(2, 2, 10))
apply(a, c(1,2), mean)
rowMeans(a, dims = 2)

# loop functions; mapply

str(mapply)
# multivariate apply which applies a function in parallel over a set of arguments

list(rep(1,4), rep(2,3), rep(3,2), rep(4,1))
# shortcut:
mapply(rep, 1:4, 4:1)

# create noise
noise <- function(n, mean, sd){
     rnorm(n, mean, sd)
}

noise(5,1,2)
noise(1:5, 1:5, 2)
# doesn't work with vectors as input
# instead:
mapply(noise, 1:5, 1:5, 2)

# loop functions; tapply

str(tapply)
# input vector, index, function, etc.

x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
tapply(x, f, mean) # default simplify = TRUE, returns 3 numeric values
tapply(x, f, mean, simplify = FALSE) # returns a list of 3 elements

# loop functions; split
str(split)
# takes vector or object x, takes a factor/level variable, splits x into levels based on factor
# apply some function, put the pieces back together into x

x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
split(x, f) # returns a list

lapply(split(x, f), mean) # returns 3 values in a list, same as using tapply

library(datasets)
head(airquality)
# split data frame into months

s <- split(airquality, airquality$Month) # split by month
# apply anonymous function, colMeans of three variables for each mont
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")])) # returns list
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")])) # returns matrix

# remove missing values
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = TRUE)) 

# split on more than one level
x <- rnorm(10) # 10 random numbers
f1 <- gl(2, 5) # factor 1
f2 <- gl(5, 2) # factor 2

str(split(x, list(f1, f2))) # returns list of 10 level interaction factors
# empty levels can be dropped
str(split(x, list(f1,f2), drop=TRUE))

## debugging tools
traceback # prints function call stack after an error
recover # browse function and call stack
debug # step through line by line
browser # suspends execution of function and puts it in debug mode
trace # insert debugging code into specific places

library(datasets)
data(mtcars)
head(mtcars)

# calculate average mpg by number of cylinders
sapply(split(mtcars$mpg, mtcars$cyl), mean)



