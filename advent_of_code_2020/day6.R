library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/inputs/day6.csv")
input <- tibble(x = read_lines(input_file_path))

#PART ONE --------------------------

tbl <- input %>%
    mutate(group = cumsum(x == "")) %>%
    filter(x != "") %>%
    separate_rows(x, sep = "") %>% #learned this from drob on twitter! Very very cool!
    filter(x != "") %>%
    group_by(group) %>%
    distinct() %>%
    add_count() %>%
    distinct(group, n)

answer <- sum(tbl$n)


#PART TWO ---------------------
tbl2 <- input %>%
    mutate(group = cumsum(x == "")) %>%
    filter(x != "") %>%
    add_count(group, name = "group_size") %>%
    separate_rows(x, sep = "") %>%
    filter(x != "") %>%
    group_by(group) %>%
    add_count(x) %>%
    distinct() %>%
    filter(group_size == n)

answer2 <- length(tbl2$n)
           