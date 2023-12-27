function point_dose_value = Compute_Point_Dose_from_All_Beams(point_of_interest)
    global beams;

    % Initialize the total dose to zero
    point_dose_value = 0;

    % Loop through all beams and sum the dose contributions
    for i = 1:length(beams)
        if beams(i).isSafe == true
            % Compute the dose from the current beam
            beam_dose = Compute_Point_Dose_from_Beam(point_of_interest, i);
        else
            continue
        end      
        % Add the beam's dose to the total dose
        point_dose_value = point_dose_value + beam_dose;
    end
end
