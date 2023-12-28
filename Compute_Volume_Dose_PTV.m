function Compute_Volume_Dose_PTV(PTV)
    % Generate grid points around the PTV
    ptv_center = [PTV(2), PTV(3), PTV(4)];
    ptv_radius = PTV(1);
    gridResolution = 1;
    gridPoints = Create_Grid(ptv_center, ptv_radius, gridResolution);

    % Initialize an array to hold dose values
    doseValues = zeros(size(gridPoints, 1), 1);

    % Compute dose for each point in the grid
    for i = 1:size(gridPoints, 1)
        point = gridPoints(i, :);
        doseValues(i) = Compute_Point_Dose_from_All_Beams(point);
    end

    % Compute DVH
    [N, edges] = histcounts(doseValues, 'Normalization');

    % Plotting the DVH
    figure;
    plot(edges(1:end-1), N);
    xlabel('Dose');
    ylabel('Cumulative Volume');
    title('Cumulative Dose Volume Histogram for PTV');

end


