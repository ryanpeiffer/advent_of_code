library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/advent_of_code_2021/inputs/day7.csv")
input <- as.integer(str_split(read_lines(input_file_path), pattern = ",")[[1]])

##################
#### PART ONE ####
##################

positions <- min(input):max(input)
fuel_costs <- sapply(positions, function(x) sum(abs(input - x)))

p1 <- min(fuel_costs)
p1

##################
#### PART TWO ####
##################

make_steps_vec <- function(x) {
    abs(vec - x)
}

calc_p2_fuel <- function(steps_vec) {
    sapply(steps_vec, function(X) sum(1:x))
}

run_p2 <- function(x) {
    steps_vec <- abs(input - x)
    sum(sapply(steps_vec, function(x) sum(1:x)))
}

p2_fuel_costs <- sapply(positions, run_p2)
p2 <- min(p2_fuel_costs)
p2

