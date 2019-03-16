%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grace Genszler                                                    %
% Last Updated: Sunsday, March 18th, 2018                           %
% Runge-Kutta Fourth-Order for two second order non-linear DEQs     %
%                                                                   %
% Inputs:                                                           %
%   -u1, u2, u3, u4: first order differential equations             %
%   -h: time step                                                   %
%   -t: blank time vector                                           %
%   -m: mass vector                                                 %
%   -u, v: blank tether length and tether deployment rate vectors   %
%   -w, x: blank pitch and pitch rotation vectors                   %
%   -y, z: blank roll and roll rotation vectors                     %
%                                                                   %
% Outputs:                                                          %
%   -t: time vector                                                 %
%   -u, v: tether length and tether deployment rate vectors         %
%   -w, x: pitch and pitch rotation vectors                         %
%   -y, z: roll and roll rotation vectors                           %
%                                                                   %
% To Do:                                                            %
%   -NA                                                             %
%                                                                   %
% Notes:                                                            %
%   -NA                                                             %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [w,x,y,z] = rk4_2o_nl_2(u1,u2,u3,u4,t,h,m,g,b,u,v,w,x,y,z)
for i = 1:length(t)-1
    % solves constants k_n, l_n, m_n, and n_n
    k1 = h*u1(t(i), m(i), g(i), b(i), u(i), v(i), w(i), x(i), y(i), z(i));
    l1 = h*u2(t(i), m(i), g(i), b(i), u(i), v(i), w(i), x(i), y(i), z(i));
    m1 = h*u3(t(i), m(i), g(i), b(i), u(i), v(i), w(i), x(i), y(i), z(i));
    n1 = h*u4(t(i), m(i), g(i), b(i), u(i), v(i), w(i), x(i), y(i), z(i));
    
    k2 = h*u1(t(i) + h/2, (m(i) + m(i+1))/2, (g(i) + g(i+1))/2, (b(i) + b(i+1))/2, (u(i) + u(i+1))/2, (v(i) + v(i+1))/2, w(i) + k1/2, x(i) + l1/2, y(i) + m1/2, z(i) + n1/2);
    l2 = h*u2(t(i) + h/2, (m(i) + m(i+1))/2, (g(i) + g(i+1))/2, (b(i) + b(i+1))/2, (u(i) + u(i+1))/2, (v(i) + v(i+1))/2, w(i) + k1/2, x(i) + l1/2, y(i) + m1/2, z(i) + n1/2);
    m2 = h*u3(t(i) + h/2, (m(i) + m(i+1))/2, (g(i) + g(i+1))/2, (b(i) + b(i+1))/2, (u(i) + u(i+1))/2, (v(i) + v(i+1))/2, w(i) + k1/2, x(i) + l1/2, y(i) + m1/2, z(i) + n1/2);
    n2 = h*u4(t(i) + h/2, (m(i) + m(i+1))/2, (g(i) + g(i+1))/2, (b(i) + b(i+1))/2, (u(i) + u(i+1))/2, (v(i) + v(i+1))/2, w(i) + k1/2, x(i) + l1/2, y(i) + m1/2, z(i) + n1/2);
    
    k3 = h*u1(t(i) + h/2, (m(i) + m(i+1))/2, (g(i) + g(i+1))/2, (b(i) + b(i+1))/2, (u(i) + u(i+1))/2, (v(i) + v(i+1))/2, w(i) + k2/2, x(i) + l2/2, y(i) + m2/2, z(i) + n2/2);
    l3 = h*u2(t(i) + h/2, (m(i) + m(i+1))/2, (g(i) + g(i+1))/2, (b(i) + b(i+1))/2, (u(i) + u(i+1))/2, (v(i) + v(i+1))/2, w(i) + k2/2, x(i) + l2/2, y(i) + m2/2, z(i) + n2/2);
    m3 = h*u3(t(i) + h/2, (m(i) + m(i+1))/2, (g(i) + g(i+1))/2, (b(i) + b(i+1))/2, (u(i) + u(i+1))/2, (v(i) + v(i+1))/2, w(i) + k2/2, x(i) + l2/2, y(i) + m2/2, z(i) + n2/2);
    n3 = h*u4(t(i) + h/2, (m(i) + m(i+1))/2, (g(i) + g(i+1))/2, (b(i) + b(i+1))/2, (u(i) + u(i+1))/2, (v(i) + v(i+1))/2, w(i) + k2/2, x(i) + l2/2, y(i) + m2/2, z(i) + n2/2);
    
    k4 = h*u1(t(i) + h, m(i+1), g(i+1), b(i+1), u(i+1), v(i+1), w(i) + k3, x(i) + l3, y(i) + m3, z(i) + n3);
    l4 = h*u2(t(i) + h, m(i+1), g(i+1), b(i+1), u(i+1), v(i+1), w(i) + k3, x(i) + l3, y(i) + m3, z(i) + n3);
    m4 = h*u3(t(i) + h, m(i+1), g(i+1), b(i+1), u(i+1), v(i+1), w(i) + k3, x(i) + l3, y(i) + m3, z(i) + n3);
    n4 = h*u4(t(i) + h, m(i+1), g(i+1), b(i+1), u(i+1), v(i+1), w(i) + k3, x(i) + l3, y(i) + m3, z(i) + n3);
    
    % solves parent functions and first derivatives for pitch and roll
    w(i+1) = w(i) + 1/6*(k1 + 2*k2 + 2*k3 + k4);
    x(i+1) = x(i) + 1/6*(l1 + 2*l2 + 2*l3 + l4);
    y(i+1) = y(i) + 1/6*(m1 + 2*m2 + 2*m3 + m4);
    z(i+1) = z(i) + 1/6*(n1 + 2*n2 + 2*n3 + n4);
end
end
