import sys
import re

#read inputs
input = open('inputs/day8input.txt').read().strip()
lines = input.split('\n')

#part 1
print('part 1')

input_dirs = lines[0]
dirs = [1 if c == 'L' else 2 for c in input_dirs]
current = 'AAA'

clean_maps = []
for item in lines[2:]: #ignore the dirs string, ignore empty item in slot 1 
    loc = item.split(' = ')[0]
    left, right = item.split(' = ')[1].split(', ')
    clean_maps.append([loc, re.sub('[\(\)]', '', left), re.sub('[\(\)]', '', right)])
#print(clean_maps)

step_count = 0
while current != 'ZZZ':
    for dir in dirs:
        #print(current, dir)
        if current != 'ZZZ':
            step_count += 1
        step_list = [sublist for sublist in clean_maps if sublist[0] == current]
        current = step_list[0][dir]
        #print(step_list)

print(step_count)    

#part 2
print('part 2')

p2_current = []
for item in clean_maps:
    if re.search('..A', item[0]):
        p2_current.append(item[0])

p2_step_count = 0

'''
I let this run for a bit, looked at reddit, and people said to expect a 14 digit answer...
so this is probably not the path to go.

while (sum([bool(re.search('..Z', s)) for s in p2_current]) < len(p2_current)):
    for d in dirs:
        p2_step_count += 1
        if sum([bool(re.search('..Z', s)) for s in p2_current]) == len(p2_current):
            break #including this so we don't keep traversing dirs once we hit the end point
        #print(p2_current, d)
        for i in range(len(p2_current)):
            step_list = [sublist for sublist in clean_maps if sublist[0] == p2_current[i]]
            p2_current[i] = step_list[0][d]

print(p2_step_count)
'''