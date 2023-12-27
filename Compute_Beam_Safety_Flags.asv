function Compute_Beam_Safety_Flags( OAR, isocentre)
    % I divided the OAR into Patches using the ellipsoid function and I
    % checked if the beam intersects the ellipsoid.
    % if there is a intersection, then the beam is unsafe and it is safe if
    % it doeasnt
    
    global beams; % Declare beams as a global variable

    % Generate the OAR ellipsoid surface
    [X, Y, Z] = ellipsoid(OAR(4), OAR(5), OAR(6), OAR(1), OAR(2), OAR(3));
    % Iterate over each beam
    for i = 1:length(beams)
        direction_vector = beams(i).direction;
        beams(i).isSafe = true;
        % Check if the beam intersects with the OAR ellipsoid
        [~, numIntersections] = IntersectLineEllipsoid(isocentre, direction_vector, X, Y, Z);
        if numIntersections > 0
            beams(i).isSafe = false;
        end
    end
end

