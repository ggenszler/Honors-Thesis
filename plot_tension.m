%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grace Genszler                                                    %
% Last Updated: Sunday, March 25th, 2018                            %
% Function that plots tension                                       %
%                                                                   %
% Inputs:                                                           %
%   -t: time vector                                                 %
%   -m2: mass of sub-satellite                                      %
%   -mass: vector of tether masses at each time step                %
%   -gamma: true anomaly vector                                     %
%   -beta: offset from true anomaly vector                          %
%   -l0: tether length vector                                       %
%   -l2: acceleration of tether deployment vector                   %
%   -theta0: pitch vector                                           %
%   -phi0: roll vector                                              %
%   -phi1: rate of change of roll vector                            %
%   -w0: angular velocity of satellite system                       %
%   -W0: angular velocity of earth                                  %
%   -inclination: inclination angle                                 %
%   -R0: distance from center of mass to center of earth            %
%   -r: tether radius                                               %
%   -rho0: reference density                                        %
%   -b: distance from main satellite vertically down                %
%   -he: altitude variation due to eccentricity                     %
%   -CMD: drag coefficient of sub satellite                         %
%   -CmA: tether axial force coefficient                            %
%   -A: cross sectional area of the sub-satellite                   %
%                                                                   %
% Outputs:                                                          %
%   -plot of tension vs time                                        %
%   -figure saved as .jpg                                           %
%                                                                   %
% To Do:                                                            %
%   -NA                                                             %
%                                                                   %
% Notes:                                                            %
%   -Potential issue with spikes in tension when switching from     %
%    one part of piecewise to another                               %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_tension(t,tension,inclination,var)
plot(t/3600,tension)
xlabel ('Time (hr)', 'fontsize', 14)
ylabel ('Tension (N)', 'fontsize', 14)
title ('Tension in the Tether', 'fontsize', 18)
%ylim([0, 90])
grid on

if inclination == 0
    saveas(gcf,strcat('TensionEquitorial',num2str(var),'m1000kg.jpg'))
else
    saveas(gcf,strcat('TensionPolar',num2str(var),'m1000kg.jpg'))
end