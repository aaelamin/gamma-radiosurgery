Head = [80, 100, 80, 0, 0, 0];
maximum = max(Head)*2;
dmax = 2;
resolution = 1;

global dose_absoroption_function_table;

dose_absoroption_function_table = Compute_Depth_Dose( dmax, resolution, maximum);
disp(dose_absoroption_function_table)