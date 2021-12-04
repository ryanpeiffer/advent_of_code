library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/inputs/day3.csv")
input <- tibble(x = read_lines(input_file_path))

#part one
tbl <- input %>%
    separate(x, into = paste0("x", (c(1:13))), sep = "") %>%
    mutate(across(, ~as.numeric(.))) %>%
    select(!1) %>%
    summarise(across(, ~ n()/sum(.))) %>%
    mutate(across(, ~ ifelse(.x > 2, 0, 1))) #if above 2, 0 is more common

gamma <- as.numeric(tbl[1,])
epsilon <- 1-gamma

bin_to_dec <- function(vec) {
    positions <- rev(c(1:length(vec)) - 1)
    sum((2^positions) * vec)
}

p1 <- bin_to_dec(gamma) * bin_to_dec(epsilon)
p1

#part two

#oxygen
#we want to iteratively filter on input = tbl until only one row
oxygen <- input %>%
    separate(x, into = paste0("x", (c(1:13))), sep = "") %>%
    mutate(across(, ~as.numeric(.))) %>%
    select(!1)

col <- 1
while(nrow(oxygen) > 1) {
    bit_criteria <- ifelse(nrow(oxygen) / sum(oxygen[col]) <= 2, 1, 0)
    oxygen <- oxygen[oxygen[col]==bit_criteria,]
    col <- col + 1
}


#CO2
#same idea just flip the if statement
co2 <- input %>%
    separate(x, into = paste0("x", (c(1:13))), sep = "") %>%
    mutate(across(, ~as.numeric(.))) %>%
    select(!1)

col <- 1
while(nrow(co2) > 1) {
    bit_criteria <- ifelse(nrow(co2) / sum(co2[col]) <= 2, 0, 1)
    co2 <- co2[co2[col]==bit_criteria,]
    col <- col + 1
}


oxygen <- as.numeric(oxygen[1,])
co2 <- as.numeric(co2[1,])

p2 <- bin_to_dec(oxygen) * bin_to_dec(co2)
p2


