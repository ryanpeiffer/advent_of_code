import sys
import re

#read inputs
input = open('inputs/day4input.txt').read().strip()
lines = input.split('\n')

#part 1
print('part 1')

score = 0

for line in lines:
    nums = line.split(': ')[1].split(' |')
    winners, mine = nums[0].split(), nums[1].split()
    matches = 0
    for num in mine:
        if num in winners:
            matches += 1
    if matches > 0:
        score += 2**(matches-1)

print(score)


#part 2
print('part 2')

match_counts = []

for line in lines:
    nums = line.split(': ')[1].split(' |')
    winners, mine = nums[0].split(), nums[1].split()
    matches = 0
    for num in mine:
        if num in winners:
            matches += 1
    match_counts.append(matches)


copies = [1] * len(lines) #start out recording 1 copy of each card
i = 0

for card in match_counts:
    for j in range(card):
        copies[i+j+1] += copies[i]
    i += 1

print(sum(copies))