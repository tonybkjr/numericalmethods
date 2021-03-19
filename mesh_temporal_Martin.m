function t = mesh_temporal_Martin(t_tot,dt)
%% Temporal Mesh
%
% This function 'mesh_temporal_Martin(t_tot,dt)' diescretizes the time domain from
% 0-T_tot. 
%
%   Inputs: Total desired time to analyze temperature distribution and
%   time step, dt. 
%
%   Outputs: Time vector, t.
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t = 0:dt:t_tot;
end

