# classification on Titanic dataset
# http://will-stanton.com/machine-learning-with-r-an-irresponsibly-fast-tutorial/
# installed caret, randomForest, fields
# download data from Kaggle, download train.csv and test.csv

setwd("~/Desktop/Titianic")
trainSet <- read.table("train.csv", sep = ",", header = TRUE)
testSet <- read.table("test.csv", rep = ",", header = TRUE)

head(trainSet) #view data
head(testSet)
# training set is labeled with "survived" variable (1 or 0), test set is not

# which are the best variables to use to predict who survived?
# try crosstabs and conditional box plots

# crosstabs show interactions between two variables
# look at crosstabs between "Survived" and each other variable

table(trainSet[,c("Survived", "Pclass")])
#              Pclass
# Survived     1    2    3     
#    0         80   97   372
#    1         136  87   119

# Of of the passengers in Class 1, 136 survived and 80 died (63% survived), etc.
# repeat crosstabs for other variables

# plots are more useful for continuous variables
# use conditional boxplots

# comparing age and survival
library(fields)
bplot.xy(trainSet$Survived, trainSet$Age)
# box plots for age and survival are nearly the same

summary(trainSet$Age)
# returns min, 1st qu., median, mean, 3rd qu., max, number of NA's

# compare survival rate and fare
bplot.xy(trainSet$Survived, trainSet$Fare)
# shows a difference in survival by fare

## Training a model

# convert "Survived" to a Factor data type so that caret builds a classification instead of regression model
# use train command to train model
# random Forest = decision trees, often work well in many situations 

# convert "Survived" to a Factor
trainSet$Survived <- factor(trainSet$Survived)
# set a random seed to get same answer as tutorial
set.seed(42)
# train model using random forest
model <- train(Survived ~ Pclass + Sec + SibSp +
                    Embarked + Parch + Fare, # Survived is a function of selected variables
               
               data = trainSet # use trainSet data for training data
               method = "rf", # use random forest algorithm
               trControl = trainControl(method = "cv", # use cross-valudation
                                        number = 5) # use 5 folds for cross-validation
)

# we will use cross-validation to evaluate our model
# most people split the training set further into a training set and validation set

# Typically, you randomly split the training data into 5 equally sized pieces called “folds”
# (so each piece of the data contains 20% of the training data). Then, you train the model 
# on 4/5 of the data, and check its accuracy on the 1/5 of the data you left out. You then 
# repeat this process with each split of the data. At the end, you average the percentage 
# accuracy across the five different splits of the data to get an average accuracy. Caret 
# does this for you, and you can see the scores by looking at the model output:

model

# 891 samples
#  11 predictor
#   2 classes: '0', '1' 
# 
# No pre-processing
# Resampling: Cross-Validated (5 fold) 
# 
# Summary of sample sizes: 712, 713, 714, 713, 712 
# 
# Resampling results across tuning parameters:
# 
#   mtry  Accuracy   Kappa      Accuracy SD  Kappa SD  
#   2     0.8103230  0.5784801  0.03358637   0.07818032
#   5     0.8170964  0.6039000  0.02113867   0.04573844
#   8     0.8081011  0.5883009  0.02301564   0.05210970
# 
# Accuracy was used to select the optimal model using  the largest value.
# The final value used for the model was mtry = 5.

# mtry is a hyperparameter that determines how man yvariables the model uses to split the trees
# our model should be about 82% accurate on the test dataset, assuming they're not too different

testSet$Survived <- predict(model, newdata = testSet)
# returns an error - there is missing data somewhere we need to find
summary(testSet)
# there is an NA values in Fare - let's fill/impute that with the mean Fare value
# if there is an NA in FARE, replace it with the mean, and remove NA's when taking the mean
testSet$Fare <-ifelse(is.na(testSet$Fare), mean(testSet$Fare, na.rm=TRUE), testSet$Fare)

# try predicting again
testSet$Survived <- predict(model, newdata = testSet)
submission <- testSet[, c("PassengerID", "Survived")]
write.table(submission, file = "submission.csv", col.names = TRUE, row.names = FALSE, sep = ",")

# upload submission to Kaggle
