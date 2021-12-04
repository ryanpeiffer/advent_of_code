library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/inputs/day11.csv")
input <- tibble(x = trimws(read_lines(input_file_path))) %>%
    separate(x, into = paste0("s", 1:91), sep = 1:90, remove = TRUE)

#PART ONE ---------------------------

check_neighbors <- function(row, col) {
    return(sum(seats[(row-1):(row+1), (col-1):(col+1)] == "#") - as.numeric(seats[row,col] == "#"))
}
check_neighbors <- Vectorize(check_neighbors)

update_seat <- function(row, col) {
    new_seat <- "."
    if(seats[row, col] == "#" & as.numeric(neighbors[row, col]) >= 4) {
        new_seat <- "L"
    } else if(seats[row, col] == "L" & as.numeric(neighbors[row, col]) == 0) {
        new_seat <- "#"
    }
    return(new_seat)
}
update_seat <- Vectorize(update_seat)

#pad the matrix with floor spaces so we can check -1:1 for each element
seats <- rbind(".", cbind(".", input, "."), ".")

#this loop never stopped... need to revisit my check for equality at some point
running <- TRUE
while(running){
    neighbors <- as_tibble(outer(2:(nrow(seats)-1), 2:(ncol(seats)-1), FUN = "check_neighbors"))
    neighbors <- rbind(".", cbind(".", neighbors, "."), ".")
    
    new_seats <- as_tibble(outer(2:(nrow(seats)-1), 2:(ncol(seats)-1), FUN = "update_seat")) # not working...
    new_seats <- rbind(".", cbind(".", new_seats, "."), ".")
    
    if(identical(new_seats, seats)) {
        running <- FALSE
    } else {
        seats <- new_seats
    }
}

sum(seats == "#")

#PART TWO --------------------------- 