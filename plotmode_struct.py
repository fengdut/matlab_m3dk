#!/usr/bin/env python
#this is a script to read and plot M3D output hdf5 data
#example to use it:
#plotmode_struct.py hdf5filename        #get the hdf5 file basic information
#plotmode_struct.py hdf5filename time_id data_id plane_id #plot 2D data


from read_plot_m3d_hdf5_data import *
from sys import argv


if (len(argv)<2):
	print('Please input a hdf5 file name')
	exit()
hdf5file=argv[1]

print_hdf5_base_info(hdf5file)

if (len(argv)>4):
	time_id=int(argv[2])
	data_id=int(argv[3])
	plane_id=int(argv[4])
	plot_m3d_hdf5_2D(hdf5file,time_id,data_id,plane_id)

