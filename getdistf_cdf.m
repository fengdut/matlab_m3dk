function [pphi,dpphi,pangle,dpangle,e,de,f,f0]=getdistf_cdf(filename)
 
ncid=netcdf.open(filename,'NC_NOWRITE');


id=netcdf.inqVarID(ncid,'pphi');
[varname,xtype,varDminIDs,varAtts]=netcdf.inqVar(ncid,id);
pphi=netcdf.getVar(ncid,id);
npphi=size(pphi);
npphi=npphi(1);
dpphi=(pphi(npphi)-pphi(1))/(npphi-1);
 
id=netcdf.inqVarID(ncid,'pangle');
[varname,xtype,varDminIDs,varAtts]=netcdf.inqVar(ncid,id);
pangle=netcdf.getVar(ncid,id);
npangle=size(pangle);
npangle=npangle(1);
dpangle=(pangle(npangle)-pangle(1))/(npangle-1);
 
id=netcdf.inqVarID(ncid,'e');
[varname,xtype,varDminIDs,varAtts]=netcdf.inqVar(ncid,id);
e=netcdf.getVar(ncid,id);
ne=size(e);
ne=ne(1);
de=(e(ne)-e(1))/(ne-1);
 
id=netcdf.inqVarID(ncid,'fpass');
[varname,xtype,varDminIDs,varAtts]=netcdf.inqVar(ncid,id);
f=netcdf.getVar(ncid,id);
 
id=netcdf.inqVarID(ncid,'ftrap');
[varname,xtype,varDminIDs,varAtts]=netcdf.inqVar(ncid,id);
f0=netcdf.getVar(ncid,id);

netcdf.close(ncid);
end
