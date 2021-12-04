library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/inputs/day3.csv")
input <- as_tibble(read.csv(input_file_path, header = FALSE, stringsAsFactors = FALSE))


#PART ONE ---------------------------
input_line_length <- str_length(slice(input, 1)[[1]])

tbl <- input %>%
    mutate(pos = 1 + (row_number()-1)*3) 

pos_fn <- function(n) {
    pos <- 0
    if(n %% 31 == 0) {
        pos <- 31
    } else {
        pos <- max(n - 31*floor(n/31), 0)
    }
    return(pos)
}

tbl <- tbl %>%
    mutate(pos_final = sapply(pos, "pos_fn")) %>%
    mutate(tree = substr(V1, pos_final, pos_final) == "#")

answer1 <- sum(tbl$tree)    


#PART TWO -------------------
#I could probably try to be real cheeky and do some sort of a loop for this... but let's go 1 by 1 for now.

#right 1 down 1
tbl2 <- input %>%
    mutate(pos = row_number()) %>%
    mutate(pos_final = sapply(pos, "pos_fn")) %>%
    mutate(tree = substr(V1, pos_final, pos_final) == "#")
answer2 <- sum(tbl2$tree)

#right 3 down 1
#already answered in part 1

#right 5 down 1
tbl3 <- input %>%
    mutate(pos = 1 + (row_number()-1)*5) %>%
    mutate(pos_final = sapply(pos, "pos_fn")) %>%
    mutate(tree = substr(V1, pos_final, pos_final) == "#")
answer3 <- sum(tbl3$tree)

#right 7 down 1
tbl4 <- input %>%
    mutate(pos = 1 + (row_number()-1)*7) %>%
    mutate(pos_final = sapply(pos, "pos_fn")) %>%
    mutate(tree = substr(V1, pos_final, pos_final) == "#")
answer4 <- sum(tbl4$tree)

#right 1 down 2
tbl5 <- input %>%
    filter(row_number() %% 2 != 0) %>%
    mutate(pos = row_number()) %>%
    mutate(pos_final = sapply(pos, "pos_fn")) %>%
    mutate(tree = substr(V1, pos_final, pos_final) == "#")
answer5 <- sum(tbl5$tree)

final_answer <- prod(answer1, answer2, answer3, answer4, answer5)    
