function Compute_Surface_Dose_PTV(PTV)
%Essentially i am deviding PTV to patches using the "sphere" function and i
% am then computing the dose value from all beams to find which patch has
% the highest (hottest) and lowest(coldest) doses and their resprective
% coordinates
    [x, y, z] = sphere(30);
    x = PTV(1) * x + PTV(2);
    y = PTV(1) * y + PTV(3);
    z = PTV(1) * z + PTV(4);

    % Initialize matrix to store dose values at each point
    dose_values = zeros(size(x));
    [row, col] = size(x);

    % Initialize variables for hottest and coldest points
    hottest = -inf;
    coldest = inf;
    hottest_idx = [1, 1];
    coldest_idx = [1, 1];

    % Calculate dose at each point on the PTV surface
    for i = 1:row
        for j = 1:col
            point_of_interest = [x(i, j), y(i, j), z(i, j)];
            dose = Compute_Point_Dose_from_All_Beams(point_of_interest);
            dose_values(i, j) = dose;

            % Update hottest and coldest points
            if dose > hottest
                hottest = dose;
                hottest_idx = [i, j];
            end
            if dose < coldest
                coldest = dose;
                coldest_idx = [i, j];
            end
        end
    end

    %  coordinates of the hottest and coldest points
    max_point = [x(hottest_idx(1), hottest_idx(2)), y(hottest_idx(1), hottest_idx(2)), z(hottest_idx(1), hottest_idx(2))];
    min_point = [x(coldest_idx(1), coldest_idx(2)), y(coldest_idx(1), coldest_idx(2)), z(coldest_idx(1), coldest_idx(2))];
 
    % Code below was created using chatGPT
    figure;
    surf(x, y, z, dose_values, 'EdgeColor', 'none');
    colorbar;
    hold on;
    plot3(max_point(1), max_point(2), max_point(3), 'r*', 'MarkerSize', 10); % Mark hottest point
    plot3(min_point(1), min_point(2), min_point(3), 'b*', 'MarkerSize', 10); % Mark coldest point
    title('PTV Surface Dose Distribution');
    xlabel('X-axis');
    ylabel('Y-axis');
    zlabel('Z-axis');
    hold off;
end