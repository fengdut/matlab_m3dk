clear;
clf;


g1=load('gdatatime_all');
set(gcf,'Units','points','position',[100 200 1200 600],'Color',[1 1 1]);

% 
hax=axes('Position',[0.10 0.12 0.4 0.8],'FontSize',24,'FontName','Latex'); 

plot(g1(:,1),g1(:,2),'.','MarkerSize',1);
xlabel('$time$');
ylim([-0.01 0.01]);
ylabel('$growth~ rate $');
grid on;

n=500;
g2=g1(:,2);
sg=size(g2,1);
gave=sum(g2(sg-n:sg))/n

hax=axes('Position',[0.56 0.12 0.4 0.8],'FontSize',24); 
plot(g1(:,1),g1(:,3),'.','MarkerSize',1);
xlabel('$time$');
ylabel('$kinetic~ energy$');
grid on;


%myprint('gamma_kinetic');


