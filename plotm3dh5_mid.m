
function [R_mid,Data_mid]=plotm3dh5_mid(filename,planeid,timeframe,dataid)
%plotm3dh5_mid plot M3D hdf5 output data as 3D contour.
%plotm3dh5_mid('3d.001.h5'); plot the first variable at the first time step and
%the first plane at mid plane (Z=0).
%plotm3dh5_mid('3d.001.h5',1,1,9); plot the 9th variable at the first time step.
%the output [R_mid, Data_mid] is a R coordinate and variable ploted.
if(nargin<1)
    error('filename');
end
if(nargin<2)
    planeid=1                               %plane id
    dataid =1;                              %data id to plot
    timeframe=1;
else if(nargin<3)
    nargin
    error('filename, planeid, dataid');
    end
end

fileinfo = hdf5info(filename);
toplevel = fileinfo.GroupHierarchy;

nsteps=h5readatt(filename,'/','nsteps');

g_planes=toplevel.Groups(2);
g_coordinates=toplevel.Groups(2+timeframe);
g_node_data=toplevel.Groups(2+nsteps+timeframe);

atime=h5readatt(filename,'/','time');
atime=atime(timeframe);

planes_name=g_planes.Datasets.Name;
data_planes=hdf5read(filename,planes_name);
planes_no=data_planes(1)

coordinates_name=g_coordinates.Groups.Datasets.Name;

data_coordinates=hdf5read(filename,coordinates_name);
coordinates_X=data_coordinates(1,:);
coordinates_Y=data_coordinates(2,:);
coordinates_Z=data_coordinates(3,:);
cell_no=size(coordinates_X,2)/planes_no;

coordinates_X=reshape(coordinates_X,cell_no,planes_no);
coordinates_Y=reshape(coordinates_Y,cell_no,planes_no);
coordinates_Z=reshape(coordinates_Z,cell_no,planes_no);

X=coordinates_X(:,planeid);
Y=coordinates_Y(:,planeid);
Z=coordinates_Z(:,planeid);




data_group=g_node_data.Groups;
data_no=size(g_node_data.Groups,2);

data_title='';
for i=1:1:data_no
    data_titleV=hdf5read(data_group(i).Attributes(2));
    data_title=sprintf('%s %d %s\n',data_title,i,data_titleV.Data);
end
data_title


data_titleV=hdf5read(data_group(dataid).Attributes(2));
data_title=data_titleV.Data;
    
data_name=data_group(dataid).Datasets.Name;
data=hdf5read(filename,data_name);

data=reshape(data,cell_no,planes_no);
data=data(:,planeid);

X=double(X);
Y=double(Y);
R=(X.^2+Y.^2).^0.5;
Z=double(Z);

data=double(data);

ss=size(data_title);
ss=ss(2);
for i=1:1:ss
    if(data_title(i)==',')
        break
    end
end
    data_t(1:i-1)=data_title(1:i-1);
titlestring=sprintf('time=%4.2f, %s',atime,data_t);
title(titlestring);

global gR gZ gData;
gR=R;
gZ=Z;
gData=data;



n=size(Z);
n=n(1);
j=1;
for i=1:1:n
    if(abs(Z(i))<=1e-10)
        R_mid(j)=R(i);
        Data_mid(j)=data(i);
        j=j+1;
    end
end

plot(R_mid,Data_mid,'*','MarkerSize',6);
xlabel('$R$');

titlestring=sprintf('time=%4.2f, %s',atime,data_t);
title(titlestring);


