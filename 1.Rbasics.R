# clear console history 
# ctrl+L 

# clear variable 
rm("var") 
rm(list=ls()) #clears all vars from the env 

# identify where r is storing its packages
.libPaths() 

# load some common packages 
install.packages('pacman')

# use the following code to install as many packages as required at once
pacman::p_load(tidyverse,)

# set working directory 
setwd("~/desktop/thesis/8. RAW DATA")

# check current directory 
getwd()

# list the files in cd 
list.files()

ls() # shows data vars in R env. 

# getting help 
help() 
? function

# import data 
read.table("")
read.csv("")

# create data frame 
DRT_res <- c("0","0","1","0","3","0","0","2","0","3","0","1","0","1","0","2","0","0")

# rename variables 
names( Data )<- c(„ Name1 “ „ Name2 “)

# save data in a new variable, and read the first column as the heading 
data<-read.table("Data_seminar.txt", header = TRUE) 

# extract small portion of data in new variable 
newDataframe <- OldDataframe [rows, columns]
newDataframe <- subset( OldDataframe , cases to retain, select = 
                          c(list of variables))

# saving data 
write.csv()
write.table(dataframe , "Filename.txt", sep =" \ t", row.names=FALSE)

# lapply 
  # applies a function of every element in a df 

