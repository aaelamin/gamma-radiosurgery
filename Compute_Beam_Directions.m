function beams = Compute_Beam_Directions(beam_separation_angle, beam_diameter)
% The function calculates the directional vectors for each pencil beam in a Gamma Knife helmet, based on specified helmet radius and beam separation angle.
%
% Inputs: beam_separation_angle - The angular separation between adjacent beams in degrees.
%         beam_diameter - The diameter of the Gamma Knife helmet
%         
% Output: beams - a structure that holds the information for several beams 

    % Initialize the array to store beam information
    global beams;

    % Iterate over latitudes and longitudes based on separation angle
    for latitude = -90:beam_separation_angle:90
        for longitude = -180:beam_separation_angle:180
     
           [x, y, z] = sph2cart(longitude, latitude, beam_diameter/2);

            % Normalize the direction vector
            unit_direction = [x, y, z] / norm([x, y, z]);

            % Store the information in the beams array
            beams = [beams; struct('longitude', longitude, 'latitude', latitude, 'direction', unit_direction)];
        end
    end
    
end

%https://www.mathworks.com/help/matlab/ref/sph2cart.html#d126e1515394