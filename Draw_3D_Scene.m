
function Draw_3D_Scene(head, PTV, OAR, isocenter)
    figure;
    hold on;
    axis equal;
    grid on;

    % Plot the Head as an Ellipsoid
    [X, Y, Z] = ellipsoid(head(4), head(5), head(6), head(1), head(2), head(3));
    surf(X, Y, Z, 'FaceColor', 'none', 'EdgeColor', 'black', 'FaceAlpha', 0.05);

    % Plot the PTV as a Sphere
    [X, Y, Z] = sphere;
    X = PTV(1) * X + PTV(2);
    Y = PTV(1) * Y + PTV(3);
    Z = PTV(1) * Z + PTV(4);
    surf(X, Y, Z, 'FaceColor', 'green', 'FaceAlpha', 0.05);
    text(PTV(2), PTV(3), PTV(4), 'PTV', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'Color', 'black');

    % Plot the OAR as an Ellipsoid
    [X, Y, Z] = ellipsoid(OAR(4), OAR(5), OAR(6), OAR(1), OAR(2), OAR(3));
    surf(X, Y, Z, 'FaceColor', 'red', 'FaceAlpha', 0.05);
    text(OAR(4), OAR(5), OAR(6), 'OAR', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'Color', 'black');

    % Mark the Isocenter
    plot3(isocenter(1), isocenter(2), isocenter(3), "*");

    % Add Labels
    xlabel('X-axis');
    ylabel('Y-axis');
    zlabel('Z-axis');
    title('3D Scene with Head, PTV, OAR, and Isocenter');

    % The text code was generated using the help of chatGPT
end
