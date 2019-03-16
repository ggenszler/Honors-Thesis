%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grace Genszler                                                    %
% Last Updated: Saturday, March 17th, 2018                          %
% Function that plots the paths of the two space structures         %
%                                                                   %
% Inputs:                                                           %
%   -x1, y1, z1: cartesian coordinates of mass 1                    %
%   -x2, y2, z2: cartesian coordinates of mass 2                    %
%                                                                   %
% Outputs:                                                          %
%   -3D plot of space system                                        %
%   -figure saved as .jpg                                           %
%                                                                   %
% To Do:                                                            %
%   -NA                                                             %
%                                                                   %
% Notes:                                                            %
%   -NA                                                             %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_in_3D(x1,y1,z1,x2,y2,z2,orbits,inc)
if inc == 0
    plot3(x1/10^3,y1/10^3,z1)
    hold on
    plot3(x2/10^3,y2/10^3,z2)
    hold on
    scatter(0,0,'*','k')
    xlabel('Distance (km)','fontsize',14)
    ylabel('Distance (km)','fontsize',14)
    zlabel('Distance (m)','fontsize',14)
else
    plot3(x1/10^3,y1,z1/10^3)
    hold on
    plot3(x2/10^3,y2,z2/10^3)
    hold on
    scatter(0,0,'*','k')
    xlabel('Distance (km)','fontsize',14)
    ylabel('Distance (m)','fontsize',14)
    zlabel('Distance (km)','fontsize',14)
end

legend('Main Satellite','Sub-Satellite')
grid on

if orbits ~= 1
    title([num2str(orbits) ' Orbital Paths'],'fontsize',18)
%     if inc == 0
%         saveas(gcf,strcat(num2str(orbits),'EquitorialOrbit.jpg'))
%     else
%         saveas(gcf,strcat(num2str(orbits),'PolarOrbit.jpg'))
%     end
else
    title('One Orbital Path','fontsize',18)
%     if inc == 0
%         saveas(gcf,strcat(num2str(orbits),'EquitorialOrbit.jpg'))
%     else
%         saveas(gcf,strcat(num2str(orbits),'PolarOrbit.jpg'))
%     end
end
