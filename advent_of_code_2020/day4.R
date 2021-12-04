library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/inputs/day4.csv")
input <- tibble(x = read_lines(input_file_path))

# PART ONE -----------------------
needed_values <- c("byr", "iyr", "eyr", "hgt",
                  "hcl", "ecl", "pid")

tbl <- input %>%
    mutate(group = cumsum(x == "")) %>%
    filter(x != "") %>%
    separate_rows(x, sep = " ") %>%
    mutate(x = substr(x, 1, 3)) %>%
    mutate(check = x %in% needed_values) %>%
    group_by(group) %>%
    summarise(total = sum(check)) %>%
    filter(total > 6)

answer1 <- length(tbl$group)


#PART TWO ------------------------------
eye_cols <- c("amb", "blu", "brn", "gry",
              "grn", "hzl", "oth")

tbl2 <- input %>%
    mutate(group = cumsum(x == "")) %>%
    filter(x != "") %>%
    separate_rows(x, sep = " ") %>%
    mutate(label = substr(x, 1, 3)) %>%
    mutate(value = substr(x, 5, str_length(x))) %>%
    mutate(check = label %in% needed_values) %>%
    group_by(group) %>%
    mutate(total = sum(check)) %>%
    filter(total > 6) %>%
    ungroup() %>%
    filter(label != "cid")

tbl3 <- tbl2 %>%
    mutate(valid = case_when(
        label == "byr" ~ (value >= 1920 & value <= 2002),
        label == "iyr" ~ (value >= 2010 & value <= 2020),
        label == "eyr" ~ (value >= 2020 & value <= 2030),
        label == "hgt" ~ substr(value, nchar(value)-1, nchar(value)) %in% c("cm", "in") &
                         ifelse(substr(value, nchar(value)-1, nchar(value)) == "cm",
                                substr(value, 1, nchar(value)-2) >= 150 & substr(value, 1, nchar(value)-2) <= 193,
                                substr(value, 1, nchar(value)-2) >= 59 & substr(value, 1, nchar(value)-2) <= 76),
        label == "hcl" ~ str_detect(value, "#[0-9a-f]{6}"),
        label == "ecl" ~ value %in% eye_cols,
        label == "pid" ~ nchar(value) == 9)) %>%
    group_by(group) %>%
    summarise(total2 = sum(valid)) %>%
    filter(total2 > 6)

answer2 <- length(tbl3$group)
