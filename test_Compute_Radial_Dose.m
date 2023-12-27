Head = [80, 100, 80, 0, 0, 0];
maximum = max(Head);
beam_diameter = 30;
peak = beam_diameter/4;
resolution = 1;

global radial_dose_function_table;
radial_dose_function_table = Compute_Radial_Dose(maximum, resolution, peak);
disp(radial_dose_function_table);