#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Oct 21 14:48:14 2021

@author: lichao
"""

# loop over all points
    # compute the distance between point p and every other point
# sort distances and return those k points that are nearest to point p

def find_nearest_neighbors(p, points, k=5):
    """Find the k nearest neighbors of pint p and return their indices."""
    distances = np.zeros(points.shape[0])
    for i in range(len(distances)):
        distances[i] = distance(p, points[i])
    ind = np.argsort(distances)
    return ind[:k]

import numpy as np
points = np.array([[1,1], [1,2], [1,3], [2,1], [2,2], [2,3], [3,1], [3,2], [3,3]])
p = np.array([2.5, 2])
ind = find_nearest_neighbors(p, points, 2); print(points[ind])



def knn_predict(p, points, outcomes, k=5):
    ind = find_nearest_neighbors(p, points, k)
    return majority_vote(outcomes[ind])

import numpy as np
outcomes = np.array([0,0,0,0,1,1,1,1,1])
len(outcomes)


knn_predict(np.array([2.5, 2.7]), points, outcomes, k=2)
knn_predict(np.array([1.0, 2.7]), points, outcomes, k=2)



import numpy as np
import matplotlib.pyplot as plt



points = np.array([[1,1], [1,2], [1,3], [2,1], [2,2], [2,3], [3,1], [3,2], [3,3]])

p = np.array([2.5, 2])

import matplotlib.pyplot as plt
plt.plot(points[:,0], points[:,1], "ro")
plt.plot(p[0], p[1], "bo")
plt.axis([0.5, 3.5, 0.5, 3.5])

distances = np.zeros(points.shape[0])
for i in range(len(distances)):
    distances[i] = distance(p, points[i])
distances

ind = np.argsort(distances)
ind
distances[ind]




ss.norm(0,1).rvs((5,2))
ss.norm(1,1).rvs((5,2))

np.concatenate((ss.norm(0,1).rvs((5,2)), ss.norm(1,1).rvs((5,2))), axis=0)

np.concatenate((ss.norm(0,1).rvs((n,2)), ss.norm(1,1).rvs((n,2))), axis=0)


def generate_synth_data(n=50):
    """Create two sets of points from bivariate normal distributions."""
    points = np.concatenate((ss.norm(0,1).rvs((n,2)), ss.norm(1,1).rvs((n,2))), axis=0)
    outcomes = np.concatenate((np.repeat(0, n), np.repeat(1, n)))
    return (points, outcomes)

(points, outcomes) = generate_synth_data(n = 20)
plt.figure()
plt.plot(points[:n,0], points[:n,1], "ro")
plt.plot(points[n:,0], points[n:,1], "bo")
plt.savefig("bivardata.pdf")





#######################
def make_prediction_grid(predictors, outcomes, limits, h, k):
    """Classify each point on the prediction grid."""
    (x_min, x_max, y_min, y_max) = limits
    xs = np.arange(x_min, x_max, h)
    ys = np.arange(y_min, y_max, h)
    xx, yy = np.meshgrid(xs, ys)
    
    prdiction_grid = np.zeros(xx.shape, dtype = int)
    prediction_grid = {}
    for i,x in enumerate(xs):
        for j,y in enumerate(ys):
            p = np.array([x,y])
            prediction_grid[j,i] = knn_predict(p, predictors, outcomes, k)
            
    return (xx, yy, prediction_grid)






def plot_prediction_grid (xx, yy, prediction_grid, filename):
    """ Plot KNN predictions for every point on the grid."""
    from matplotlib.colors import ListedColormap
    background_colormap = ListedColormap (["hotpink","lightskyblue", "yellowgreen"])
    observation_colormap = ListedColormap (["red","blue","green"])
    plt.figure(figsize =(10,10))
    plt.pcolormesh(xx, yy, prediction_grid, cmap = background_colormap, alpha = 0.5)
    plt.scatter(predictors[:,0], predictors [:,1], c = outcomes, cmap = observation_colormap, s = 50)
    plt.xlabel('Variable 1'); plt.ylabel('Variable 2')
    plt.xticks(()); plt.yticks(())
    plt.xlim (np.min(xx), np.max(xx))
    plt.ylim (np.min(yy), np.max(yy))
    plt.savefig(filename)






#######################
import numpy as np
(predictors, outcomes) = generate_synth_data()

k=5; filename="knn_synth_5.pdf"; limits = (-3,4,-3,4); h = 0.1
(xx, yy, prediction_grid) = make_prediction_grid(predictors, outcomes, limits, h, k)
plot_prediction_grid(xx, yy, prediction_grid, filename)






from sklearn import datasets
iris = datasets.load_iris()
predictors = iris["data"]
outcomes = iris.target
import matplotlib.pyplot as plt
plt.plot(predictors[outcomes==0], predictors[outcomes==0][:,1], "ro")
plt.plot(predictors[outcomes==1], predictors[outcomes==1][:,1], "go")
plt.plot(predictors[outcomes==2], predictors[outcomes==2][:,1], "bo")
plt.savefig("iris.pdf")

k=5; filename="iris_grid.pdf"; limits = (4,8,1.5,4.5); h = 0.1
(xx, yy, prediction_grid) = make_prediction_grid(predictors, outcomes, limits, h, k)
plot_prediction_grid(xx, yy, prediction_grid, filename)


from sklearn.neighbors import KNeighborsClassifier
knn = KNeighborsClassifier(n_neighbors = 5)
knn.fit(predictors, outcomes)
sk_predictions = knn.predict(predictors)

sk_predictions.shape
sk_predictions[0:10]

my_predictions = np.array([knn_predict(p, predictors, outcomes, 5) for p in predictors])



























