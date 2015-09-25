# swirl notes and commands

getwd()
ls()
list.files()
args(list.files) # any operation name, returns arguments it takes
old.dir <- getwd()
dir.create("testdir")
setwd("testdir")
file.create("mytest.R")
file.exists("mytest.R")
file.info("mytest.R")
file.rename("mytest.R", "mytest2.R")
file.copy("mytest2.R", "mytest3.R")
file.path("mytest3.R")
dir.create("testdir2/testdir3", recursive = TRUE)
unlink("testdir2", recursive = TRUE)
setwd(old.dir)

?setwd # opens help documentation
?':'

1:20
15:1
seq(1,20)
seq(0,10,by=0.5)
my_seq <- seq(5,10,length=30)
length(my_seq)
1:length(my_seq)  # returns vector 1-30
seq(along.with = my_seq)  # returns vector 1-30
seq_along(my_seq) # returns vector 1-30
rep(0, times = 40)
rep(c(0,1,2), times=10)
rep(c(0,1,2), each=10)

num_vect <- c(0.5, 55, -10, 6)
tf <- num_vect <1
num_vect >= 6
# == for exact equality, != for inequality
# A | B to test if one is true
# A & B to test is both are true
# !A is the negation of A, TRUE when A is FALSE

my_char <- c("My", "name", "is")
paste(my_char, collapse = " ")
my_name <- c(my_char, "Lauren")
paste(my_name, collapse = " ")
paste("Hello", "world!", sep = " ")
paste(1:3, c("X","Y","Z"), sep = "")
# [1] "1X" "2Y" "3Z"
paste(LETTERS, 1:4, sep = "-") # LETTERS is predifined
#[1] "A-1" "B-2" "C-3" "D-4" "E-1" "F-2" "G-3" "H-4" "I-1" "J-2" "K-3" "L-4" "M-1" "N-2" "O-3" "P-4"
#[17] "Q-1" "R-2" "S-3" "T-4" "U-1" "V-2" "W-3" "X-4" "Y-1" "Z-2"


