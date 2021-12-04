library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/inputs/day10.csv")
input <- tibble(x = as.numeric(read_lines(input_file_path)))

#PART ONE ---------------------------

tbl <- input %>%
    add_row(x = max(input$x) + 3) %>%
    arrange(x) %>% 
    mutate(diff = coalesce(x - lag(x), 1))

ans1_tbl <- tbl %>%
    count(diff) %>%
    filter(diff == 1 | diff == 3)

ans1 <- prod(ans1_tbl$n)



#PART TWO ------------------------------

#may need to do some searching to get hints on how to begin addressing this, 
#not something I have much background on....
