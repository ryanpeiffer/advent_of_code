import sys
import re
from math import ceil

#read inputs
input = open('inputs/day6input.txt').read().strip()
time_str, dist_str = input.split('\n')
print(time_str, dist_str)

#part 1
print('part 1')

time_str, dist_str = input.split('\n')
times = list(map(int, time_str.split(':')[1].split()))
dists = list(map(int, dist_str.split(':')[1].split()))
print(times, dists)

win_counts = []
for time, dist in zip(times, dists):
    win_count = 0
    for i in range(1, ceil(time/2)):
        if i*(time-i) > dist: win_count += 2
    if time % 2 == 0 and (time/2)*(time-time/2) > dist: win_count += 1
    win_counts.append(win_count)

print(win_counts)
p1_ans = 1 
for x in win_counts: p1_ans = p1_ans * x
print(p1_ans)


#part 2
#it's only like 25M loops...
print('part 2')

p2_time = int(''.join(time_str.split(':')[1].split()))
p2_dist = int(''.join(dist_str.split(':')[1].split()))

p2_win_count = 0
for i in range(1, ceil(p2_time/2)):
    if i*(p2_time-i) > p2_dist: p2_win_count += 2
if p2_time % 2 == 0 and (p2_time/2)*(p2_time-p2_time/2) > p2_dist: p2_win_count += 1
print(p2_win_count)