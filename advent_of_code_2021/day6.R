library(here)
library(tidyverse)

options(scipen = 999)

input_file_path <- paste0(here(), "/advent_of_code_2021/inputs/day6.csv")
input <- as.integer(str_split(read_lines(input_file_path), pattern = ",")[[1]])

##################
#### PART ONE ####
##################

lanternfish_growth <- function(x) {
    ifelse(x == 0, x <- 6, x <- x-1)
}
    
full_lanternfish_cycle <- function(vec) {
    #first we make babies
    babies <- rep(8, times = sum(vec == 0))
     
    #then we decrement the growth stage of existing lanternfish
    vec <- sapply(vec, FUN = lanternfish_growth)
    
    #finally, append the babies onto the vector of all lanternfish
    vec <- c(vec, babies)
}

lanternfish <- input
#hmmm not exactly sure how to do this without a for loop
for(i in 1:80) {
    lanternfish <- full_lanternfish_cycle(lanternfish)
}

p1 <- length(lanternfish)
p1



##################
#### PART TWO ####
##################

#just for fun I tried running my above loop and it went for 2 hours with no end in sight,
#so time to actually think this through like the organizers wanted me to :)

counts <- tabulate(input)
counts <- c(0, counts, 0, 0, 0) #add in placeholders for values of 0, 6, 7, and 8

#algo
for(i in 1:256) {
    babies <- counts[1] 
    counts <- c(counts[-1], babies) 
    counts[7] <- counts[7] + babies #reset ones that gave bith to 6 (which is position 7 since vector starts at 0)
}

p2 <- sum(counts)
p2
