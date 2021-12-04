library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/adventofcode2020/inputs/day2.csv")
input <- read.csv(input_file_path, header = FALSE, stringsAsFactors = FALSE)[,1]

#PART ONE ---------------------------

split1 <- str_split(input, pattern = ":")
rules <- sapply(split1, "[[", 1)
passwords <- sapply(split1, "[[", 2)

split2 <- str_split(rules, pattern = "-")
mins <- as.integer(sapply(split2, "[[", 1))

split3 <- str_split(sapply(split2, "[[", 2), pattern = " ")
maxs <- as.integer(sapply(split3, "[[", 1))
chars <- sapply(split3, "[[", 2)

tbl <- tibble(passwords, chars, mins, maxs) %>%
    mutate(cnt = str_count(passwords, pattern = chars)) %>%
    mutate(valid = (cnt >= mins) & (cnt <= maxs))

answer <- sum(tbl$valid)


#PART TWO ----------------------------

tbl2 <- tbl %>%
    select(passwords, chars, mins, maxs) %>%
    rename(pos1 = mins, pos2 = maxs) %>%
    mutate(char1 = substr(passwords, pos1+1, pos1+1)) %>%
    mutate(char2 = substr(passwords, pos2+1, pos2+1)) %>%
    mutate(matches = (char1 == chars) + (char2 == chars))

answer2 <- length(tbl2$matches[tbl2$matches == 1])
