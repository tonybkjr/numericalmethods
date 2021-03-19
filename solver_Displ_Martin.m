function [A_Disp,D] = solver_Displ_Martin(T,T_i,r_tot,np,nt,nu_T,nu_s,alpha_T,alpha_s,dr,E_T,E_s,r_o1,idx6,idx7)
%% Monday 12/05/2016 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This function solves the displacement vector of the pressure vessel.
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A_Disp = eye( np );
phi_T = E_T/((1+nu_T)*(1-2*nu_T));
phi_s = E_s/((1+nu_s)*(1-2*nu_s));
Phi = phi_s/phi_T;

for i = 1:np
    if i == 1  % Boundary condition for inner surface where S_rr = 0. Uses forward differencing.
        A_Disp(i,i) = -3*(1 - nu_T) + 4*nu_T*(dr/r_tot(1,i));  %-3*(1-nu_T) + 4*nu_T*(dr/r_tot(1,i));
        A_Disp(i,i+1) = 4*(1 - nu_T);
        A_Disp(i,i+2) = -(1 - nu_T);                
    elseif i == np   % Boundary condition for outer surface where S_rr = 0. Uses backwards differencing.  
        A_Disp(i,i-2) = 1 - nu_s;
        A_Disp(i,i-1) = -4*(1 - nu_s);
        A_Disp(i,i) = 3*(1 - nu_s) + 4*nu_s*(dr/r_tot(1,i));
        idx7 = i;
    elseif r_tot(1,i) == r_o1  % Boundary condition for the interface of the materials, S_rr_T = S_rr_s.
        A_Disp(i,i-2) = 1 - nu_T;
        A_Disp(i,i-1) = -4*(1 - nu_T);
        A_Disp(i,i) = 3*(1 - nu_T) + 3*Phi*(1-nu_s) + 4*nu_T*dr/r_tot(1,i) - 4*nu_s*Phi*(dr/r_tot(1,i));
        A_Disp(i,i+1) = -4*Phi*(1 - nu_s);
        A_Disp(i,i+2) = Phi*(1 - nu_s);        
    else  % A matrix entries for the interior nodes
        A_Disp(i,i-1) = 2 - (2*(dr/r_tot(1,i)));
        A_Disp(i,i) = -4 - (4*(dr/r_tot(1,i))^2);
        A_Disp(i,i+1) = 2 + (2*(dr/r_tot(1,i)));
    end        
end


D = zeros(np,nt+1);
for i = 1:nt+1
    u = zeros(idx7,1);
    u(1,1) = 2*(1+nu_T)*alpha_T*(T(1,i) - T_i)*dr;    
    for j = 2:idx6-1
        u(j,1) = ((1+nu_T)/(1-nu_T))*alpha_T*dr*(T(j+1,i) - T(j-1,i));
    end
    for j = idx6+1:idx7-1
        u(j,1) = ((1+nu_s)/(1-nu_s))*alpha_s*dr*(T(j+1,i) - T(j-1,i));        
    end    
    u(idx7,1) = 2*(1+nu_s)*alpha_s*(T(idx7,i) - T_i)*dr;
    u(idx6,1) = (T(idx6,i) - T_i)*2*dr*(-Phi*(1+nu_s)*alpha_s + (1+nu_T)*alpha_T);
    D(:,i) = A_Disp\u;       
end
end
