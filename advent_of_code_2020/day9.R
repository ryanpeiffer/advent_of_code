library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/inputs/day9.csv")
input <- as.numeric(tibble(x = read_lines(input_file_path))[[1]])

options(scipen = 999)

#PART ONE -----------------------------
idx <- 26

ans <- 0
loop <- TRUE


while(loop) {
    val <- input[idx]
    tbl <- crossing(v1 = input[(idx-25):(idx-1)], v2 = input[(idx-25):(idx-1)]) %>%
        filter(v1 != v2) %>%
        filter((v1 + v2) == val)
    
    if(length(tbl$v1) == 0) {
        ans <- val
        loop <- FALSE
    } else {
        idx <- idx + 1
    }
}


# PART TWO ---------------------------
#written so that this only works after running part 1

idx_min <- 1
idx_max <- 1
test_sum <- 0

while(test_sum != ans) {
    idx_max <- idx_max + 1
    test_sum <- sum(input[idx_min:idx_max])
    while(test_sum > ans) {
        idx_min <- idx_min + 1
        test_sum <- sum(input[idx_min:idx_max])
    }
}

ans_vec <- input[idx_min:idx_max]
ans2 <- min(ans_vec) + max(ans_vec)
