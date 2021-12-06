library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/advent_of_code_2021/inputs/day4.csv")
input <- tibble(x = read_lines(input_file_path, skip_empty_rows = T))

##################
#### PART ONE ####
##################
called_nums <- as.integer(str_split(slice(input, 1)$x, pattern = ",")[[1]])

#setup bingo boards
boards <- slice(input, 2:nrow(input)) %>%
    separate(x, into = c('b','i','n','g','o'), sep = c(3, 6, 9 ,12)) %>%
    mutate(across(.cols = everything(), .fns = as.integer))

#initialize daubs as all false because no numbers have been called yet
daubs <- boards %>%
    mutate(across(.cols = c('b','i','n','g','o'), .fns = ~(is.na(.x))))

winning_board_num <- 0
winning_num   <- 0

#loop to play bingo! finds what board won and what called number it won on
for(num in called_nums) {
    
    #check for matches with current number, then add it to our already daubbed numbers
    checks <- boards %>%
        mutate(across(.cols = c('b','i','n','g','o'), .fns = ~(.x == num)))

    daubs <- as_tibble(checks | daubs)
    
    #check to see if any boards have won horizontally
    horiz_win <- daubs %>%
        mutate(board_num = ceiling(row_number()/5)) %>%
        filter(across(.cols = c('b','i','n','g','o'), .fns = ~(.x == TRUE)))
        
    if(nrow(horiz_win) > 0) {
        winning_board_num <- horiz_win$board_num
        winning_num <- num
        break
    }   
    
    #check to see if any boards have won vertically
    vert_win <- daubs %>%
        mutate(board_num = ceiling(row_number()/5)) %>%
        group_by(board_num) %>%
        summarise(across(.cols = c('b','i','n','g','o'), .fns = sum)) %>%
        filter(if_any(.cols = c('b','i','n','g','o'), .fns = ~(.x == 5)))

    if(nrow(vert_win) > 0) {
        winning_board_num <- vert_win$board_num
        winning_num <- num
        break
    }   
}

#final answer: sum of the UNMARKED answers on the board * winning_num 
winning_board <- boards %>%
    mutate(board_num = ceiling(row_number()/5)) %>%
    filter(board_num == winning_board_num) %>%
    select(-board_num)

winning_daubs <- as_tibble(daubs) %>%
    mutate(board_num = ceiling(row_number()/5)) %>%
    filter(board_num == winning_board_num) %>%
    select(-board_num)

p1 <- sum(winning_board * !winning_daubs) * winning_num
p1

##################
#### PART TWO ####
##################

#initialize daubs as all false because no numbers have been called yet
daubs2 <- boards %>%
    mutate(across(.cols = c('b','i','n','g','o'), .fns = ~(is.na(.x))))

#loop to play bingo! keep going until only one board hasn't won.
for(num in called_nums) {
    
    checks <- boards %>%
        mutate(across(.cols = c('b','i','n','g','o'), .fns = ~(.x == num)))
    
    daubs2 <- as_tibble(checks | daubs2)
    
    #check to see if any boards have won horizontally
    horiz_win <- daubs2 %>%
        mutate(board_num = ceiling(row_number()/5)) %>%
        filter(across(.cols = c('b','i','n','g','o'), .fns = ~(.x == TRUE)))
    
    #check to see if any boards have won vertically
    vert_win <- daubs2 %>%
        mutate(board_num = ceiling(row_number()/5)) %>%
        group_by(board_num) %>%
        summarise(across(.cols = c('b','i','n','g','o'), .fns = sum)) %>%
        filter(if_any(.cols = c('b','i','n','g','o'), .fns = ~(.x == 5)))
    
    all_winners <- unique(c(horiz_win$board_num, vert_win$board_num))
    
    if(length(all_winners) == (nrow(boards)/5)-1) {
        all_boards <- 1:(nrow(boards)/5)
        last_winner <- all_boards[!all_boards %in% all_winners]
    } else if (length(all_winners) == (nrow(boards)/5)) {
        loser_final_num <- num
        break
    } 
}

#final answer: sum of the UNMARKED answers on the last board * winning_num
loser_board <- boards %>%
    mutate(board_num = ceiling(row_number()/5)) %>%
    filter(board_num == last_winner) %>%
    select(-board_num)

loser_daubs <- as_tibble(daubs2) %>%
    mutate(board_num = ceiling(row_number()/5)) %>%
    filter(board_num == last_winner) %>%
    select(-board_num)

p2 <- sum(loser_board * !loser_daubs) * loser_final_num
p2



#how I could have done this in a more tidyverse way, taken from @drob:
#use match() to find where in called_nums each bingo square is found
#then find the max value for each bingo card to see when it won
#gather() allows looking at vertical and horizonal at the same time
