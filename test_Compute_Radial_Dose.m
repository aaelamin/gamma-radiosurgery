
maximum = 22.5;
beam_radius = 7.5;
resolution = 1;

global radial_dose_function_table;
radial_dose_function_table = Compute_Radial_Dose(maximum, resolution, peak);
disp(radial_dose_function_table);