PTV = [15, 30, 0, 15];
OAR = [15, 25, 15, 0, 30, 45];
isocenter = [PTV(2), PTV(3), PTV(4)];

    % Call the function to compute beam safety flags
    Compute_Beam_Safety_Flags(OAR);

    global beams; % Assuming beams is updated with safety flags

    % Generate the OAR ellipsoid for plotting
    [X, Y, Z] = ellipsoid(OAR(4), OAR(5), OAR(6), OAR(1), OAR(2), OAR(3), 20);

    % Create a 3D plot
    figure;
    hold on;
    grid on;
    axis equal;
    xlabel('X-axis');
    ylabel('Y-axis');
    zlabel('Z-axis');
    title('Beam Safety Visualization');

    % Plot the OAR
    surf(X, Y, Z, 'FaceAlpha', 0.3, 'EdgeColor', 'none', 'FaceColor', 'red');

    % Plot the beams
    for i = 1:length(beams)
        beam = beams(i);
        if beam.isSafe
            % Safe beams in green
            color = 'g';
        else
            % Unsafe beams in red
            color = 'r';
        end
        % Extend the beam for visualization purposes
        extendedBeam = isocenter + 100 * beam.direction;
        plot3([isocenter(1), extendedBeam(1)], [isocenter(2), extendedBeam(2)], [isocenter(3), extendedBeam(3)], color);
    end

    % Mark the isocenter
    plot3(isocenter(1), isocenter(2), isocenter(3), 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');

    hold off;

