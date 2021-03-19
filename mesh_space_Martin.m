function  [rloc_1,rloc_2,r_tot,r_mm] = mesh_space_Martin(dr,r_i1,r_o1,r_o2)
%% Friday 11/11/2016
%
% This function is used to create the spacial mesh along
% the pressure vessel.
%
%   Inputs: Grid spacing along vessel, dr.
%
%   Outputs: Vector with all x-coordinates of the vessel. 
%%
rloc_1 = r_i1:dr:r_o1;
rloc_2 = r_o1:dr:r_o2;
r_tot = r_i1:dr:r_o2;
r_mm = r_i1*1000:dr*1000:r_o2*1000;

end

