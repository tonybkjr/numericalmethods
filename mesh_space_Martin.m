function  [rloc_1,rloc_2,r_tot,r_mm] = mesh_space_Martin(dr,r_i1,r_o1,r_o2)
%% Saturday 10/22/2016
%
% This function "mesh_space(dx,L)" is used to create the spacial mesh along
% the bar, going from 0-L.
%
%   Inputs: Grid spacing along bar, dx, and length of the bar, L.
%
%   Outputs: Vector with all x-coordinates of the bar. 
%%
rloc_1 = r_i1:dr:r_o1;
rloc_2 = r_o1:dr:r_o2;
r_tot = r_i1:dr:r_o2;
r_mm = r_i1*1000:dr*1000:r_o2*1000;

end

