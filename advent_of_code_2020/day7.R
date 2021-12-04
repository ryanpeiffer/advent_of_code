library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/inputs/day7.csv")
input <- tibble(x = read_lines(input_file_path))

#PART ONE --------------------------
#create tidy table of what each bag contains, one row per bag/content combo, with cleaned bag names
tbl <- input %>%
    mutate(x = gsub('"', "", x)) %>%
    separate(x, into = c("bag", "contents"), sep = "contain") %>%
    separate_rows(contents, sep = ",") %>%
    mutate(bag = trimws(gsub("bags?", "", bag)),
           contents = gsub("bags?", "", contents)) %>%
    mutate(contents = trimws(gsub("[0-9]|\\.", "", contents)))


direct_gold_holders <- tbl %>%
    mutate(has_gold = contents == "shiny gold") %>%
    filter(has_gold)

gold_holders <- direct_gold_holders$bag
running <- TRUE

while(running) {
    tmp <- filter(tbl, contents %in% gold_holders)$bag
    if(sum(!tmp %in% gold_holders) == 0) {running <- FALSE}
    gold_holders <- unique(c(gold_holders, tmp))
}

answer1 <- length(gold_holders)


#PART TWO -------------------------------

tbl2 <- input %>%
    mutate(x = gsub('"', "", x)) %>%
    separate(x, into = c("bag", "contents"), sep = "contain") %>%
    separate_rows(contents, sep = ",") %>%
    mutate(bag = trimws(gsub("bags?", "", bag)),
           contents = gsub("bags?", "", contents)) %>%
    mutate(contents = trimws(gsub("\\.", "", contents))) %>%
    separate(contents, into = c("n", "type"), sep = 1) %>%
    mutate(type = trimws(type)) %>%
    mutate(n = as.integer(ifelse(n == "n", 0, n)))

#manually do first iteration to get things set up nicely
n_bags <- 0

shiny_gold <- filter(tbl2, bag == "shiny gold")
n_bags <- n_bags + sum(shiny_gold$n)

iter <- left_join(shiny_gold, tbl2, by = c("type" = "bag")) %>%
    filter(n.y > 0) %>%
    mutate(n = n.x * n.y) %>%
    select(n, type.y) %>%
    rename(type = type.y)
    
n_bags <- n_bags + sum(iter$n)

#loop
running2 <- TRUE
while(running2) {
    iter <- left_join(iter, tbl2, by = c("type" = "bag")) %>%
        filter(n.y > 0) %>%
        mutate(n = n.x * n.y) %>%
        select(n, type.y) %>%
        rename(type = type.y)
    
    n_bags <- n_bags + sum(iter$n)
    
    if(length(iter$type) == 0) {running2 <- FALSE}
}

