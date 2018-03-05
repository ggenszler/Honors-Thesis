%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grace Genszler                                                    %
% Last Updated: Friday, February 16th, 2018                         %
% Solves the instantaneous mass, tether length, and tether          %
% deployment rates for each time step                               %
%                                                                   %
% Inputs:                                                           %
%   -t: blank time vector                                           %
%   -h: time step                                                   %
%   -u, v: blank tether length and tether deployment rate vectors   %
%                                                                   %
% Outputs:                                                          %
%   -m: mass vector                                                 %
%   -u, v: tether length and tether deployment rate vectors         %
%                                                                   %
% To Do:                                                            %
%   -NA                                                             %
%                                                                   %
% Notes:                                                            %
%   -NA                                                             %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [m,u,v,g,t]=tether_mass_trueAnomaly(t,h,m,u,v,g,w0)
alpha = 5*10^-4;    % tether deployment constant for l < 10km && l > 90km
c = 5;              % tether deployment constant for 10km < l < 90km
l0 = 10;            % initial tether length
la = 10^4;          % tether length max for phase 1
lb = 9*10^4;        % tether length max for phase 2
lc = 9.999*10^4;    % tether length max for phase 3
%t1 = 13815.7;      % time in s to reach phase 1 max
K1 = 5.9078*10^4;   % exponential rate of growht constant for phase 1
%t2 = 18000;        % time in s to reach phase 3 max
K2 = 2.9811*10^10;  % exponential rate of decay constant for phase 3

for i = 1:length(t)-1 
    % solves for new instantaneous mass
    m(i+1) = m(i)*v(i)/u(i);

    % solves parent function and first derivative for tether length
    if u(i) < la
        u(i+1) = l0*exp(alpha*t(i));
        v(i+1) = alpha*u(i);
    elseif la <= u(i) && u(i) < lb
        u(i+1) = c*t(i) - K1;
        v(i+1) = c;
    elseif lb <= u(i) && u(i) < lc
        u(i+1) = lc + l0 - K2*exp(-alpha*t(i));
        v(i+1) = alpha*(lc + l0 - u(i));
    else
        u(i+1) = 10^5;
        v(i+1) = 0;
    end
    
    g(i+1) = w0*t(i);
    
    % steps forward in time
    t(i+1) = t(i) + h;
end
end
