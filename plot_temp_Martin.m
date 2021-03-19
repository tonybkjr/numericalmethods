function plot_temp_Martin(np,t,r_mm,r_i1,r_o2,T_C,idx,idx2,idx3,idx4,idx5,idx6,idx7)
%% %%%%%% Temperature Plotter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function 'plot_temp_Martin' plots the temperature distribution of
% the spherical pressure vessel in the radial direction. 
%
%   Inputs: r-location along vessel wall (r_tot), temperature dist. matrix,
%   time vector, t, and idx (various ones) which just determines the index
%   with value nearest specified values.
%
%   Outputs: Temperature vs. Time plot, Temperature vs. Radial Location,
%   and a 2D Temperature vs. Radial Location plot for visualization
%   purposes. 
% 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C = zeros(np,np);
for i = 1:np
for j = 1:np
C(i,j) = T_C(i,end);
end
end
%% %%%%%% Plot Commands %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c = figure(1);
plot(r_mm,T_C(:,idx));
hold on
grid on
plot(r_mm,T_C(:,idx2),':r','Linewidth',1.25);
plot(r_mm,T_C(:,idx3),'--','Linewidth',1.25);
plot(r_mm,T_C(:,idx4),'-.','Linewidth',1.25);
xlim([r_i1*1000 r_o2*1000]);

legend('t = 10 s','t = 100 s','t = 1000s','t = 5000 s');
xlabel('Radius (mm)');
ylabel('Temperature ({\circ}C)');
savefig(c,'TempDistribution.fig');
saveas(c,'TempDistribution.png','png');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%% Temperature vs. Time %%%%%%%%%
% Plot the temperature disribution over time @ the inner and outer surfaces
% and the interface of the two materials. 
c = figure(2);
semilogx(t,T_C(1,:));
hold on
grid on
semilogx(t,T_C(idx6,:),':b','Linewidth',1.25);
semilogx(t,T_C(idx7,:));
xlim([min(t) max(t)]);
xlabel('Time (s)');
ylabel('Temperature ({\circ}C)');
legend('r = 0 mm','r = 80 mm','r = 200 mm');
savefig(c,'TempDistribution_Time.fig');
saveas(c,'TempDistribution_Time.png','png');

%% %%%%%%% 2D Contour Plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r = linspace(r_i1*1000,r_o2*1000,np);
th = linspace(0,2*pi,np);
[TH,R] = meshgrid(th,r);
[X,Y] = pol2cart(TH,R);
% [w,x,y] = sphere(size(r_tot,2)-1);

% Z = flipud(C);  
c = figure(3);
contourf(X,Y,C); axis square
grid on
h = colorbar('northoutside');
set(get(h,'Title'),'String','Temp ({\circ}C)');
xlabel('Radius (mm)');
ylabel('Radius (mm)');
savefig(c,'2D_TempDistribution.fig');
saveas(c,'2D_TempDistribution.png','png');


% % Plot the temperature distribution along the bar at different times (e.g.
% % 10s, 100s, 500s, 1000s)
% figure(1);
% plot(xloc,T(idx2,:));
% hold on
% plot(xloc,T(idx3,:),':','LineWidth',1.5);
% plot(xloc,T(idx4,:),'--','LineWidth',1.5);
% plot(xloc,T(idx5,:),'-.','LineWidth',1.5);
% legend('t = 10 s','t = 100 s','t = 500 s','t = 1000 s');
% xlabel('Distance Along Bar (m)');
% ylabel('Temperature (C)');
% 
% % Plot the tempearture distribution over time at x = 0.2 m.
% figure(2);
% plot(t,T(:,idx),'-. r','LineWidth',1.5);
% xlabel('Time (s)');
% ylabel('Tempearature (C)');
% legend('x = 0.2 m');
% 
% figure(3);
% plot(xloc,F(idx2,:));
% hold on
% plot(xloc,F(idx3,:),':','LineWidth',1.5);
% plot(xloc,F(idx4,:),'--','LineWidth',1.5);
% plot(xloc,F(idx5-1,:),'-.','LineWidth',1.5);
% legend('t = 10 s','t = 100 s','t = 500 s','t = 1000 s','Location','southeast');
% xlabel('Distance Along Bar (m)');
% ylabel('Heat Flux (W/m^2)');
end

