function gridPoints = Create_Grid(center ...
    , radius, resolution)
%creates a 3D grid of points around PTV and OAR
    x_min = center(1) - radius;
    x_max = center(1) + radius;
    y_min = center(2) - radius;
    y_max = center(2) + radius;
    z_min = center(3) - radius;
    z_max = center(3) + radius;

    % Create the grid
    [X, Y, Z] = meshgrid(x_min:resolution:x_max, y_min:resolution:y_max, z_min:resolution:z_max);

    % Filter out points outside the PTV (for a spherical PTV)
    distances = sqrt((X - center(1)).^2 + (Y - center(2)).^2 + (Z - center(3)).^2);
    insidePTV = distances <= radius;

    gridPoints = [X(insidePTV), Y(insidePTV), Z(insidePTV)];
end
