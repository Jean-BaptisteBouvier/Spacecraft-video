% Function to set up all the constant parameters describing the satellite
% 
% failure: id of the malfunctioning thruster
% 
% Author: Jean-Baptiste Bouvier


function spacecraft = satellite_setup(failure, scale)


%%% Textures
spacecraft.space = imread('pictures/night_sky.jpg');
spacecraft.gold_texture = imread('pictures/gold.jpg');
spacecraft.panel_texture = imread('pictures/solar_panel.jpg');

%%% Satellite size
spacecraft.x_len = 2*scale;
spacecraft.y_len = 1*scale;
spacecraft.z_len = 1*scale;

%%% Solar panels size
spacecraft.x_solar_len = 1*scale;
spacecraft.y_solar_len = 3*scale;

%%% Thrusters parameters
spacecraft.thruster_color = ones(5,3)*0.6; % grey controlled thrusters
spacecraft.min_rad = 0.05*scale; % minimal radius of the thrusters
spacecraft.max_rad = 0.2*scale; % maximal radius of the thrusters
spacecraft.thruster_len = 0.3*scale; % length of the thrusters
spacecraft.thruster_in = 0.05*scale; % length of the thruster embedded in the satellite

%%% Camera parameters
spacecraft.camera_rad = 0.25*scale;
spacecraft.camera_len = 0.5*scale;
spacecraft.camera_color = [.95 .95 .95];

%%% Camera lens parameters
spacecraft.lens_color = [.8 .8 1];

%%% Thrust plume parameters
spacecraft.plume_len = 1*scale; % maximal length of the main plume, i.e., when u=1
spacecraft.faint_plume_len = 2*scale; % maximal length of the faint plume, i.e., when u=1
spacecraft.plume_color = [zeros(5,1), ones(5,2)]; % cyan plume for the controlled thrusters


%%% Malfunctioning thruster
spacecraft.failure = failure; % id of the malfunctioning thruster
if ~isempty(failure)
    spacecraft.thruster_color(failure,:) = [1 0 0]; % red malfunctioning thruster
    spacecraft.plume_color(failure,:) = [1 0 0]; % red plume for the malfunctioning thrusters
end

end