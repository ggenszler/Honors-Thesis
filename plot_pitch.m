%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grace Genszler                                                    %
% Last Updated: Monday, March 19th, 2018                            %
% Function that plots the pitch (in plane motion) in degrees        %
%                                                                   %
% Inputs:                                                           %
%   -t: time vector                                                 %
%   -theta0: pitch values in radians                                %
%                                                                   %
% Outputs:                                                          %
%   -plot of pitch vs time                                          %
%   -figure saved as .jpg                                           %
%                                                                   %
% To Do:                                                            %
%   -NA                                                             %
%                                                                   %
% Notes:                                                            %
%   -NA                                                             %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_pitch(t,theta0,inclination,var)
plot(t/3600,theta0*180/pi)
xlabel ('Time (hr)', 'fontsize', 14)
ylabel ('Pitch \theta (deg)', 'fontsize', 14)
title ('In Plane Motion', 'fontsize', 18)
grid on

if inclination == 0
    saveas(gcf,strcat('PitchEquitorial',num2str(var),'m1000kg.jpg'))
else
    saveas(gcf,strcat('PitchPolar',num2str(var),'m1000kg.jpg'))
end
