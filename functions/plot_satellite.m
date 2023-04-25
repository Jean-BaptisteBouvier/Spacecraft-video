% Function to plot the spacecraft
% Author: Jean-Baptiste Bouvier


function plot_satellite(spacecraft)

%%% Satellite sizing parameters
x_len = spacecraft.x_len;
y_len = spacecraft.y_len;
z_len = spacecraft.z_len;

%%% Satellite position
x = spacecraft.position(1);
y = spacecraft.position(2);
z = spacecraft.position(3);

%%% Satellite orientation
theta = spacecraft.orientation; % [deg] with respect to z


%%% Gold texture for the satellite
X_sat = x + [-1, 1]*x_len/2;
Y_sat = y + [-1; 1]*y_len/2;
for Z_sat = {(z + z_len/2)*ones(2,2), (z - z_len/2)*ones(2,2)}
    s = surf(X_sat, Y_sat, Z_sat{1}, 'CData', spacecraft.gold_texture, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
    rotate(s, [0 0 1], theta, [x y z])
end
Z_sat = z + [1, 1; -1, -1]*z_len/2;
for Y_sat = {y+[1; 1]*y_len/2, y-[1; 1]*y_len/2}
    s = surf(X_sat, Y_sat{1}, Z_sat, 'CData', spacecraft.gold_texture, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
    rotate(s, [0 0 1], theta, [x y z])
end
Y_sat = y + [1, -1]*y_len/2;
Z_sat = z + [1, -1; 1, -1]*z_len/2;
for X_sat = {x+[1, 1]*x_len/2, x-[1, 1]*x_len/2}
    s = surf(X_sat{1}, Y_sat, Z_sat, 'CData', spacecraft.gold_texture, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
    rotate(s, [0 0 1], theta, [x y z])
end


%%% Add solar panels
X_solar = x + [-1, 1]*spacecraft.x_solar_len/2;
Y_solar = y + y_len/2 + [0; 1]*spacecraft.y_solar_len;
Z_solar = z*ones(2,2);
s = surf(X_solar, Y_solar, Z_solar , 'CData', spacecraft.panel_texture, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
rotate(s, [0 0 1], theta, [x y z])

Y_solar = y - y_len/2 - [0; 1]*spacecraft.y_solar_len;
s = surf(X_solar, Y_solar, Z_solar , 'CData', spacecraft.panel_texture, 'FaceColor', 'texturemap', 'EdgeColor', 'none');
rotate(s, [0 0 1], theta, [x y z])


%%% Parameters for the thrusters
min_rad = spacecraft.min_rad; % minimal radius of the thrusters
max_rad = spacecraft.max_rad; % maximal radius of the thrusters
thruster_len = spacecraft.thruster_len; % length of the thrusters
thruster_in = spacecraft.thruster_in; % length of the thruster embedded in the satellite

%%% Creating thruster as a cone
[X_thruster, Y_thruster, Z_thruster] = cylinder([min_rad, max_rad]);
X_thruster = X_thruster + x;
Y_thruster = Y_thruster + y;
Z_thruster = Z_thruster*thruster_len + z - thruster_in;

thruster_1 = mesh(X_thruster, Y_thruster-y_len/2, Z_thruster+x_len/2, 'FaceColor',spacecraft.thruster_color(1,:),'EdgeColor','none');
rotate(thruster_1, [0 1 0], -90, [x,y,z])
rotate(thruster_1, [0 0 1], 45, [x-x_len/2,y-y_len/2,z])
rotate(thruster_1, [0 0 1], theta, [x,y,z])

thruster_2 = mesh(X_thruster, Y_thruster+y_len/2, Z_thruster+x_len/2, 'FaceColor',spacecraft.thruster_color(2,:),'EdgeColor','none');
rotate(thruster_2, [0 1 0], -90, [x,y,z])
rotate(thruster_2, [0 0 1], -45, [x-x_len/2,y+y_len/2,z])
rotate(thruster_2, [0 0 1], theta, [x,y,z])

thruster_3 = mesh(X_thruster, Y_thruster+y_len/2, Z_thruster+x_len/2, 'FaceColor',spacecraft.thruster_color(3,:),'EdgeColor','none');
rotate(thruster_3, [0 1 0], 90, [x,y,z])
rotate(thruster_3, [0 0 1], 45, [x+x_len/2,y+y_len/2,z])
rotate(thruster_3, [0 0 1], theta, [x,y,z])

thruster_4 = mesh(X_thruster, Y_thruster, Z_thruster+x_len/2, 'FaceColor',spacecraft.thruster_color(4,:),'EdgeColor','none');
rotate(thruster_4, [0 1 0], 90, [x,y,z])
rotate(thruster_4, [0 0 1], theta, [x,y,z])

thruster_5 = mesh(X_thruster, Y_thruster-y_len/2, Z_thruster+x_len/2, 'FaceColor',spacecraft.thruster_color(5,:),'EdgeColor','none');
rotate(thruster_5, [0 1 0], 90, [x,y,z])
rotate(thruster_5, [0 0 1], -45, [x+x_len/2,y-y_len/2,z])
rotate(thruster_5, [0 0 1], theta, [x,y,z])


%%% Add camera
camera_rad = spacecraft.camera_rad;
camera_len = spacecraft.camera_len;
[X_camera, Y_camera, Z_camera] = cylinder(camera_rad); % Define a cylinder for camera
camera = mesh(X_camera+x, Y_camera+y, Z_camera*camera_len+z+x_len/2, 'FaceColor', spacecraft.camera_color,'EdgeColor','none');
rotate(camera, [0 1 0], -90, [x,y,z])
rotate(camera, [0 0 1], theta, [x,y,z])

%%% Add lens in the camera
[X_lens, Y_lens, Z_lens] = sphere;
X_lens = X_lens*camera_rad*0.95 + x;
Y_lens = Y_lens*camera_rad*0.95 + y;
Z_lens = Z_lens*camera_rad*0.95 + z + camera_len - camera_rad/2;
lens = mesh(X_lens, Y_lens, Z_lens+x_len/2, 'FaceColor', spacecraft.lens_color, 'EdgeColor','none');
rotate(lens, [0 1 0], -90, [x,y,z])
rotate(lens, [0 0 1], theta, [x,y,z])




end