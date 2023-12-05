
import re

#read inputs
with open('inputs/day2input.txt') as f:
    lines = f.readlines()
f.close()

print(lines)
#part 1
print('part 1')

maxes = {
	'red': 12,
    'green': 13,
    'blue': 14}

valid_sum = 0

for line in lines:
    clean = line[:-1].split(': ') #line[:-1] removes newline char at end of string
    game_num = int(clean[0].split(' ')[-1])
    pulls = clean[1].split('; ')
    print(pulls)
    for pull in pulls:
        cubes = pull.split(', ')
        print(cubes)
        for cube in cubes:
            lst = cube.split(' ')
            print(lst)
            if int(lst[0]) > maxes[lst[1]]: 
                game_num = 0
    valid_sum += game_num
print(valid_sum)


#part 2
print('part 2')
#for each game, what is the max of each color 

power_sum = 0
for line in lines:
    clean = line[:-1].split(': ') #line[:-1] removes newline char at end of string
    pulls = clean[1].split('; ')

    red_max = 0
    blue_max = 0
    green_max = 0
    #print(pulls)
    for pull in pulls:
        cubes = pull.split(', ')
        #print(cubes)
        for cube in cubes:
            lst = cube.split(' ')
            #print(lst)
            if lst[1] == 'red':
                red_max = max(red_max, int(lst[0]))
            elif lst[1] == 'blue':
                blue_max = max(blue_max, int(lst[0]))
            elif lst[1] == 'green':
                green_max = max(green_max, int(lst[0]))
            else:
                print('intruder!')
    power = red_max * blue_max * green_max
    power_sum += power

print(power_sum)