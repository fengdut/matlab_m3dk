%read lost.dat from m3dk output
%function [t,Pphi,E,mu,x,y]=readlost(filename)
function [t,Pphi,E,mu,x,y]=readlost(filename)

fid=fopen(filename);

tn=100;
tnp=0;
nt=0;

while ~feof(fid)
    [tim,acount]=fread(fid,[1],'double');

    [np c]=fread(fid,[1],'int');
    if(acount==1)
    tnp=tnp+np;
    nt=nt+1;
    tim_a(nt)=tim;
    pno_a(nt)=np;
    else
        break
    end
    
    xyz=fread(fid,[6,np],'double');
    t(tnp-np+1:tnp)=tim;
    Pphi(tnp-np+1:tnp)=xyz(2,:);
    E(tnp-np+1:tnp)=xyz(3,:);
    mu(tnp-np+1:tnp)=xyz(4,:);
    x(tnp-np+1:tnp)=xyz(5,:);
    y(tnp-np+1:tnp)=xyz(6,:);
    

end





