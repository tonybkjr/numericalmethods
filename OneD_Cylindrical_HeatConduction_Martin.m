%% %%%%% Wednesday 11/09/2016 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This Matlabe file is used to evaluate the transient heat conduction
% response of a spherical vessel, with the governing equation:
%                   T_t = D[(2/r)T_r + T_rr]                            (1)
% where: T_t is the partial of T wrt time, T_r is the partial of T wrt
% radius r, and T_rr is the second PD of T wrt r, and D is the thermal
% diffusivity of the material. This is the simplified version of the 
% original equation PDE.
% 
% The mechanical response to the thermal changes is also observed using the
% following equation for displacements:
%          ((1+nu)/(1-nu))*alpha*T_r = d/dr[(1/r^2)*d/dr(r^2u)]         (2)
% where: T_r is the partial of T wrt radius, and the other differentiating
% terms are wrt radius (displacements and radius). The temperature
% distribution is input as a body force for the mechanical section to
% determine displacements, stresses, and strains.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; close all; clear all;

%% Material Properties %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
E_T = 620e9;  % Young's Modulus of Tungsten Carbide [GPa].
E_s = 210e9;  % Young's Modulus of Steel [GPa].
nu_T = 0.2; % Poisson's Ratio of Tungsten Carbide.
nu_s = 0.3; % Poisson's Ratio of Steel.
Cp_s = 490;  % Specific heat of steel [J/kg-K].
Cp_T = (292+184)/2; % Avg. Specific heat of Tungsten Carbide [J/kg-K].
rho_s = 7850; % Density of steel [kg/m^3].
rho_T = 15500;  % Density of Tungsten Carbide [kg/m^3]. 
conductivity_s = 43;     % Thermal conductivity of steel [W/m-K].
conductivity_T = 100; % Thermal conductivity of Tungsten Carbide [W/m-K].
alpha_s = 12e-6;   % Coefficient of linear thermal expansion (Steel) [K^-1].
alpha_T = 4.5e-6;   % Coefficient of linear thermal expansion (Tungsten Carbide) [K^-1].
gamma = 200;    % Convective heat transfer coefficient [W/m^2-K].
D_s = conductivity_s/(rho_s*Cp_s); % Thermal diffusivity of material 2 (steel) [m^2/s]. 
D_T = conductivity_T/(rho_T*Cp_T);  % Thermal diffusivity of Tungsten Carbide [m^2/s].
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%% Dimensions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r_i1 = 0.070;  % Inner radius of material 1 (Tungsten carbide) [mm].
r_o1 = 0.080;  % Outer radius of material 1 [mm].
r_i2 = r_o1;  % Inner radius of material 2 (Steel) [mm].
r_o2 = .200; % Outer radius of material 2 [mm].

%% %%%%% Initial Conditions and BCs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T_f = 573;  %300;  
T_i = 293; %20;   % Initial temperature of the vessel [C].
T_inf = 303;  % 30; % Ambient temperaure surrounding the vessel [C].
beta = 10;  % Frequency of heat generation [1/s].

%% %%%%% Temporal Mesh %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t_tot = 5000;   % total time [s].
nt = 10000;   % number of time-steps.
dt = t_tot/nt;  % time between steps [s].

% Call the temporal mesh function to set up time vector. 
t = mesh_temporal_Martin(t_tot,dt);

%% %%%%% Spacia;l Mesh %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nr = 500;    % Total number of nodes in the radial direction.
dr = r_o2/nr;   % Grid spacing in the radial direction [mm].
J = nr - 2; 
if nr < 60
    error('Choose another number of radial nodes "nr" (preferrably 100 nodes or more)')
end

zeta_T = (D_T*dt)/dr;     % Emperical parameter [m].
zeta_s = (D_s*dt)/dr;
gamma_2_T = (D_T*dt)/(dr)^2;
gamma_2_s = (D_s*dt)/(dr)^2;

% Call the spacial mesh function to set up the grid spacing vector. 
[rloc_1,rloc_2,r_tot,r_mm] = mesh_space_Martin(dr,r_i1,r_o1,r_o2);
np = size(r_tot,2);
q = zeros(1,nt);   % preallocate the heat source vector.

%% %%%%% Functions: Sovlvers, Plotters, etc. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This function locates the indices with the specified values.
[idx,idx2,idx3,idx4,idx5,idx6,idx7] = Index_Locator_Martin(t,r_tot,r_o1,r_o2);

% Function that forms the A matrix and solves for the Temperature.
[T,A_temp,q] = solver_Temp_Martin(dr,np,zeta_T,zeta_s,gamma_2_T,gamma_2_s,conductivity_s,conductivity_T,r_tot,r_o1,T_i,nt,T_inf,T_f,q,gamma,t,beta,idx6,idx7);
T_C = T-273;    % Convert temperature to degrees Celsius.

% This function forms the A matrix and solves for the Displacements. 
[A_Disp,D] = solver_Displ_Martin(T,T_i,r_tot,np,nt,nu_T,nu_s,alpha_T,alpha_s,dr,E_T,E_s,r_o1,idx6,idx7);

% This function solves for the radial and hoop stresses. 
[S_rr,S_thth] = solver_Stress_Martin(D,T,T_i,E_T,E_s,nu_T,nu_s,alpha_T,alpha_s,dr,np,r_tot,r_o1);

% This function plots temperature.
plot_temp_Martin(np,t,r_mm,r_i1,r_o2,T_C,idx,idx2,idx3,idx4,idx5,idx6,idx7)

% This function plots the displacements and stresses. 
plot_Stress_Displ_Martin(t,r_mm,r_i1,r_o2,D,S_rr,S_thth,np,idx,idx2,idx3,idx4,idx5,idx6,idx7);