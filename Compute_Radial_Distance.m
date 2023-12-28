function radial_distance = Compute_Radial_Distance(point_of_interest, beam_index)
% Inputs: point_of_interest -  a 3-dimensional vector representing the coordinates 
%                              of the point of interest.
%         beam_index - an integer representing the index of the specific
%                      beam within the array of beams.
% Output: depth_from_skin - a value representing the depth from the skin
%                           entry point of the beam to the point of interest.

    global beams
    % Extract the direction of the specified beam
    beam_direction = beams(beam_index).direction;

    % Assuming the beam originates from a standard point (like the center of the helmet)
    beam_origin = [30, 0, 15];

    % Vector from beam origin to the point of interest
    vector_to_point = point_of_interest - beam_origin;

    % Projection of vector_to_point onto beam_direction
    projection = dot(vector_to_point, beam_direction) * beam_direction / norm(beam_direction)^2;

    % The perpendicular vector from the beam to the point of interest
    perpendicular_vector = vector_to_point - projection;

    % Radial distance is the norm of the perpendicular vector
    radial_distance = norm(perpendicular_vector);
end