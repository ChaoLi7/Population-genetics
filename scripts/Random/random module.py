#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Oct 19 15:22:23 2021

"""
import random
print(random.choice(list([1,2,3,4])))

import random
print(random.choice([1,2,3,4,5,6]))


import matplotlib.pyplot as plt 
import numpy as np
rolls = []
for k in  range(1000):
    rolls.append(random.choice([1,2,3,4,5,6]))
plt.hist(rolls, bins = np.linspace(0.5, 6.5, 7)); 


ys = []

for rep in range(1000):
    y = 0
    for k in range(10):
        x = random.choice([1,2,3,4,5,6])
        y = y + x
        ys.append(y)
        
len(ys)
min(ys)
max(ys)

plt.hist(ys)



import numpy as np
np.random.random((3,5))
np.random.normal(0,3,5)


np.random.randint(1,7)
x = np.random.randint(1, 7, (10, 3))
print(x)
x.shape
np.sum(x)
np.sum(x, axis=0)
np.sum(x, axis = 1)

x = np.random.randint(1,7,(100,10))
y = np.sum(x, axis=1)
plt.hist(y)


