library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/advent_of_code_2021/inputs/day8.csv")
input <- tibble(x = (read_lines(input_file_path)))

##################
#### PART ONE ####
##################

clean <- input %>%
    separate(x, into = c('signal', 'output'), sep = "\\|") %>%
    mutate(across(.cols = everything(), .fns = str_trim)) %>%
    separate(signal, into = c('s1', 's2', 's3', 's4', 's5',
                              's6', 's7', 's8', 's9', 's10')) %>%
    separate(output, into = c('o1', 'o2', 'o3', 'o4'))

p1_tbl <- clean %>%
    mutate(across(.cols = c('o1', 'o2', 'o3', 'o4'), 
                  .fns = function(x) case_when(str_length(x) %in% c(2,3,4,7) ~ 1,
                                               TRUE ~ 0)))

p1 <- sum(p1_tbl$o1) + sum(p1_tbl$o2) + sum(p1_tbl$o3) + sum(p1_tbl$o4)
p1


##################
#### PART TWO ####
##################

check_nums <- function(list, vec) {
    case_when(
        length(vec) == 2 ~ 1,
        length(vec) == 3 ~ 7,
        length(vec) == 4 ~ 4,
        length(vec) == 7 ~ 8,
        length(vec) == 6 & sum(list[[match(2, lengths(list))]] %in% vec)!=2 ~ 6, #6 has 6 sides and does not contain 1
        length(vec) == 6 & sum(list[[match(4, lengths(list))]] %in% vec)==4 ~ 9, #9 has 6 sides and contains 4
        length(vec) == 6 ~ 0, #remaining ones with 6 sides have to be 0
        length(vec) == 5 & sum(list[[match(2, lengths(list))]] %in% vec)==2 ~ 3, #3 has 5 sides and contains 1
        length(vec) == 5 & sum(list[[match(4, lengths(list))]] %in% vec)==3 ~ 5, #5 has 5 sides has 3 sides that match with 4
        length(vec) == 5 ~ 2, #2 is the leftovers with 5 sides
        TRUE ~ 999
    )   
}

p2_list <- apply(clean, MARGIN = 1, FUN = str_split, pattern = "")
p2_decoded <- lapply(p2_list, FUN = function(x) {sapply(x, FUN = check_nums, list = x)})
p2_nums <- sapply(p2_decoded, FUN = function(x) as.integer(paste0(x[11:14], collapse = '')))
p2 <- sum(p2_nums)
p2

