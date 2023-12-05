#2022 day 2

library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/advent_of_code_2022/inputs/day2.csv")
input <- tibble(x = read_lines(input_file_path, skip_empty_rows = F))


#part 1
#worked out the win_val stuff on sticky notes, kind of an inbetween solution between
#a ton of if/else vs a true "lookup table" type approach
strat <- input %>%
    separate(x, into = c('opp', 'me'), sep = " ") %>%
    mutate(choice_points = match(me, LETTERS) %% 3 + 1) %>%
    mutate(win_val = (match(me, LETTERS) %% 3 + 1) - ((match(opp, LETTERS)-1) %% 3)) %>%
    mutate(win_points = case_when(
                            win_val == 1 ~ 3, #tie
                            win_val %% 3 != 0 ~ 6, #win
                            win_val %% 3 == 0 ~ 0 #loss
    ))

sum(strat$choice_points + strat$win_points)
    

#part 2
#X = 0, Y = 3, Z = 6 for win_points
#choice_points will be backed into based on opp choice and X/Y/Z

strat2 <- strat %>%
    select(opp, me) %>%
    rename(outcome = me) %>%
    mutate(win_points = match(outcome, LETTERS) %% 3 * 3) %>%
    mutate(choice_points = match(opp,LETTERS) + (win_points/3 - 1)) %>%
    mutate(choice_points = case_when(
        choice_points == 4 ~ 1,
        choice_points == 0 ~ 3,
        TRUE ~ choice_points
    ))
    
sum(strat2$choice_points + strat2$win_points)

#explanation of part 2:
#   win_points/3 - 1 gives -1 for a loss, 0 for a tie, and 1 for a win
#   this represents the "displacement" from opponent choice in a vector of [A, B, C]
#   for example, if we won, and the opponent chose A, then we must have chosen B
#   this isn't perfect mathematically, as if the opponent choses C and we won, it would return 4
#   since 4 isn't a possible index of [A,B,C], I'm manually adjusting 4 to 1 and 0 to 3 to properly
#   "wrap" the arithmetic into correct vector indices.






