
function [R,Z,data]=plotm3dh5_f(filename,timeframe,dataid,N)
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


planeid=1;
nsteps=h5readatt(filename,'/','nsteps')

planes_no=h5read(filename,'/planes/values');
planes_no=planes_no(1)
atime=h5readatt(filename,'/','time')
atime=atime(timeframe);




dataname='/time_coordinates[0]/coordinates/values';
data_coordinates=h5read(filename,dataname);
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



datastr=sprintf('/time_node_data[%d]/',timeframe-1);
data_no=h5readatt(filename,datastr,'nnode_data');
info=h5info(filename,datastr);
data_title='';

data_title='';
for i=1:1:data_no
    data_titleV=h5readatt(filename,info.Groups(i).Name,'labels');
    data_title=sprintf('%s %d %s\n',data_title,i,data_titleV);
end
data_title


data_title=h5readatt(filename,info.Groups(dataid).Name,'labels');
    
datastr=sprintf('%s/values',info.Groups(dataid).Name);
data=h5read(filename,datastr);

tdata=reshape(data,cell_no,planes_no);


for pid=1:planes_no

data=tdata(:,pid);

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
% titlestring=sprintf('time=%4.2f, %s',atime,data_t);
% title(titlestring);

n=size(Z);
n=n(1);
j=1;

end;

tpp=1.0/double(planes_no);
mphi=2.0*3.1415926*(double(planes_no)-1.0)*tpp;
phi=linspace(0,mphi,planes_no);

% cfs(1:nr,1:planes_no)=0;
% cfc(1:nr,1:planes_no)=0;
% %Data_mid(1,:)=cos(phi);

cfs=(fft(tdata'));
    
clf;
set(gcf,'Units','points','position',[50 100 400 500],'Color',[1 1 1]);
hax3=axes('Position',[0.15 0.15 0.75 0.75],'FontSize',24); 

tdata=abs(cfs);
%tdata=real(cfs);

tri=delaunay(R,Z);

trisurf(tri,R,Z,tdata(N+1,:)','FaceColor','interp','EdgeColor','interp');
view(2);
xlabel('$R$');
ylabel('$Z$');


% xlim([0.3 2.5]);
% ylim([-2.3 2.3]);
%axis('equal');

% xlabel('$R$');
% 
% 
 titlestring=sprintf('time=%4.2f, %s',atime,data_t);
 title(titlestring);
%myprints(titlestring);


