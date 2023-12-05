#2022 day 5

library(here)
library(tidyverse)

#read input and construct into something useful
input_file_path <- paste0(here(), "/advent_of_code_2022/inputs/day5.csv")
input <- tibble(x = read_lines(input_file_path, skip_empty_rows = F))

#ideally would find the blank line and split after that, but being lazy and manually setting to 11
moves <- slice(input, 11:nrow(input)) %>%
    mutate(nums = gsub("[a-z]","", x)) %>%
    separate(nums, into = c("quantity","from","to"), sep = "  ") %>%
    select(quantity, from, to) %>%
    mutate(across(everything(), as.integer))

#super ugly and manual way of slicing and cleaning up the crate data
crates <- slice(input, 1:8) %>%
    mutate(org = gsub("    ", "[.] ", x)) %>%
    mutate(org2 = gsub(" ", "", org)) %>%
    mutate(org3 = gsub("\\[", "", org2)) %>%
    mutate(org3 = gsub("\\]", "", org3)) %>%
    select(org3) %>%
    separate(org3, into = paste0("stack", 0:9), sep = "") %>%
    select(-stack0)

#part 1
#need general logic on how to move crates around... 

