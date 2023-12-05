#2022 day 3

library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/advent_of_code_2022/inputs/day3.csv")
input <- tibble(x = read_lines(input_file_path, skip_empty_rows = F))


#part 1
#break into two compartments
clean <- input %>%
    mutate(c1 = substr(x, 1, nchar(x)/2),
           c2 = substr(x, nchar(x)/2+1, nchar(x)))
    
#find the matching letter between the two compartments
p1 <- clean %>%
    mutate(c1 = str_split(c1, pattern = ''),
           c2 = str_split(c2, pattern = ''))

#not quite able to think about how to do this in a more vectorized way
items <- c()
for(i in 1:nrow(p1)) {
    matches <- sapply(p1$c1[i][[1]], function(x) x %in% p1$c2[i][[1]])
    item <- unique(names(matches[matches == T]))
    items <- c(items, item)
}

priority_key <- c(letters, LETTERS)
p1_priorities <- match(items, priority_key)
sum(p1_priorities)

#part 2
#group in rows of 3, all rows should have one shared character
p2 <- clean %>%
    select(x) %>%
    mutate(group_num = ceiling(row_number() / 3)) %>%
    mutate(x = str_split(x, pattern = ''))

letter_checks <- lapply(p2$x, function(x) sapply(priority_key, function(letter) letter %in% x))

badges <- c()
for(i in seq(from = 1, to = 300, by = 3)) {
    badges_test <- letter_checks[[i]] * letter_checks[[i+1]] * letter_checks[[i+2]]
    badge <- names(badges_test[badges_test == 1])
    badges <- c(badges, badge)
}

p2_priorities <- match(badges, priority_key)
sum(p2_priorities)


#some learnings from looking up other answers afer I finished:
# intersect function is what I could have used to compare the vectors of letters
# map2_chr function seems to be a method for turning my pesky lists into vectors?
