import numpy as np
import pandas as pd
import argparse
import csv
import sys

parser = argparse.ArgumentParser()
parser.add_argument("-i", default="test.input")
parser.add_argument("-m", default="10", type=float) #number of random
args = parser.parse_args()

def readdata(filepath):
    samples = [set() for i in range(18)]
    with open(filepath) as csvfile:
        csvreader = csv.reader(csvfile, delimiter='\t')
        for line in csvreader:
            for i in range(len(line)):
                samples[i].add(line[i])

    return samples

samples = readdata(args.i)

datadf = pd.DataFrame()

if __name__ == "__main__":
    sample_times = int(args.m)
    for i in range(sample_times):
        printlist = list()
        for i in range(1, 18):
            index = np.random.randint(0, 17, i)
            sapset = set()
            for i in index:
                sapset = sapset.union(samples[i])
            printlist.append(str(len(sapset)))
        print(",".join(printlist))
