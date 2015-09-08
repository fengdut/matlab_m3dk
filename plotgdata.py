#!/usr/bin/env python
#print ("this is a script to read and plot m3d gdata")

gdata=[]
i=0
gdatafile=open('gdatatime_all')
array = gdatafile.readlines()
num = len(array)
import numpy
returnMat = numpy.zeros((num,3))
index = 0
for line in array:
	line = line.strip()
	linelist = line.split()
	returnMat[index,:] = linelist[0:3]
	index +=1
#print(returnMat)

import matplotlib.pyplot as plt
import matplotlib
from matplotlib.pyplot import rc, figure, axes, plot, xlabel, ylabel, title, \
	grid, savefig, show
t = returnMat[:,0]
g = returnMat[:,1]
k = returnMat[:,2]
#print(t)

for it in range(0,len(t)):
	if(g[it]**2>1):
		g[it]=0

#plt.figure(figsize=(6,3.5),dpi=150)	
font ={	'size' : '18'}
rc('font',**font)

rc('font',**{'family':'sans-serif','sans-serif':['Computer Modern Roman']})
## for Palatino and other serif fonts use:
#rc('font',**{'family':'serif','serif':['Palatino']})
rc('text', usetex=True)

fig1=plt.figure(figsize=(8,8.5),)	

rect = fig1.patch
rect.set_facecolor('white')
plt.subplot(2,1,1)

plt.plot(t,g,'r.',markersize=2)
plt.xlabel(r'$t$')
plt.ylabel(r'$\gamma$')

ax=plt.subplot(2,1,2,axisbg='white')

plt.plot(t,k,'r.',markersize=2)
plt.xlabel('t')
plt.ylabel('kinetic energy')
ax.set_yscale('log')
ax.set_ylim([1.0e-11, 1.0e-5]);
#savefig('gplot.eps')
#savefig('gplot.pdf')
savefig('gplot.png',dpi=300)

#plt.show()


