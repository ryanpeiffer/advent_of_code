library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/inputs/day2.csv")
input <- tibble(x = read_lines(input_file_path))

#part one
dirs <- input %>%
    separate(x, into = c('dir','value'), sep = " ") %>%
    mutate(value = as.integer(value))

totals <- dirs %>%
    group_by(dir) %>%
    summarise(total = sum(value))

p1 <- (filter(totals, dir == "down")$total - 
           filter(totals, dir == "up")$total) *
    filter(totals, dir == "forward")$total
p1

#part two
p2_tbl <- dirs %>%
    mutate(aim = ifelse(dir == "forward", 0, 
                        ifelse(dir == "up", -value, value))) %>%
    mutate(aim_total = cumsum(aim)) %>%
    mutate(h = ifelse(dir == "forward", value, 0),
           v = ifelse(dir == "forward", value*aim_total, 0))

p2 <- sum(p2_tbl$h) * sum(p2_tbl$v)
p2
