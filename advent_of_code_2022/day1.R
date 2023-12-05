#2022 day 1

library(here)

input_file_path <- paste0(here(), "/advent_of_code_2022/inputs/day1.csv")
input <- tibble(x = read_lines(input_file_path, skip_empty_rows = F))


#part 1
p1 <- input %>%
    mutate(x = as.integer(x)) %>%
    mutate(x = replace_na(x, 0)) %>%
    mutate(elf = if_else(x == 0, 1, 0)) %>%
    mutate(elf = cumsum(elf)) %>%
    filter(x != 0) %>%
    group_by(elf) %>%
    summarise(items = n(),
             calories = sum(x))

max(p1$calories)


#part 2
p2 <- p1 %>%
    arrange(desc(calories))

sum(head(p2, 3)$calories)
