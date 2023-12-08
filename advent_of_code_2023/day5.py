import sys
import re

#read inputs
input = open('inputs/day5input.txt').read().strip()
sections = input.split('\n\n')
p1_seeds = list(map(int, sections[0].split(': ')[1].split()))

#part 1
print('part 1')

p1_mega_map = []
#I could probly wrap the inside as a function and map it over seeds array, but this works for now
#also dont need to keep these big arrays but it doesn't blow up computer and its cool
for seed in p1_seeds:
    journey = [0] * len(sections)
    journey[0] = seed
    i = 1
    for section in sections[1:len(sections)]:
        my_maps = section.split(':\n')[1].split('\n')
        out = 0
        for m in my_maps:
            dest, source, rng = list(map(int, m.split()))
            if journey[i-1] in range(source, source + rng):
                out = dest + (journey[i-1] - source)
        journey[i] = out if out > 0 else journey[i-1]
        i += 1
    #print(journey)
    p1_mega_map.append(journey)
    
p1_locations = []
for journey in p1_mega_map:
    p1_locations.append(journey[-1])

print(min(p1_locations))
#part 2
print('part 2')
#originally tried to use p1 loop, but that requires over 3 billion iterations lmao
seed_nums = list(map(int, sections[0].split(': ')[1].split()))
p2_seeds_min = seed_nums[0]
p2_seeds_max = seed_nums[0] + seed_nums[1]

while len(seed_nums) > 0:
    start = seed_nums.pop(0)
    dist = seed_nums.pop(0)
    p2_seeds_min = min(p2_seeds_min, start)
    p2_seeds_max = max(p2_seeds_max, start+dist-1) 

p2_seeds = range(p2_seeds_min, p2_seeds_max+1)

