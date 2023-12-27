function radial_dose_function_table = Compute_Radial_Dose(maximum, resolution, peak)
% Compute_Radial_Dose computes the radial dose function value according to the 
% Radial Dose Function
% The function creates a lookup table with depth dose values at specified resolutions.
%
% Inputs: maximum - the maximum depth to be considered for the lookup table (in mm)
%         peak - the highest point in the graph
%         Resolution - the incremental resolution for the table (in mm)
% Output: radial_dose_function_table - the generated lookup table with depth and dose values

    % Using the same logic as Compute_Depth_Dose we break the piecewise
    % function into 3 segments and compute find the linear equation for
    % each segment
    
    
    % Initialize the radial dose array
    numPoints = (2 * maximum / resolution) + 1;
    radialDose = zeros(2, numPoints);

    % Loop over the radial distances
    for i = -maximum:resolution:maximum
        index = (i + maximum) / resolution + 1;

        % Store the radial distance
        radialDose(1, index) = i;

        % Compute the dose based on the radial distance
        if i >= -peak && i <= peak
            % Maximum dose within the beam radius
            radialDose(2, index) = 1;
        elseif i >= -22.5 && i < -peak
            % Linearly decreasing dose outside the beam radius (negative side)
            radialDose(2, index) = solveLinearEq([-22.5, 0], [-peak, 1], i);
        elseif i > peak && i <= 22.5
            % Linearly decreasing dose outside the beam radius (positive side)
            radialDose(2, index) = solveLinearEq([peak, 1], [22.5, 0], i);
        else
            % Zero dose outside the specified range
            radialDose(2, index) = 0;
        end
    end

    % Transpose to get the lookup table
    radial_dose_function_table = radialDose';
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
    y1 = p1(2);
    x2 = p2(1);
    y2 = p2(2);
    
    % Calculate the slope (m) of the line
    m = (y2 - y1)/ (x2 - x1);
    
    % Calculate the y-intercept (b) of the line
    b = y1 - m * x1;
    
    % Calculate the y value for the given x
    y = m * x + b;
end