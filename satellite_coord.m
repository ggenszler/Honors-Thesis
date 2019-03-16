%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grace Genszler                                                    %
% Last Updated: Tuesday, March 20th, 2018                           %
% Solves the instantaneous mass, tether length, and tether          %
% deployment rates for each time step                               %
%                                                                   %
% Inputs:                                                           %
%   -t: time vector                                                 %
%   -g: gamma                                                       %
%   -t0: pitch                                                      %
%   -p0: roll                                                       %
%   -r0: distance from main satellite to center of the earth        %
%   -l0: tether length                                              %
%   -inc: inclination                                               %
%                                                                   %
% Outputs:                                                          %
%   -x1, y1, z1: cartesian coordinates of the main satellite        %
%   -x2, y2, z2: cartesian coordinates of the sub-satellite         %
%                                                                   %
% To Do:                                                            %
%   -NA                                                             %
%                                                                   %
% Notes:                                                            %
%   -NA                                                             %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x1,y1,z1,x2,y2,z2] = satellite_coord(t,g,t0,p0,r0,l0,inc)
if inc == 0                         % equitorial orbit case
    x1 = r0*cos(g);                      
    y1 = r0*sin(g);
    z1 = 0*t;
    % coordinates for m1

    x2 = r0*cos(g) - l0.*cos(t0);
    y2 = r0*sin(g) + l0.*sin(t0);
    z2 = l0.*sin(p0);
    % coordinates for m2
else                                % polar orbit case
    x1 = r0*cos(g);                      
    y1 = 0*t;
    z1 = r0*sin(g);
    % coordinates for m1

    x2 = r0*sin(g) - l0.*cos(t0);
    y2 = l0.*sin(p0);
    z2 = r0*cos(g) + l0.*sin(t0);
    % coordinates for m2
end