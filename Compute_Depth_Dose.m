function dose_absoroption_function_table = Compute_Depth_Dose(d0, resolution, maximum)
% Compute_Depth_Dose computes the depth dose value according to the Dose
% Absorption Function graph.
% The function creates a lookup table with depth dose values at specified resolutions.
%
% Inputs: maxDepthFromSkin - the maximum depth to be considered for the lookup table (in mm)
%         d0 - the maximum dose (unit dose at 2 cm depth)
%         depthFromSkinResolution - the incremental resolution for the table (in mm)
% Output: depthDoseLUT - the generated lookup table with depth and dose values

% Essentially we are to compute a piecewise function that is made up of two
% linear functions given by the provided graph.

% The first part of the piecewise function is between has the domain
% [0, 20] and the second one has the domain x =20 up to the size of the
% patient's head

    % Calculate the total number of points
    totalPoints = floor(maxDepthFromSkin / depthFromSkinResolution) + 1;

    % Pre-allocate the depthDose array
    depthDose = zeros(totalPoints, 2); % Rows for points, 2 columns for depth and dose

    % Iterate over each depth point and calculate the corresponding dose
    for index = 1:totalPoints
        currentDepth = (index - 1) * depthFromSkinResolution;
        
        % Assign the depth value to the first column
        depthDose(index, 1) = currentDepth;

        % Calculate and assign the dose value to the second column
        if currentDepth <= d0
            % Use the first linear function for depths up to d0
            depthDose(index, 2) = solveLinearEq([0,0],[20,1],currentDepth);
        else
            % Use the second linear function for depths beyond d0
            depthDose(index, 2) = solveLinearEq([20,1],[120,0.5],currentDepth);
        end
    end

    % The depthDose array is already in the correct format for the LUT
    dose_absoroption_function_table = depthDose;


end

function y = solveLinearEq(p1, p2, x )
% The function calculates the y-value for a given x-value based on a linear
% function defined by two point.
%
% Inputs: P1 - coordinates of the first point given in the form (x, y)
%         P2 - coordinates of the first point given in the form (x, y)
%         x - The x-value for which the y-value is to be calculated.
% Output: y -  the calculated y-value corresponding to the input x-value

    % Extract coordinates of the points
    x1 = p1(1);
    y1 = P1(2);
    x2 = p2(1);
    y2 = p2(2);
    
    % Calculate the slope (m) of the line
    m = (y2 - y1) / (x2 - x1);
    
    % Calculate the y-intercept (b) of the line
    b = y1 - m * x1;
    
    % Calculate the y value for the given x
    y = m * x + b;
end