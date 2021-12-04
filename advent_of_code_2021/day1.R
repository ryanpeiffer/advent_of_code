library(here)

input_file_path <- paste0(here(), "/R/advent_of_code/2021/inputs/day1.csv")
input <- read.csv(input_file_path, header = FALSE)


#part one
changes <- input$V1[2:length(input$V1)] - input$V1[1:length(input$V1)-1]
p1 <- sum(changes > 0)
p1



#part two
triples <- input$V1[3:length(input$V1)] + 
            input$V1[2:(length(input$V1)-1)] + 
            input$V1[1:(length(input$V1)-2)]
triples_changes <- triples[2:length(triples)] - triples[1:length(triples)-1]
p2 <- sum(triples_changes > 0)
p2



#seeing if I can do this using dplyr
input <- input %>%
    mutate(diff = V1 - lag(V1),
           triple = V1 + lead(V1) + lead(V1, n = 2L))

input <- input %>%
    mutate(triple_diff = triple - lag(triple))
    
p1_ans <- sum(filter(input, !is.na(diff))$diff > 0)
p2_ans <- sum(filter(input, !is.na(triple_diff))$triple_diff > 0)
