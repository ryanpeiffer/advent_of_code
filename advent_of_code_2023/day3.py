import sys
import re

#read inputs
input = open('inputs/day3input.txt').read().strip()
lines = input.split('\n')

#part 1
print('part 1')

row_iter = 0
p1_ans = 0

def check_char(char):
	return not char.isalpha() and not char.isdigit() and char != '.'

for line in lines:
    print(line)
    nums = re.findall('\d+', line)
    min_loc = 0
    for num in nums:
        valid = False
        print(line[min_loc:len(line)])
        rel_loc = line[min_loc:len(line)].find(num) #in case there are repeats of a number in a line
        loc = min_loc + rel_loc
        min_loc += rel_loc + len(num)
        


        '''
        if loc > 0: valid = max(valid, check_char(line[loc-1])) #check one to the left
        if loc + len(num) < len(line): valid = max(valid, check_char(line[loc+len(num)])) #one to right

        for i in range(loc-1, loc+len(num)+1):
            if row_iter > 0 and i >= 0 and i < len(line): valid = max(valid, check_char(lines[row_iter-1][i])) #row above
            if row_iter < len(lines)-1 and i >= 0 and i < len(line): valid = max(valid, check_char(lines[row_iter+1][i])) #row below
        '''
        print('testing: ' + num + ' at loc ' + str(loc))
        if loc > 0: 
            print(line[loc-1] + ": " + str(check_char(line[loc-1])))
            valid = max(valid, check_char(line[loc-1]))
        if loc + len(num) < len(line): 
            print(line[loc+len(num)] + ": " + str(check_char(line[loc+len(num)])))
            valid = max(valid, check_char(line[loc+len(num)]))#one to right
        for i in range(loc-1, loc+len(num)+1):
            if row_iter > 0 and i >= 0 and i < len(line): 
                print(lines[row_iter-1][i] + ": " + str(check_char(lines[row_iter-1][i])))
                valid = max(valid, check_char(lines[row_iter-1][i]))
            if row_iter < len(lines)-1 and i >= 0 and i < len(line): 
                print(lines[row_iter+1][i] + ": " + str(check_char(lines[row_iter+1][i])))
                valid = max(valid, check_char(lines[row_iter+1][i]))


        print(num + ': ' + str(int(num) * valid))
        p1_ans += int(num) * valid
    row_iter += 1
    print('\n')	

print(p1_ans)

#part 2
print('part 2')

