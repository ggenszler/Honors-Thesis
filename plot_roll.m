%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grace Genszler                                                    %
% Last Updated: Monday, March 19th, 2018                            %
% Function that plots the roll (out of plane motion) in degrees     %
%                                                                   %
% Inputs:                                                           %
%   -t: time vector                                                 %
%   -phi0: pitch values in radians                                  %
%                                                                   %
% Outputs:                                                          %
%   -plot of roll vs time                                           %
%   -figure saved as .jpg                                           %
%                                                                   %
% To Do:                                                            %
%   -NA                                                             %
%                                                                   %
% Notes:                                                            %
%   -NA                                                             %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_roll(t,phi0,inclination,var)
plot(t/3600,phi0*180/pi)
xlabel ('Time (hr)', 'fontsize', 14)
ylabel ('Roll \phi (deg)', 'fontsize', 14)
title ('Out of Plane Motion', 'fontsize', 18)
grid on

if inclination == 0
    saveas(gcf,strcat('RollEquitorial',num2str(var),'m1000kg.jpg'))
else
    saveas(gcf,strcat('RollPolar',num2str(var),'m1000kg.jpg'))
end
