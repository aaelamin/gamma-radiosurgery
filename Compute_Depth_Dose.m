function dose_absoroption_function_table = Compute_Depth_Dose(dmax, resolution, maximum)
% Compute_Depth_Dose computes the depth dose value according to the Dose
% Absorption Function graph.
% The function creates a lookup table with depth dose values at specified resolutions.
%
% Inputs: maximum - the maximum depth to be considered for the lookup table (in mm)
%         dmax - the maximum dose (unit dose at 2 cm depth)
%         Resolution - the incremental resolution for the table (in mm)
% Output: dose_absoroption_function_table - the generated lookup table with depth and dose values

% Essentially we are to compute a piecewise function that is made up of two
% segments of linear functions given by the graph.

% The first part of the piecewise function is between has the domain
% [0, 20] and the second one has the domain x =20 up to the size of the
% patient's head

 % Create a vector of depths from 0 to maximum with the given resolution
    depths = 0:resolution:maximum;

    % Preallocate the dose array
    doses = zeros(size(depths));

    % Iterate through each depth and calculate the corresponding dose
    for i = 1:length(depths)
        depth = depths(i);

        % Apply the first linear equation for depths up to d0
        if depth <= dmax
            doses(i) = solveLinearEq([0,0.5], [20,1], depth);
        % Apply the second linear equation for depths greater than d0
        else
            doses(i) = solveLinearEq([20,1], [120,0.5], depth);
        end
    end

    % Combine depths and doses into a two-column table
    dose_absoroption_function_table = [depths; doses]';
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