global beams;
head = [80, 100, 80, 0, 0, 0];
PTV = [15, 30, 0, 15];
isocenter = [PTV(2), PTV(3), PTV(4)];
Compute_Skin_Entry_Points(isocenter, head);

% Create a 3D visualization
figure;
hold on;
axis equal;
grid on;
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
title('Beam Skin Entry Points Visualization');

% Plot the head
[X, Y, Z] = ellipsoid(head(4), head(5), head(6), head(1), head(2), head(3));
surf(X, Y, Z, 'FaceColor', 'none', 'EdgeColor', 'black', 'FaceAlpha', 0.05);

% Plot beams and skin entry points
for i = 1:length(beams)
    % Draw beam line (simplified as line from isocenter to skin entry point)
    plot3([isocenter(1), beams(i).skinEntryPoint(1)], ...
          [isocenter(2), beams(i).skinEntryPoint(2)], ...
          [isocenter(3), beams(i).skinEntryPoint(3)], 'r-');
    
    % Mark skin entry point
    plot3(beams(i).skinEntryPoint(1), beams(i).skinEntryPoint(2), beams(i).skinEntryPoint(3), ...
          'bo', 'MarkerSize', 6, 'MarkerFaceColor', 'b');
end

hold off;