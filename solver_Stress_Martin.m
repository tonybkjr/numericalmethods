function [S_rr,S_thth] = solver_Stress_Martin(D,T,T_i,E_T,E_s,nu_T,nu_s,alpha_T,alpha_s,dr,np,r_tot,r_o1)
%% Solver for Stresses%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function 'solver_Stress_Martin' calculates the radial and Hoop
% stresses for the spherical pressure vessel using the following equations:
%
%   S_thth = psi[nu*du/dr + u/r - (1+nu)*alpha*(T - To)]................(1)
%
%   S_rr = psi[(1-nu)*du/dr + 2*nu*(u/r) - (1+nu)*alph*(T - To).........(2)
%
% Forward and backwards finite differencing are used for the inner and
% outer surfaces respectively to calculate stresses for S_thth, while
% S_rr = 0 at the inner and outer surfaces.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


psi_T = E_T/((1+nu_T)*(1-2*nu_T));  % Simplify equation. 
psi_s = E_s/((1+nu_s)*(1-2*nu_s));

S_rr = ones(np,1);      % Preallocates radial stress vector.
S_thth = ones(np,1);    % Preallocates Hoop Stress vector. 
for i = 1:np
    if i == r_o1        % For second material (Steel).
        psi = psi_s;
        nu = n_s;
        alpha = alpha_s;
    else                % For first material (Tungsten Carbide).
        psi = psi_T;
        nu = nu_T;
        alpha = alpha_T;
    end
    
   if i == 1        % Sets up inner surface stresses (For Diff for S_thth).
        S_rr(i,1) = 0;
        S_thth(i,1) = psi*(nu*((-3*D(i,end) + 4*D(i+1,end) - D(i+2,end))/2*dr)...
            + D(i,end)/r_tot(1,i) - (1-nu)*alpha*(T(i+1,end) - T_i));
        
    elseif i == np  % Sets up outer surface stresses (Back Diff for S_thth). 
        S_rr(i,1) = 0;
        S_thth(i,1) = psi*(nu*((3*D(i,end) - 4*D(i-1,end) + D(i-2,end))/2*dr)...
            + D(i,end)/r_tot(1,i) - (1-nu)*alpha*(T(i,end) - T_i));
        
   else             % For all other interior nodes (centered differencing).
        S_rr(i,1) = -psi*((1-nu)*((D(i+1,end) - D(i-1,end))/2*dr) +...
            2*nu*(D(i,end)/r_tot(1,i)) - (1+nu)*alpha*(T(i,end) - T_i));
        
        S_thth(i,1) = psi*(nu*((D(i+1,end) - D(i-1,end))/dr) + D(i,end)/r_tot(1,i)...
            - (1-nu)*alpha*(T(i,end) - T_i));
    end 
end
end

