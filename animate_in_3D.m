%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grace Genszler                                                    %
% Last Updated: Saturday, March 17th, 2018                          %
% Animates the motion of the model in 3D                            %
%                                                                   %
% Inputs:                                                           %
%   -x1, y1, z1: cartesian coordinates of mass 1                    %
%   -x2, y2, z2: cartesian coordinates of mass 2                    %
%   -R0: distance between center of earth and mass 1                %
%   -length: maximum tether length                                  %
%                                                                   %
% Outputs:                                                          %
%   -3D animation of space system                                   %
%   -.gif of 3D animation of space system                           %
%                                                                   %
% To Do:                                                            %
%   -NA                                                             %
%                                                                   %
% Notes:                                                            %
%   -block of code included to create gif after animation code      %
%    given by Nicholas Josselyn                                     %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function animate_in_3D(x1,y1,z1,x2,y2,z2,R0,C)
for j=1:C
    % animates motion
    scatter3(x1(j)/10^3,y1(j)/10^3,z1(j),'o','b')
    hold on
    scatter3(x2(j)/10^3,y2(j)/10^3,z2(j),'o','r')
    hold on
    plot3([x1(j)/10^3,x2(j)/10^3],[y1(j)/10^3,y2(j)/10^3],[z1(j),z2(j)])
    hold on
    scatter3(0,0,0,'*','k')
    hold off
    grid on
    xlim([(-R0/10^3-10)  (R0/10^3+10)])
    ylim([(-R0/10^3-10)  (R0/10^3+10)])
    zlim([min(z2)-1  max(z2)+1])
    xlabel('distance (km)', 'fontsize', 14)
    ylabel('distance (km)', 'fontsize', 14)
    zlabel('distance (m)', 'fontsize', 14)
    title('Orbital Animation', 'fontsize', 18)
    legend('Main Satellite','Sub-Satellite')
    drawnow
    
    % saves animation as gif
    set(gcf,'color','w'); % set figure background to white
    drawnow;
    frame = getframe(6);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    outfile = 'basic_model_polarcoord_misra.gif';
    
     if j==1
         imwrite(imind,cm,outfile,'gif','DelayTime',0,'loopcount',inf);
     else
         imwrite(imind,cm,outfile,'gif','DelayTime',0,'writemode','append');
     end
end