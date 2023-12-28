helmet_diameter = 30;  
beam_separation_angle = 30; 
Head = [80, 100, 80, 0, 0, 0];

clear global beams;
global beams
beams = Compute_Beam_Directions(helmet_diameter, beam_separation_angle);

figure;
hold on;
axis equal;  % Ensure equal scaling for x, y, z axes
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
title('3D Beam Directions Visualization');
grid on;



% The code below was implemented using the help of chatgpt

for i = 1:length(beams)
    beam = beams(i);
    quiver3(0, 0, 0, beam.direction(1), beam.direction(2), beam.direction(3), ...
            'AutoScale', 'off', 'MaxHeadSize', 0.05);
end

