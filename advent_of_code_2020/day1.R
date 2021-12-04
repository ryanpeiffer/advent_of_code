library(here)
library(tidyverse)

#PART ONE --------------------

input_file_path <- paste0(here(), "/inputs/day1.csv")
input <- read.csv(input_file_path, header = FALSE)

tbl <- crossing(input, input, .name_repair = "universal") 
colnames(tbl) <- c("v1","v2")

answer <- tbl %>%
    mutate(sum = v1 + v2) %>%
    filter(sum == 2020) %>%
    mutate(product = v1 * v2)


#PART TWO -------------------
tbl2 <- crossing(input, input, input, .name_repair = make.names)
colnames(tbl2) <- c("v1","v2","v3")

answer2 <- tbl2 %>%
    mutate(sum = v1 + v2 + v3) %>%
    filter(sum == 2020) %>%
    mutate(product = v1 * v2 * v3)
