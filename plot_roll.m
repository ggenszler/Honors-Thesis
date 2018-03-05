%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grace Genszler                                                    %
% Last Updated: Tuesday, February 27th, 2018                        %
% Function that plots the roll (out of plane motion) in degrees     %
%                                                                   %
% Inputs:                                                           %
%   -t: time vector                                                 %
%   -phi0: pitch values in radians                                  %
%                                                                   %
% Outputs:                                                          %
%   -plot of roll vs time                                           %
%                                                                   %
% To Do:                                                            %
%   -verify reducing initial quantities in radians was done right   %
%                                                                   %
% Notes:                                                            %
%   -NA                                                             %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_roll(t,phi0)
plot(t/3600,phi0*180/pi)
xlabel ('Time (hr)', 'fontsize', 14)
ylabel ('Roll \phi (deg)', 'fontsize', 14)
title ('Out of Plane Motion', 'fontsize', 18)
grid on
end
