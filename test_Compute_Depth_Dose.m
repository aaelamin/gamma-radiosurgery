Head = [80, 100, 80, 0, 0, 0];
maxDepthFromSkin = max(Head) * 2;
d0 = 2;
depthFromSkinResolution = 1;

global depthDoseLUT;
depthDoseLUT = Compute_Depth_Dose(maxDepthFromSkin, d0, depthFromSkinResolution);
disp(depthDoseLUT)