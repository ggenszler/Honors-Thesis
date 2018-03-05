%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grace Genszler                                                    %
% Last Updated: Tuesday, February 27th, 2018                         %
% Function that plots the pitch (in plane motion) in degrees        %
%                                                                   %
% Inputs:                                                           %
%   -t: time vector                                                 %
%   -theta0: pitch values in radians                                %
%                                                                   %
% Outputs:                                                          %
%   -plot of pitch vs time                                          %
%                                                                   %
% To Do:                                                            %
%   -verify reducing initial quantities in radians was done right   %
%                                                                   %
% Notes:                                                            %
%   -NA                                                             %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_pitch(t,theta0)
plot(t/3600,theta0*180/pi)
xlabel ('Time (hr)', 'fontsize', 14)
ylabel ('Pitch \theta (deg)', 'fontsize', 14)
title ('In Plane Motion', 'fontsize', 18)
grid on
end
