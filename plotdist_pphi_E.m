function [pphi,fpphi,pangle,fpangle,e,fe]=plotdist_pphi_E(filename,j)
[pphi,dpphi,pangle,dpangle,e,de,fpass,ftrap]=getdistf_cdf(filename);


fpphi_e(1:size(pphi,1),1:size(e,1))=0;
fpphi_e0(1:size(pphi,1),1:size(e,1))=0;


clf;
set(gcf,'Units','points','position',[100 100 800 600],'Color',[1 1 1]);
hax=axes('Position',[0.14 0.14 0.75 0.75],'FontSize',24); 

[X,Y]=meshgrid(pphi,e);

size(pangle,1)

for i=1:size(pphi,1)
    for k=1:size(e,1);
        fpphi_pass(i,k)=fpass(k,j,i);
        fpphi_trap(i,k)=ftrap(k,j,i);        
    end
end

contour(X,Y,(fpphi_pass+fpphi_trap)',100);
xlabel('$P_\phi$','Interpreter','latex');
ylabel('$E$','Interpreter','latex');

titles=sprintf('$\\mu_0=%2.3f, \\Delta \\mu=%2.3f$',pangle(j),dpangle);
title(titles);

grid on;




