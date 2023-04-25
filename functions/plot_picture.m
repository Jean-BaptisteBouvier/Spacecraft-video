% The chaser satellite takes a picture of the target satellite
% 
% Author: Jean-Baptiste Bouvier


function plot_picture(chaser, target)

x_chaser = chaser.position(1);
y_chaser = chaser.position(2);
z_chaser = chaser.position(3);


sat_dist = norm( chaser.position - target.position ); % distance between satellites
target_radius = 1.1*(target.y_solar_len + target.x_solar_len + target.y_len/2);

%%% Camera flash
[X_flash, Y_flash, Z_flash] = cylinder( [chaser.camera_rad, target_radius]); % Define a cone for the flash
X_flash = X_flash + x_chaser;
Y_flash = Y_flash + y_chaser;
Z_flash = Z_flash*sat_dist + chaser.x_len/2 + chaser.camera_len + z_chaser;
faint_scale = 0.9*(1-Z_flash); % transparency scale for the flash

flash = mesh(X_flash, Y_flash, Z_flash, 'FaceColor', 'white', 'EdgeColor','none', 'AlphaData', faint_scale, 'FaceAlpha','interp');
rotate(flash, [0 1 0], -90, chaser.position)
rotate(flash, [0 0 1], chaser.orientation, chaser.position)

end