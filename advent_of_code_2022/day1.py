import pandas as pd
import numpy as np

#read input
input = pd.read_csv('inputs/day1.csv', 
    header = None,
    names = ['calories'],
    skip_blank_lines = False)

#part one
input['elf'] = input.isnull().cumsum()
sums = input.groupby('elf').sum()

print(sums['calories'].max()) 


#part two
print(sums['calories'].sort_values(ascending=False).head(3).sum())
