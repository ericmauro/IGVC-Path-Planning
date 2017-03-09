%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        TCNJ IGVC 2016         %
%    Path Planning Program 1    %
%       March 28th, 2016        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc

% Define vision dimensions
w = 8; % Width of space in inches
l = 8; % Length of space in inches
R = 72; % Max vision radius in inches

% Turning Gain
K = 8;

% Define waypoint
way_x = 0;
way_y = R;

Fx = way_x/R;
Fy = way_y/R;

% Simulated laser data, calculate forces
for n = 1:181
    if (n>45)&(n<80)
        r(n) = 30;
    else
        r(n) = R;
    end
    x(n) = r(n)*cos((n-1)*(pi/180));
    y(n) = r(n)*sin((n-1)*(pi/180));
    
    Fx = Fx - (1-r(n)/R)*cos((n-1)*(pi/180))/181;
    Fy = Fy - (1-r(n)/R)*sin((n-1)*(pi/180))/181;
end

% Apply turning gain
Fx = K*Fx;

% Normalize Fx if out of bounds
if Fx>1
    Fx = 1;
elseif Fx<-1
    Fx = -1;
end

figure
plot(x,y,'--r')
axis([-R R 0 R])

figure
hold on
plot(x,y,'--r')
axis([-R R 0 R])
plot([0 Fx*R],[0 Fy*R],'b')