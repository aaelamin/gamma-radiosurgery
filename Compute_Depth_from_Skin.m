function depth_from_skin = Compute_Depth_from_Skin(point_of_interest, beam_index)
% Inputs: point_of_interest -  a 3-dimensional vector representing the coordinates 
%                              of the point of interest.
%         beam_index - an integer representing the index of the specific
%                      beam within the array of beams.
% Output: depth_from_skin - a value representing the depth from the skin
%                           entry point of the beam to the point of interest.

    global beams;
    beam_direction = beams(beam_index).direction;
    
    % Assuming the origin is at the center of the head and beams are directed inwards,
    % compute the skin entry point for the beam. This assumes a spherical head model.
    helmet_radius = norm(point_of_interest);  % This should be consistent with how beams were generated
    skin_entry_point = -helmet_radius * beam_direction;

    % Calculate the vector from the skin entry point to the point of interest
    vector_to_point = point_of_interest - skin_entry_point;

    % Project this vector onto the beam direction to find the depth
    % Depth is the component of vector_to_point along beam_direction
    depth_from_skin = dot(vector_to_point, beam_direction) / norm(beam_direction);

end   
