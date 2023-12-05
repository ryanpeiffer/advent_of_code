
import re

#read inputs
with open('inputs/day1input.txt') as f:
    lines = f.readlines()
f.close()

#part 1
#each line we want to combine the first and last digit to form a single 2 digit number
print('part 1')

calibration_values = []
for line in lines:
    all_nums = re.sub('[^0-9]','',line)
    my_num = int(str(all_nums[0]) + str(all_nums[-1]))
    calibration_values.append(my_num)

print(calibration_values)
print((sum(calibration_values)))

#part 2
#now we need to also include anything spelled out as a string!
print('part 2')

#so we stole this trick from reddit
#basically appending the last letter if it matches the first of another word fixes f&r mistakes
#I only half understand this... hard for a day 1!
num_dict = {
    'one': '1e',
    'two': '2o',
    'three': '3e',
    'four': '4',
    'five': '5e',
    'six': '6',
    'seven': '7n',
    'eight': '8t',
    'nine': '9e',
}

calibration_values2 = []

for line in lines:
    #first find the words
    #this is probably unncessary now that we have the dict trick above
    tmp_dict = {}
    for element in num_dict.keys():
        tmp_dict.update({element: line.find(element)})
    tmp_dict2 = {key:val for key, val in tmp_dict.items() if val != -1}
    sort_dict = dict(sorted(tmp_dict2.items(), key=lambda item: item[1]))

    #now do replacements
    tmp_strs = [line]
    for element in sort_dict.keys():
        tmp_strs.append(tmp_strs[-1].replace(element, num_dict[element]))
    final_nums = re.sub('[^0-9]', '', tmp_strs[-1])
    calibration_values2.append(int(str(final_nums[0]) + str(final_nums[-1])))
    print(final_nums)

print(calibration_values2)
print(sum(calibration_values2))