library(here)
library(tidyverse)

input_file_path <- paste0(here(), "/advent_of_code_2021/inputs/day5.csv")
input <- tibble(x = read_lines(input_file_path))

##################
#### PART ONE ####
##################
lines <- input %>%
    separate(x, into = c("p1", "p2"), sep = "->") %>%
    separate(p1, into = c("x1", "y1"), sep = ",") %>%
    separate(p2, into = c("x2", "y2"), sep = ",") %>%
    mutate(across(.fns = as.integer)) %>%
    filter( x1 == x2 | y1 == y2) #we are told to only consider vertical or horizontal lines, but the input has some diagonals

#gah, I ended up stealing this from @drob :(
points <- lines %>%
    mutate(x = map2(x1, x2, seq)) %>% #this is new to me but makes sense, kind of what I was trying to do
    mutate(y = map2(y1, y2, seq)) %>%
    select(x,y) %>%
    unnest(x) %>% #this is new to me, seems badass, should learn the behavior a bit more 
    unnest(y) %>%
    group_by(x, y) %>%
    count() %>%
    filter(n > 1)

p1 <- nrow(points)
p1

##################
#### PART TWO ####
##################
all_lines <- input %>%
    separate(x, into = c("p1", "p2"), sep = "->") %>%
    separate(p1, into = c("x1", "y1"), sep = ",") %>%
    separate(p2, into = c("x2", "y2"), sep = ",") %>%
    mutate(across(.fns = as.integer))

all_points <- all_lines %>%
    mutate(x = map2(x1, x2, seq)) %>% 
    mutate(y = map2(y1, y2, seq)) %>%
    select(x,y) %>%
    unnest(c(x,y)) %>% #unfortunately stole the idea of unnesting at once too 
    group_by(x, y) %>%
    count() %>%
    filter(n > 1)

p2 <- nrow(all_points)
p2
