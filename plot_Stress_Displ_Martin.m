function plot_Stress_Displ_Martin(t,r_mm,r_i1,r_o2,D,S_rr,S_thth,np,idx,idx2,idx3,idx4,idx5,idx6,idx7)

D_2d = zeros(np,np);
S_rr_2d = zeros(np,np);		% Preallocates the radial stress matrix.
S_thth_2d = zeros(np,np);	% Preallocates the azimuthal stress matrix (theta). 
for i = 1:np
for j = 1:np
D_2d(i,j) = D(i,end);
S_rr_2d(i,j) = S_rr(i,end);
S_thth_2d(i,j) = S_thth(i,end);
end
end

%% Plot displacements at various times. 
a = figure(4);
plot(r_mm,D(:,idx));
hold on
grid on
plot(r_mm,D(:,idx2),':r','Linewidth',1.25);
plot(r_mm,D(:,idx3),'--','Linewidth',1.25);
plot(r_mm,D(:,idx4),'-.','Linewidth',1.25);
xlim([r_i1*1000 r_o2*1000]);
legend('t = 10 s','t = 100 s','t = 1000s','t = 5000 s','Location','northwest');
xlabel('Radius (mm)');
ylabel('Displacement (m)');
savefig(a,'Displacement.fig');
saveas(a,'Displacement.png','png');

b = figure(5);
semilogx(t,D(1,:));
hold on
grid on
semilogx(t,D(idx6,:),':b','Linewidth',1.25);
semilogx(t,D(idx7,:));
xlabel('Time (s)');
ylabel('Displacement (m)');
legend('r = 0 mm','r = 80 mm','r = 200 mm');
savefig(b,'Displacement_Time.fig');
saveas(b,'Displacement_Time.png','png');


r = linspace(r_i1*1000,r_o2*1000,np);
th = linspace(0,2*pi,np);
[TH,R] = meshgrid(th,r);
[X,Y] = pol2cart(TH,R);
% % Z = flipud(C);  

c = figure(6);
contourf(X,Y,D_2d); axis square
grid on
h = colorbar('northoutside');
set(get(h,'Title'),'String','Displacement (m)');
xlabel('Radius (mm)');
ylabel('Radius (mm)');
savefig(c,'2D_Displacement.fig');
saveas(c,'2D_Displacement.png','png');

%% %%%%%% Plot Stresses (S_rr & S_thth) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d = figure(7);
plot(r_mm,S_rr);
grid on
xlabel('Radius (mm)');
ylabel('Radial Stress (Pa)');
savefig(d,'S_rr.fig');
saveas(d,'S_rr.png','png');

e = figure(8);
contourf(X,Y,S_rr_2d); axis square
grid on
h = colorbar('northoutside');
set(get(h,'Title'),'String','Radial Stress (Pa)');
xlabel('Radius (mm)');
ylabel('Radius (mm)');
savefig(e,'2D_RadialStress.fig');
saveas(e,'2D_RadialStress.png','png');

f = figure(9);
plot(r_mm,S_thth);
grid on
% xlim([r_i1*1000 r_o2*1000]);
xlabel('Radius (mm)');
ylabel('Hoop Stress (Pa)');
savefig(f,'S_thth.fig');
saveas(f,'S_thth.png','png');

g = figure(10);
contourf(X,Y,S_thth_2d); axis square
grid on
h = colorbar('northoutside');
set(get(h,'Title'),'String','Hoop Stress (Pa)');
xlabel('Radius (mm)');
ylabel('Radius (mm)');
savefig(g,'2D_HoopStress.fig');
saveas(g,'2D_HoopStress.png','png');


end