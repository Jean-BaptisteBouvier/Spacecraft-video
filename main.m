% Code to generate the spacecraft video.
% First the reference trajectory, tracking trajectory and thrust inputs
% must be computed with the GitHub project:
% https://github.com/Jean-BaptisteBouvier/Spacecraft-Resilience
% This data must then be stored in the `data` folder.
% 
% Author: Jean-Baptiste Bouvier


clearvars
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% User inputs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Trajectory related inputs
dt = 0.2; % [seconds] time step of the data
transfer_time = 90; % [minutes] length of the transfer time between waypoints
delay = 3; % [seconds] actuation delay
is_Lipschitz_w = true; % [true] w Lipschitz   [false] w bang-bang

%%% Video related inputs
video_name = 'moving_dual_sat_video';
video_time_step = 10; % [seconds] must be larger than dt
satellite_scale = 15; % scale of the satellite wrt trajectory (1 = real size)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


assert(video_time_step >= dt, 'The time step of the video must be larger than that of the data.')


addpath('data')
addpath('functions')
addpath('pictures')

%%% Loading reference trajectory and thrust profiles
load('data/ref_traj_' + string(transfer_time) + 'min_dt=' + string(dt) + '.mat');
N = length(X_ref(1,:));

%%% Scaling reference trajectory
ref_traj = [X_ref(1:2,:)*1e3; zeros(1, N)]; % positions in meters instead of km

%%% Loading tracking trajectory and tracking thrust
failure = 4; % id of the malfunctioning thruster
if is_Lipschitz_w
    load('data/tracking_Lip_delay=' + string(delay) + '_dt=' + string(dt) + '.mat')
else
    load('data/tracking_bang_delay=' + string(delay) + '_dt=' + string(dt) + '.mat')
end
traj = [X_Lechappe(1:2,:)*1e3; zeros(1, N)]; % positions in meters instead of km
thrust = [U_Lechappe(1:failure-1,:); W; U_Lechappe(failure:end,:)];

%%% Creating the satellite model
chaser = satellite_setup(failure, satellite_scale);
target = satellite_setup([], satellite_scale); % no failure in the target satellite
target.position = [0;0;0];
target.orientation = 90;

%%% Video
frame_step = round(video_time_step/dt);
disp('Generating video: ' + string(video_name))
video = VideoWriter(string(video_name) + '.avi');
open(video);

for i = frame_step:frame_step:N
    
    %%% Satellite position
    chaser.position = traj(:,i);
    %%% Satellite orientation
    chaser.orientation = atan2(traj(2,i), traj(1,i))*180/pi; % [deg]

    %%% Plot
    plot_setup(ref_traj, traj(:,1:i), chaser, target)
    plot_satellite(chaser)
    plot_thrust(chaser, thrust(:,i))
    plot_satellite(target)

    if mod(i, N/5) < frame_step % chaser takes a pic of target
        plot_picture(chaser, target);
    end
    
    %%% Save the plot as a video frame and close the plot
    frame = getframe(gcf);
    writeVideo(video, frame);
    close
end

close(video);

