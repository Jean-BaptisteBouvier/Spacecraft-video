% Plot the plumes of each thrusters with length proportional to each thrust
% signals
% 
% Author: Jean-Baptiste Bouvier

function plot_thrust(spacecraft, thrust)

%%% Satellite sizing parameters
x_len = spacecraft.x_len;
y_len = spacecraft.y_len;

%%% Satellite position
x = spacecraft.position(1);
y = spacecraft.position(2);
z = spacecraft.position(3);

%%% Satellite orientation
theta = spacecraft.orientation; % [deg] with respect to z

%%% Thrusters parameters
min_rad = spacecraft.min_rad; % minimal radius of the thrusters
max_rad = spacecraft.max_rad; % maximal radius of the thrusters
thruster_len = spacecraft.thruster_len; % length of the thrusters

%%% Plume parameters
plume_len = spacecraft.plume_len;
faint_plume_len = spacecraft.faint_plume_len;

%%% Thrust
u_1 = thrust(1);
u_2 = thrust(2);
u_3 = thrust(3);
u_4 = thrust(4);
u_5 = thrust(5);

%%% Main thruster plume
[X_plume, Y_plume, Z_plume] = cylinder([(min_rad+max_rad)/2, 0]); % Define a cone for the plume
X_plume = X_plume + x;
Y_plume = Y_plume + y;
Z_plume = Z_plume*plume_len;
plume_scale = 1-Z_plume; % transparency scale for the main plume
plume_offset = z + thruster_len/2 + x_len/2;


%%%%%%%%%%%% Thruster 1 %%%%%%%%%%%%%%

Z_plume_1 = Z_plume*u_1 + plume_offset;
plume_1 = mesh(X_plume, Y_plume-y_len/2, Z_plume_1, 'FaceColor','white','EdgeColor','none', 'AlphaData', plume_scale, 'FaceAlpha','interp');
rotate(plume_1, [0 1 0], -90, [x,y,z])
rotate(plume_1, [0 0 1], 45, [x-x_len/2,y-y_len/2,z])
rotate(plume_1, [0 0 1], theta, [x,y,z])

%%% Faint thruster plume
[X_faint_plume, Y_faint_plume, Z_faint_plume] = cylinder( [(min_rad+max_rad)/2, (1+2*u_1)*(min_rad+max_rad)/2]); % Define a cone for the faint plume
X_faint_plume = X_faint_plume + x;
Y_faint_plume = Y_faint_plume + y;
Z_faint_plume = Z_faint_plume*faint_plume_len;
faint_scale = 0.3*(1-Z_faint_plume); % transparency scale for the faint plume

Z_faint_plume_1 = Z_faint_plume*u_1 + plume_offset;
faint_plume_1 = mesh(X_faint_plume, Y_faint_plume-y_len/2, Z_faint_plume_1, 'FaceColor',spacecraft.plume_color(1,:),'EdgeColor','none', 'AlphaData', faint_scale, 'FaceAlpha','interp');
rotate(faint_plume_1, [0 1 0], -90, [x,y,z])
rotate(faint_plume_1, [0 0 1], 45, [x-x_len/2,y-y_len/2,z])
rotate(faint_plume_1, [0 0 1], theta, [x,y,z])



%%%%%%%%%%% Thruster 2 %%%%%%%%%%%

Z_plume_2 = Z_plume*u_2 + plume_offset;
plume_2 = mesh(X_plume, Y_plume+y_len/2, Z_plume_2, 'FaceColor','white','EdgeColor','none', 'AlphaData', plume_scale, 'FaceAlpha','interp');
rotate(plume_2, [0 1 0], -90, [x,y,z])
rotate(plume_2, [0 0 1], -45, [x-x_len/2,y+y_len/2,z])
rotate(plume_2, [0 0 1], theta, [x,y,z])

%%% Faint thruster plume
[X_faint_plume, Y_faint_plume, Z_faint_plume] = cylinder( [(min_rad+max_rad)/2, (1+2*u_2)*(min_rad+max_rad)/2]); % Define a cone for the faint plume
X_faint_plume = X_faint_plume + x;
Y_faint_plume = Y_faint_plume + y;
Z_faint_plume = Z_faint_plume*faint_plume_len;
faint_scale = 0.3*(1-Z_faint_plume); % transparency scale for the faint plume

Z_faint_plume_2 = Z_faint_plume*u_2 + plume_offset;
faint_plume_2 = mesh(X_faint_plume, Y_faint_plume+y_len/2, Z_faint_plume_2, 'FaceColor',spacecraft.plume_color(2,:),'EdgeColor','none', 'AlphaData', faint_scale, 'FaceAlpha','interp');
rotate(faint_plume_2, [0 1 0], -90, [x,y,z])
rotate(faint_plume_2, [0 0 1], -45, [x-x_len/2,y+y_len/2,z])
rotate(faint_plume_2, [0 0 1], theta, [x,y,z])



%%%%%%%%%%%%% Thruster 3 %%%%%%%%%%%%%%%%

Z_plume_3 = Z_plume*u_3 + plume_offset;
plume_3 = mesh(X_plume, Y_plume+y_len/2, Z_plume_3, 'FaceColor','white','EdgeColor','none', 'AlphaData', plume_scale, 'FaceAlpha','interp');
rotate(plume_3, [0 1 0], 90, [x,y,z])
rotate(plume_3, [0 0 1], 45, [x+x_len/2,y+y_len/2,z])
rotate(plume_3, [0 0 1], theta, [x,y,z])

%%% Faint thruster plume
[X_faint_plume, Y_faint_plume, Z_faint_plume] = cylinder( [(min_rad+max_rad)/2, (1+2*u_3)*(min_rad+max_rad)/2]); % Define a cone for the faint plume
X_faint_plume = X_faint_plume + x;
Y_faint_plume = Y_faint_plume + y;
Z_faint_plume = Z_faint_plume*faint_plume_len;
faint_scale = 0.3*(1-Z_faint_plume); % transparency scale for the faint plume

Z_faint_plume_3 = Z_faint_plume*u_3 + plume_offset;
faint_plume_3 = mesh(X_faint_plume, Y_faint_plume+y_len/2, Z_faint_plume_3, 'FaceColor',spacecraft.plume_color(3,:),'EdgeColor','none', 'AlphaData', faint_scale, 'FaceAlpha','interp');
rotate(faint_plume_3, [0 1 0], 90, [x,y,z])
rotate(faint_plume_3, [0 0 1], 45, [x+x_len/2,y+y_len/2,z])
rotate(faint_plume_3, [0 0 1], theta, [x,y,z])



%%%%%%%%%%%%%% Thruster 4 %%%%%%%%%%%%%%

Z_plume_4 = Z_plume*u_4 + plume_offset;
plume_4 = mesh(X_plume, Y_plume, Z_plume_4, 'FaceColor','white','EdgeColor','none', 'AlphaData', plume_scale, 'FaceAlpha','interp');
rotate(plume_4, [0 1 0], 90, [x,y,z])
rotate(plume_4, [0 0 1], theta, [x,y,z])

%%% Faint thruster plume
[X_faint_plume, Y_faint_plume, Z_faint_plume] = cylinder( [(min_rad+max_rad)/2, (1+2*u_4)*(min_rad+max_rad)/2]); % Define a cone for the faint plume
X_faint_plume = X_faint_plume + x;
Y_faint_plume = Y_faint_plume + y;
Z_faint_plume = Z_faint_plume*faint_plume_len;
faint_scale = 0.3*(1-Z_faint_plume); % transparency scale for the faint plume

Z_faint_plume_4 = Z_faint_plume*u_4 + plume_offset;
faint_plume_4 = mesh(X_faint_plume, Y_faint_plume, Z_faint_plume_4, 'FaceColor',spacecraft.plume_color(4,:),'EdgeColor','none', 'AlphaData', faint_scale, 'FaceAlpha','interp');
rotate(faint_plume_4, [0 1 0], 90, [x,y,z])
rotate(faint_plume_4, [0 0 1], theta, [x,y,z])



%%%%%%%%%%%% Thruster 5 %%%%%%%%%%%%

Z_plume_5 = Z_plume*u_5 + plume_offset;
plume_5 = mesh(X_plume, Y_plume-y_len/2, Z_plume_5, 'FaceColor','white','EdgeColor','none', 'AlphaData', plume_scale, 'FaceAlpha','interp');
rotate(plume_5, [0 1 0], 90, [x,y,z])
rotate(plume_5, [0 0 1], -45, [x+x_len/2,y-y_len/2,z])
rotate(plume_5, [0 0 1], theta, [x,y,z])

%%% Faint thruster plume
[X_faint_plume, Y_faint_plume, Z_faint_plume] = cylinder( [(min_rad+max_rad)/2, (1+2*u_5)*(min_rad+max_rad)/2]); % Define a cone for the faint plume
X_faint_plume = X_faint_plume + x;
Y_faint_plume = Y_faint_plume + y;
Z_faint_plume = Z_faint_plume*faint_plume_len;
faint_scale = 0.3*(1-Z_faint_plume); % transparency scale for the faint plume

Z_faint_plume_5 = Z_faint_plume*u_5 + plume_offset;
faint_plume_5 = mesh(X_faint_plume, Y_faint_plume-y_len/2, Z_faint_plume_5, 'FaceColor',spacecraft.plume_color(5,:),'EdgeColor','none', 'AlphaData', faint_scale, 'FaceAlpha','interp');
rotate(faint_plume_5, [0 1 0], 90, [x,y,z])
rotate(faint_plume_5, [0 0 1], -45, [x+x_len/2,y-y_len/2,z])
rotate(faint_plume_5, [0 0 1], theta, [x,y,z])




end