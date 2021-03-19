function [T,A_temp,q] = solver_Temp_Martin(dr,np,zeta_T,zeta_s,gamma_2_T,gamma_2_s,conductivity_s,conductivity_T,r_tot,r_o1,T_i,nt,T_inf,T_f,q,gamma,t,beta,idx6,idx7)
%% %%%%% Solver for Temperatures %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This function forms the A matrix and b vector to solve for the
% temperature vales throughout the pressure vessel.
%
%   Outputs: A matrix (coefficient matrix), q (heat source), and T, 
%            Temperature matrix. 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Form the A matrix
A_temp = zeros(np,np);
for i = 1:np
    if r_tot(1,i) <= r_o1
        zeta = zeta_T;
        gam = gamma_2_T;
    else
        zeta = zeta_s;
        gam = gamma_2_s;
    end
    
    if i == 1
        A_temp(i,i) = 1;
    elseif i == np  % Convecive boundary conditions.
        A_temp(i,i-2) = -conductivity_s;
        A_temp(i,i-1) = 4*conductivity_s;
        A_temp(i,i) = -3*conductivity_s - 2*dr*gamma;
        
    elseif r_tot(1,i) == r_o1           % Interface of the materials. Forward
        A_temp(i,i-2) = conductivity_T;      % difference on the steel and backward 
        A_temp(i,i-1) = -4*conductivity_T;   % difference on the tungsten.  
        A_temp(i,i)   = 3*(conductivity_T + conductivity_s); 
        A_temp(i,i+1) = -4*conductivity_s;
        A_temp(i,i+2) = conductivity_s;       
        
    else
        A_temp(i,i-1) = ((zeta)/r_tot(1,i))-(gam);
        A_temp(i,i)   = (2*gam)+1;
        A_temp(i,i+1) = -((gam)+((zeta)/r_tot(1,i)));
    end
end

%% Form the b vector to calculate temnperature %%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = zeros(np,nt+1);
T(:,1) = T_i;

for j = 1:nt
    q(j) = (T_f - T(1,j))*(1 - exp(-beta*t(1,j+1)));
    b = T(:,j);
    b(1,1) = T(1,j) + q(1,j);   %((T_f - T(1,j))*(1 - exp(-beta*(t(1,j+1)))));
    b(idx6,1) = 0;
    b(idx7,1) = -2*dr*gamma*T_inf;
    T(:,j+1) = A_temp\b;
%     if ((T(:,j+1)-T(:,j))/T(:,j+1))*100 < 0.01
%         break
%     end    
end
end
