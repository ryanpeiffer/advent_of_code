library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/inputs/day5.csv")
input <- read_csv(input_file_path, col_names = FALSE)[[1]]

#PART ONE ----------------------------

get_seat <- function(str) {
    min_row <- 1
    max_row <- 128
    min_col <- 1
    max_col <- 8
    
    row_vec <- str_split(substr(str, 1, 7), pattern = "")[[1]]
    col_vec <- str_split(substr(str, 8, 10), pattern = "")[[1]]
    
    for(letter in row_vec) {
        if(letter == "F") {
            max_row <- max_row - (max_row - min_row + 1) / 2
        } else {
            min_row <- min_row + (max_row - min_row + 1) / 2
        }
    }
    
    for(letter in col_vec) {
        if(letter == "L") {
            max_col <- max_col - (max_col - min_col + 1) / 2
        } else {
            min_col <- min_col + (max_col - min_col + 1) / 2
        }
    }
    return((min_row-1) * 8 + (min_col-1))
}

seats <- sapply(input, "get_seat")
answer <- max(seats)


#PART TWO--------------------------

all_seats <- min(seats):max(seats)
possible_seats <- all_seats[!all_seats %in% seats]
