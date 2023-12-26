Head = [80, 100, 80, 0, 0, 0];
maxDepthFromSkin = max(Head) * 2;
d0 = 2;
depthFromSkinResolution = 1;

global dose_absoroption_function_table;
dose_absoroption_function_table = Compute_Depth_Dose( d0, depthFromSkinResolution, maxDepthFromSkin);
disp(dose_absoroption_function_table)