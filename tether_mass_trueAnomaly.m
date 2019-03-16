%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grace Genszler                                                    %
% Last Updated: Sunday, March 25th, 2018                            %
% Solves the instantaneous mass, tether length, and tether          %
% deployment rates for each time step                               %
%                                                                   %
% Inputs:                                                           %
%   -t: blank time vector                                           %
%   -h: time step                                                   %
%   -u: blank tether length vecto                                   %
%   -v: blank tether deployment rate vector                         %
%   -w: blank tether acceleration vector                            %
%                                                                   %
% Outputs:                                                          %
%   -m: mass vector                                                 %
%   -g: true anomaly vector                                         %
%   -b: -90deg offset from true anomaly vector                      %
%   -u: tether length vector                                        %
%   -v: tether deployment rate vector                               %
%   -w: tether acceleration rate vector                             %
%                                                                   %
% To Do:                                                            %
%   -NA                                                             %
%                                                                   %
% Notes:                                                            %
%   -NA                                                             %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [m,u,v,w,g,b,t]=tether_mass_trueAnomaly(t,h,m,u,v,w,g,b,w0,alpha,c,lMax,mMax)
l0 = 10;                                                            % initial tether length
la = 10^4;                                                       % tether length max for phase 1
lb = lMax - 10^4;                                                       % tether length max for phase 2
lc = lMax - l0;                                                     % tether length max for phase 3
K1 = -(la - c*log(la/l0)/alpha);                                    % integration constant for phase 2
K2 = ((lc + l0 - lb)*exp(alpha*(lb - la + c*log(la/l0)/alpha)/c));	% integration constant for phase 3

for i = 2:length(t) 
    % steps forward in time
    t(i) = t(i-1) + h;
    
    % solves parent function, first, and second derivatives for tether length
    if u(i-1) < la
        u(i) = l0*exp(alpha*t(i));
        v(i) = alpha*u(i);
        w(i) = alpha^2*u(i);
    elseif la <= u(i-1) && u(i-1) < lb
        u(i) = c*t(i) - K1;
        v(i) = c;
        w(i) = 0;
    elseif lb <= u(i-1) && u(i-1) < lc        
        u(i) = lc + l0 - K2*exp(-alpha*t(i));
        v(i) = alpha*(lc + l0 - u(i));
        w(i) = -K2*alpha^2*exp(-alpha*t(i));
    else
        u(i) = lMax;
        v(i) = 0;
        w(i) = 0;
    end
    
    % solves for new instantaneous mass
    m(i) = mMax*u(i)/lMax;
    
    % solves for true anomaly
    g(i) = w0*t(i);
    
    % solves -90deg offset from true anomaly 
    b(i) = g(i) - pi/2;
end
end
