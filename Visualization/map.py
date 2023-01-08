#import functions
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.basemap import Basemap
import pandas as pd
from itertools import chain

m = Basemap(projection='merc', resolution=None,
            llcrnrlat=0, urcrnrlat=60,
            llcrnrlon=-20, urcrnrlon=150, )
#background type            
m.shadedrelief()

population_data = pd.read_excel(open('path/data_information.xlsx','rb'),sheet_name='plot')

#extract the data we're interested in population_data
lat = population_data['Lat'].values
lon = population_data['Lon'].values
ele_high = population_data['Ele'].values
area = population_data['Size'].values

m.scatter(lon, lat, latlon=True,
          c = ele_high, s = area * 20,
          cmap = 'RdYlGn_r', edgecolors = '#000000', linewidths= 0.6,
          alpha=1)

plt.colorbar(label=r'$Elevation({\rm m})$')

for a in [10, 20, 30]:
    plt.scatter([], [], c='k', alpha=1, s=a * 20,
                label=str(a) + 'Individuals')
plt.legend(scatterpoints=1, frameon=False,
           labelspacing=1, loc='lower left');
plt.show()