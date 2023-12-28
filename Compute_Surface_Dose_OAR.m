
function Compute_Surface_Dose_OAR(OAR)
% REshaping matracies of ellipsoid was suggested by chatGPT

    % Generate surface points of the OAR using the ellipsoid function
    [x, y, z] = ellipsoid(OAR(4), OAR(5), OAR(6), OAR(1), OAR(2), OAR(3), 30);
    
    % Reshape the grid for dose calculation
    x = reshape(x, [], 1);
    y = reshape(y, [], 1);
    z = reshape(z, [], 1);

    % Initialize a matrix to store dose values at each point
    dose_values = zeros(size(x));

    % Calculate dose at each point on the OAR surface
    for i = 1:length(x)
        point_of_interest = [x(i), y(i), z(i)];
        dose_values(i) = Compute_Point_Dose_from_All_Beams(point_of_interest);
    end

    % Reshape dose_values back for plotting
    dose_values = reshape(dose_values, size(x));

    % Find the hottest and coldest dose values and their locations
    max_dose = max(dose_values(:));
    min_dose = min(dose_values(:));
    [max_row, max_col] = find(dose_values == max_dose, 1);
    [min_row, min_col] = find(dose_values == min_dose, 1);
    max_point = [x(max_row, max_col), y(max_row, max_col), z(max_row, max_col)];
    min_point = [x(min_row, min_col), y(min_row, min_col), z(min_row, min_col)];

    % Plot the OAR with dose distribution
    figure;
    surf(x, y, z, dose_values, 'EdgeColor', 'none');
    colorbar;
    hold on;
    plot3(max_point(1), max_point(2), max_point(3), 'r*', 'MarkerSize', 10); % Mark max dose point
    plot3(min_point(1), min_point(2), min_point(3), 'b*', 'MarkerSize', 10); % Mark min dose point
    title('OAR Surface Dose Distribution');
    xlabel('X-axis');
    ylabel('Y-axis');
    zlabel('Z-axis');
    hold off;

end
