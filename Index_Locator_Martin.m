function [idx,idx2,idx3,idx4,idx5,idx6,idx7] = Index_Locator_Martin(t,r_tot,r_o1,r_o2)
%% %%%%%% Friday 11/12/2016 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function 'Index_Locator_Martin' is used to find the index containing
% the specifie values to be used for plotting.
%
%   Inputs: Radial location (r_tot), distance to interface (r_o1), and
%   outer radius (r_o2).
%
%   Outpus: Index locations (idx, idx2, idx3, ...).
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The following 'vals' are times to be considered during the analysis (10 s, 100 s, etc.).
val = 10;
val2 = 100;
val3 = 1000;
val4 = 5000;
val5 = 10000;

% These commands will locate the index that the vals above are located for plotting in
% plotting functions. 

[~, idx] = min(abs(t - val));
[~, idx2] = min(abs(t - val2));
[~, idx3] = min(abs(t - val3));
[~, idx4] = min(abs(t - val4));
[~, idx5] = min(abs(t - val5));
[~, idx6] = min(abs(r_tot - r_o1));
[~, idx7] = min(abs(r_tot - r_o2));
end

