#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Oct 20 08:37:13 2021

"""

import time
import random

start_time = time.time()
end_time = time.time()
print(start_time - end_time)

start_time = time.time()
ys = []
for rep in range(10000):
    y = 0
    for k in range(10):
        x = random.choice([1,2,3,4,5,6])
        y = y + x
    ys.append(y)
end_time = time.time()    
print(type(end_time - start_time))

import numpy as np
import matplotlib.pyplot as plt 
delta_x = np.random.normal(0,1,(2,5))
print(delta_x)
plt.plot(delta_x[0],delta_x[1], "go")


x = np.cumsum(delta_x, axis = 1)
plt.plot(x[0],x[1], "ro-")
plt.savefig("random.pdf")

x_0 = np.array([[0], [0]])
x = np.concatenate((x_0, np.cumsum(delta_x, axis = 1)), axis=1)
plt.plot(x[0],x[1], "ro-")
plt.savefig("random2.pdf")


