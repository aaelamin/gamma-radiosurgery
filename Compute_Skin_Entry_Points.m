
function Compute_Skin_Entry_Points(isocenter, head)
    % To solve this function we take the same appraoch as
    % IntersectLineEllipsoid function where we intersect the beam (line)
    % with the ellipsoid (patients head)

    % To find the depth of the isocente we can find the vector resulting
    % from substarcting the computed skin entry point of the beam and the
    % isocenter
    
    global beams;  % Declare beams as a global variable

    % Iterate over each beam
    for i = 1:length(beams)
        % Define the line equation for the beam
        P = isocenter;  % Starting point of the beam
        v = beams(i).direction();  % Direction vector of the beam

        % Calculate the intersection of the beam with the ellipsoid
        [intersections, numIntersections] = IntersectLineEllipsoid(P, v, head(1), head(2), head(3));

        % Check for valid intersections and update the beam structure
        if numIntersections > 0
            beams(i).skinEntryPoint = intersections(1, :);  % Assuming the first intersection is the entry point
            beams(i).depthToIsocenter = norm(beams(i).skinEntryPoint - isocenter);
        else
            % Handle the case where there is no intersection
            beams(i).skinEntryPoint = [NaN, NaN, NaN];
            beams(i).depthToIsocenter = NaN;
        end
    end
end

