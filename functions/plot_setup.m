% Function to create the figure environment for the spacecraft
% 
% ref_traj: reference trajectory plotted entirely (green)
% traj: actual trajectory up to current state (blue)
% 
% 
% Author: Jean-Baptiste Bouvier


function plot_setup(ref_traj, traj, sat, sat_2)

%%% Radius of the first satellite with 10% margin
sat_radius = 1.1*(sat.y_solar_len + sat.x_solar_len + sat.y_len/2);
%%% Radius of the second satellite with 10% margin
sat_2_radius = 1.1*(sat_2.y_solar_len + sat_2.x_solar_len + sat_2.y_len/2);

%%% Define plot limits based on both satellite locations
x_min = min(sat.position(1)-sat_radius, sat_2.position(1)-sat_2_radius);
x_max = max(sat.position(1)+sat_radius, sat_2.position(1)+sat_2_radius);
y_min = min(sat.position(2)-sat_radius, sat_2.position(2)-sat_2_radius);
y_max = max(sat.position(2)+sat_radius, sat_2.position(2)+sat_2_radius);
z_min = min(sat.position(3)- sat_radius, sat_2.position(3)- sat_2_radius);
z_max = max(sat.position(3)+ sat_radius, sat_2.position(3)+ sat_2_radius);


% %%% Define plot limits based on trajectory
% x_min = traj(1,end) - xy_radius; x_max = traj(1,end) + xy_radius;
% y_min = traj(2,end) - xy_radius; y_max = traj(2,end) + xy_radius;
% z_min = traj(3,end) - z_radius; z_max = traj(3,end) + z_radius;

% %%% Define plot limits based on trajectory and satellite size
% x_min = min(ref_traj(1,:)) - xy_radius; x_max = max(ref_traj(1,:)) + xy_radius;
% y_min = -xy_radius; y_max = max(ref_traj(2,:)) + xy_radius;
% z_min = min(ref_traj(3,:)) - z_radius; z_max = max(ref_traj(3,:)) + z_radius;


figure; hold on; grid on; axis equal;
set(gcf, 'Position',  [10, 40, 1900, 950])
xlabel('X (m)'); 
ylabel('Y (m)'); 
set(gca,'ZTick',[])
set(gca, 'FontSize', 14)
view(75, 30); % set the viewpoint


%%% Plots the entire reference trajectory
plot3(ref_traj(1,:), ref_traj(2,:), ref_traj(3,:), 'Color', 'green', 'LineWidth', 2)
%%% Plots the actual trajectory up to current location
plot3(traj(1,:), traj(2,:), traj(3,:), 'Color', 'blue', 'LineWidth', 2)

%%% Space background
surf([x_min x_max], [y_min y_max], z_min*ones(2,2), 'CData', sat.space, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
surf([x_min x_max], [y_max y_max], [z_min, z_min; z_max, z_max] , 'CData', sat.space, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
surf([x_min x_min], [y_min y_max], [z_min, z_max; z_min, z_max] , 'CData', sat.space, 'FaceColor', 'texturemap', 'EdgeColor', 'none');


xlim([x_min x_max])
ylim([y_min y_max])
zlim([z_min z_max])

end