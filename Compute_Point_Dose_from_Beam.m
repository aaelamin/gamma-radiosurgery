function point_dose_value = Compute_Point_Dose_from_Beam(point_of_interest, beam_index)
    global dose_absoroption_function_table
    global radial_dose_function_table


    depth_from_skin = Compute_Depth_from_Skin(point_of_interest, beam_index);
    radial_distance = Compute_Radial_Distance(point_of_interest, beam_index);

    % Loop through dose_absorption_function_table to find the closest DAF value
    for i = 1:size(dose_absoroption_function_table, 1)
        if dose_absoroption_function_table(i, 1) >= depth_from_skin
            DAF_value = dose_absoroption_function_table(i, 2);
            break; 
        end
    end

    for i = 1:size(radial_dose_function_table, 1)
        if radial_dose_function_table(i, 1) >= radial_distance
            RDF_value = radial_dose_function_table(i, 2);
            break; % Exit the loop once the closest value is found
        end
    end

    % Compute the point dose value
    point_dose_value = 0.10 * DAF_value * RDF_value;


end