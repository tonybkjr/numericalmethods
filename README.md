# numericalmethods
This is a repository for a project using finite difference methods in MATLAB that solves the spherical 1D heat equation for a spherical pressure vessel. 

There are 9 different MATLAB .m files in this repository. There is also a folder for the figures that were generated with the code. I have also created
a separate repository called "numericalmethods-LaTex" to house the LaTex files and the report for this project. You can download everything here and use it as you would like (https://github.com/tonybkjr/numericalmethods-LaTex). 

## Functions

The main file is called "OneD_CylindricalHeatConduction_Martin.m" and houses all of the main information for variables etc. There are 8 functions called within the 
main file and are given below:

1.		mesh_space_Martin.m	(This creates the spatial mesh for the analysis)
2.		mesh_temporal_Martin.m (This creates the temporal mesh for the analysis). 
3.		Index_Locator_Martin.m (This locates the indices for various values needed in the analysis).
4.		solver_Temp_Martin.m (This does the numerical solving for temperature distributions and the matrix).
5. 		solver_Stress_Martin.m (This numerically solves the stress matrix).
6.		solver_Displ_Martin.m (This numerical solves the displacement matrix).
7.		plot_temp_Martin.m (This plots the various temperature distributions).
8.		plot_Stress_Displ_Martin.m (This plots the various stresses and displacements).

This analysis incorporated various finited-difference schemes, all second order. Since the transient response was analyzed, an implicit BTCS method was used (the report can shed more light on the details). 
Most of the files have good commenting, however, there are some functions where commenting was left to a minimum. I can shed light on the details for these functions if needed. 

## Figures

Below are various figures that the MATLAB code will display after the main script has ran. They can also be found in the report for a more detailed explanation. 

![](https://github.com/tonybkjr/numericalmethods/blob/main/Images/TempDistribution.jpg)<br> </br>
*Temperature distribution throughout the pressure vessel at various times, starting at 10 s and going to 10,000 s.* <br> </br>

<img src="https://github.com/tonybkjr/numericalmethods/blob/main/Images/TempDistribution.jpg" width="500">
<img src="https://github.com/tonybkjr/numericalmethods/blob/main/Images/TempDistribution_Time.png" width="500">

<img scr="https://github.com/tonybkjr/numericalmethods/blob/main/Images/TempDistribution_Time.png" width="500">
*Temperature distribution at the inner radius and outer radius over time. The plot is a semilog plot.* <br> </br>

You can see that the temperature at the inner radius, which is closer to the heat source, increases much faster than the temperature of the outer radius. 

<img scr="https://github.com/tonybkjr/numericalmethods/blob/main/Images/Displacement_Time.png" width="500">
*Displacement at various radii over time. The outer radius expands significantly more than the inner radial locations.* <br> </br>

### Other Figures
<img scr="https://github.com/tonybkjr/numericalmethods/blob/main/Images/2D_TempDistribution.png" width="500">
<img scr="https://github.com/tonybkjr/numericalmethods/blob/main/Images/2D_RadialStress.png" width="500">
<img scr="https://github.com/tonybkjr/numericalmethods/blob/main/Images/2D_HoopStress.png" width="500">
