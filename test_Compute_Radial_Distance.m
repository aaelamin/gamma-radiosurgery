PTV = [15, 30, 0, 15];

% Point of interest on the lateral edge of the PTV
point_of_interest = [PTV(2), PTV(3), PTV(4)] + [PTV(1), 0, 0];  

% Beam index for the beam at 90 degrees latitude 
beam_index = 10;

radial_distance = Compute_Radial_Distance(point_of_interest, beam_index);

fprintf('Radial distance for beam at 90 degrees latitude to the point of interest: %f mm\n', radial_distance);