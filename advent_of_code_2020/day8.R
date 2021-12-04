library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/inputs/day8.csv")
input <- tibble(x = read_lines(input_file_path))

#PART ONE --------------------------
tbl <- input %>%
    separate(x, into = c("direction", "value"), sep = " ") %>%
    mutate(value = as.integer(value))

#initialize variables before looping
first_loop <- TRUE
current_row <- 1
acc <- 0
visited_rows <- c(current_row)

while(first_loop) {
    direction <- tbl$direction[current_row]
    value <- tbl$value[current_row]
    
    ifelse(direction == "jmp", current_row <- current_row + value, current_row <- current_row + 1)
    if(direction == "acc") {acc <- acc + value}
    
    ifelse(current_row %in% visited_rows, first_loop <- FALSE, visited_rows <- c(visited_rows, current_row))
}


#PART TWO ------------------------------------
tbl2 <- tbl %>%
    mutate(location = row_number()) %>%
    mutate(real_next = case_when(
        direction == "acc" ~ as.integer(row_number()+1),
        direction == "nop" ~ as.integer(row_number()+1),
        direction == "jmp" ~ as.integer(row_number()+value))) %>%
    mutate(switch_next = case_when(
        direction == "acc" ~ as.integer(row_number()+1),
        direction == "nop" ~ as.integer(row_number()+value),
        direction == "jmp" ~ as.integer(row_number()+1)))

#It wouldn't be too hard to make a brute force solution but that's not satisfying
