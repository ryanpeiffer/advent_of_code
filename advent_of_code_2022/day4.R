#2022 day 4

library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/advent_of_code_2022/inputs/day4.csv")
input <- tibble(x = read_lines(input_file_path, skip_empty_rows = F))


#part 1
clean <- input %>%
    separate(x, into = c('elf1','elf2'), sep = ",") %>%
    separate(elf1, into = c('elf1min','elf1max'), sep = '-') %>%
    separate(elf2, into = c('elf2min','elf2max'), sep = '-') %>%
    mutate(across(everything(),as.integer))

p1 <- clean %>%
    mutate(elf1_contained = if_else((elf1min >= elf2min) & (elf1max <= elf2max), 1, 0),
           elf2_contained = if_else((elf2min >= elf1min) & (elf2max <= elf1max), 1, 0)) %>%
    mutate(ans = pmax(elf1_contained, elf2_contained))

sum(p1$ans)
    
#part 2
p2 <- clean %>%
    mutate(ans = if_else(pmax(elf1min, elf2min) > pmin(elf1max, elf2max), 0, 1))

sum(p2$ans)
