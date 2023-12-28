
function Compute_Volume_Dose_OAR(OAR) 
%same appraoch as question 14
    OAR_center = [OAR(4), OAR(5), OAR(6)];
    OAR_radii = [OAR(1), OAR(2), OAR(3)];
    resolution = 1;

    % Create a grid around the OAR
    gridPoints = CreateGridAroundOAR(OAR_center, OAR_radii, resolution);

    % Initialize an array to hold dose values
    doseValues = zeros(size(gridPoints, 1), 1);

    % Compute dose for each point in the grid
    for i = 1:size(gridPoints, 1)
        doseValues(i) = Compute_Point_Dose_from_All_Beams(gridPoints(i, :));
    end

    % Compute DVH
    edges = linspace(0, D100, 11); % Create edges from 0 to D100 in 10% increments
    [N, edges] = histcounts(doseValues, edges, 'Normalization');

    % Plotting the DVH
    figure;
    plot(edges(1:end-1), N);
    xlabel('Dose');
    ylabel('Cumulative Volume');
    title('Cumulative Dose Volume Histogram for OAR');

end

function gridPoints = CreateGridAroundOAR(oar_center, oar_radii, resolution)
    % Adjusted the code from Create Grid to fit ellipsoid
    % Method is attached to pdf file
    x_min = oar_center(1) - oar_radii(1);
    x_max = oar_center(1) + oar_radii(1);
    y_min = oar_center(2) - oar_radii(2);
    y_max = oar_center(2) + oar_radii(2);
    z_min = oar_center(3) - oar_radii(3);
    z_max = oar_center(3) + oar_radii(3);

    % Create the grid
    [X, Y, Z] = meshgrid(x_min:resolution:x_max, y_min:resolution:y_max, z_min:resolution:z_max);

    % Filter out points outside the OAR (ellipsoid)
    distances = ((X - oar_center(1)).^2 / oar_radii(1)^2) + ((Y - oar_center(2)).^2 / oar_radii(2)^2) + ((Z - oar_center(3)).^2 / oar_radii(3)^2);
    insideOAR = distances <= 1; % Inside ellipsoid condition

    % Store grid points inside the OAR
    gridPoints = [X(insideOAR), Y(insideOAR), Z(insideOAR)];
end
