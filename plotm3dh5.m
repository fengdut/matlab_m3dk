
function [data]=plotm3dh5(filename,planeid,timeframe,dataid)
%plotm3dh5 plot M3D hdf5 output data as 2D contour.
%plotm3dh5('3d.001.h5'); plot the first variable at the first time step and
%the first plane.
%plotm3dh5('3d.001.h5',1,1,9); plot the 9th variable at the first time step and
%the first plane.
%the output [data] is a 2D variable ploted.
if(nargin<1)
    error('filename');
end
if(nargin<2)
    planeid=1;                                  %plane id
    timeframe=1;                                %time frame
    dataid =1;                                  %data id to plot
else if(nargin<3)
    nargin
    error('filename, planeid,timeframe, dataid');
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
tri=delaunay(R,Z);


set(gcf,'Units','points','position',[50 100 500 800],'Color',[1 1 1]);
hax3=axes('Position',[0.14 0.1 0.8 0.8],'FontSize',20); 

trisurf(tri,R,Z,data,'FaceColor','interp','EdgeColor','interp');
view(2);
xlabel('$R$');
ylabel('$Z$');
%xlim([0.3 2.5]);
%ylim([-2.3 2.3]);
%axis('equal');

ss=size(data_title);
ss=ss(2);
for i=1:1:ss
    if(data_title(i)==',')
        break
    end
end
    data_t(1:i-1)=data_title(1:i-1);
titlestring=sprintf('$time=%4.2f, %s $',atime,data_t);
title(titlestring);

%set(gcf, 'PaperPositionMode','auto');
%filename_out=sprintf('%s_%s.png',filename,titlestring);
%print(gcf,filename_out,'-dpng','-r300');
%  set(gcf, 'Renderer', 'painters');
% filename_out=sprintf('%s_%s.eps',filename,titlestring);
% print(gcf,filename_out,'-depsc2');





