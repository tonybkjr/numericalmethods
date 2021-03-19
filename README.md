# numericalmethods
This is a repository for a project using finite difference methods in MATLAB that solves the spherical 1D heat equation for a spherical pressure vessel. 

There are 9 different MATLAB .m files in this repository. There is also a folder for the figures that were generated with the code. I have also created
a folder to house the LaTex files and the report for this project. You can download everything here and use it as you would like. 

The main file is called "OneD_CylindricalHeatConduction_Martin.m" and houses all of the main information for variables etc. There are 8 functions called within the 
main file and are given below:

i)		mesh_space_Martin.m				(This creates the spatial mesh for the analysis). 
ii)		mesh_temporal_Martin.m 			(This creates the temporal mesh for the analysis). 
iii)	Index_Locator_Martin.m			(This locates the indices for various values needed in the analysis). 
iv)		solver_Temp_Martin.m			(This does the numerical solving for temperature distributions and the matrix). 
v) 		solver_Stress_Martin.m 			(This numerically solves the stress matrix). 
vi)		solver_Displ_Martin.m 			(This numerical solves the displacement matrix). 
vii)	plot_temp_Martin.m 				(This plots the various temperature distributions). 
viii)	plot_Stress_Displ_Martin.m 		(This plots the various stresses and displacements). 

This analysis incorporated various finited-difference schemes, all second order. Since the transient response was analyzed, an implicit BTCS method was used (the report can shed more light on the details). 
Most of the files have good commenting, however, there are some functions where commenting was left to a minimum. I can shed light on the details for these functions if needed. 