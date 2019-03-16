%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grace Genszler                                                    %
% Last Updated: Monday, March 19th, 2018                            %
% Function that plots                                               %
%   -tether length in m                                             %
%   -tether rate in m/s                                             %
%                                                                   %
% Inputs:                                                           %
%   -t: time vector                                                 %
%   -l0: tether length in m                                         %
%   -l1: rate of tether deployment in m/s                           %
%                                                                   %
% Outputs:                                                          %
%   -subplot of:                                                    %
%       tether length vs time                                       %
%       rate of tether deployment vs time                           %
%   -figure saved as .jpg                                           %
%                                                                   %
% To Do:                                                            %
%   -NA                                                             %
%                                                                   %
% Notes:                                                            %
%   -NA                                                             %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_tether(t,l0,l1,inclination,var)
subplot(2,1,1),plot(t/3600,l0/10^3)
xlabel ('Time (hr)', 'fontsize', 14)
ylabel ('Deployed Length (km)', 'fontsize', 14)
title ('Tether Length During Deployment', 'fontsize', 18)
%ylim([0, 120])
grid on
subplot(2,1,2),plot(t/3600,l1)
xlabel ('Time (hr)', 'fontsize', 14)
ylabel ('Rate of Deployment (m/s)', 'fontsize', 14)
title ('Rate of Tether Deployment', 'fontsize', 18)
%ylim([0, 6])
grid on

if inclination == 0
    saveas(gcf,strcat('TetherEquitorial',num2str(var),'m1000kg.jpg'))
else
    saveas(gcf,strcat('TetherPolar',num2str(var),'m1000kg.jpg'))
end
