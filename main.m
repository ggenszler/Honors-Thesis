%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grace Genszler                                                    %
% Last Updated: Sunday, april 8th, 2018                             %
% Idealized of tethered satellite system when                       % 
%   -payload mass <<< shuttle mass                                  %
%   -orbit of shuttle mass is circular                              %
%   -no altitude variation due to eccentricity                      %
%   -tether doesn't stretch                                         %
%                                                                   %
% Equations from NASA Tethered Subsatellite Study                   %
%                                                                   %
% To Do:                                                            %
%   -NA                                                             %
%                                                                   %
% Notes:                                                            %
%   -REMOVE ALL NON-CONSTRUCTIVE COMMENTS BEFORE REVIEW MEETINGS    %
%   -Matlab Online Password:                                        %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameters
% **Default Values for User Inputs**
orbits = 2; % 9;                     % number of orbits
inclination = 0;                % inclination angle of main satellite; rad
lMax = 100*10^3;                % total tether length; m
m2 = 170;                       % sub satellite mass; kg
H = 200*10^3;                   % orbital altitude; m
r = 0.000183;                   % radius of tether; m
rhot = .0837;                   % tether density; kg/m^3

% % **User Defined Inputs**
% [orbits,inclination,lMax,m2,H,r,rhot] = user_inputs()

% **Constants**
tstep = 1;              % time step change factor
alpha = 5*10^(-4);      % exponential Tether Deployment Factor; m/s
c = 5;                  % constant Tether Deployment Factor; m/s
CMD = 1;                % drag coefficient of sub satellite
A = 1;                  % cross sectional area of subsatellite; m^2
CmN = 2.2;              % tether normal force coefficient
CmA = .2;               % tether axial force coefficient
he = 0;                 % altitude variaton due to eccentricity; m
G = 6.67*10^(-11);      % gravitational constant; m^3/kg/s^2
E = 5.972*10^24;        % mass of Earth; kg
re = 6.371*10^6;        % radius of Earth; m
W0 = 7.292*10^(-5);     % angular velocity of the earth; rad/s
b = .1513*10^(-3);      % reference height; 1/m
rho0 = 1.2321*10^(-13); % reference density; kg/m^3

% **Compound Constants**
m0 = 10*rhot*pi*r^2;                    % initial tether mass; kg
mMax = lMax*rhot*pi*r^2;                % total tether mass; kg
R0 = re + H;                            % distance center of earth to com; m
w0 = sqrt((G*E)/R0^3);                  % angular velocity of main satellite; rad/s
w = sqrt((G*E)/R0);                     % orbital velocity of main satellite; m/s
h = -(lMax*.9);                         % distance from main satellite vertically down; m
Vx0 = -R0*(w0 - W0*cos(inclination));   % relative wind vector magnitude in x direction; m/s

C = ceil((2*pi*R0/w*orbits+tstep)/tstep);	% number of time steps the simulation uses

% **Initial Values**
gamma0 = 0;             % initial true anomaly; rad
beta0 = -pi/2;          % initial -90deg offset from true anomaly; rad
l_n = 10;               % initial length; m
l_dn = 0;               % initial rate of deployment; m/s
l_ddn = 0;              % initial acceleration of deployment; m/s^2
theta_n0 = 3*pi/180;    % initial pitch; rad
theta_dn0 = 0;          % initial pitch rate of rotation; rad/s
phi_n0 = 3*pi/180;      % initial roll; rad
phi_dn0 = w0;           % initial roll rate of rotation; rad/sec

% **Initialized Vectors for Variables**
t = zeros(1,C);                             % blank time vector for RK4
mass_n = [m0    zeros(1,C-1)];              % initialized mass vector
gamma_n = [gamma0     zeros(1,C-1)];        % initialized true anomaly vector
beta_n = [beta0   zeros(1,C-1)];            % initialized beta vector
t_n = [l_n     zeros(1,C-1)];               % initialized tether length vector
t_dn = [l_dn     zeros(1,C-1)];             % initialized tether deployment rate vector
t_ddn = [l_ddn  zeros(1,C-1)];              % initialized tether deployment acceleration vector
theta_n = [theta_n0     zeros(1,C-1)];      % initialized pitch vector for RK4
theta_dn = [theta_dn0     zeros(1,C-1)];    % initialized pitch rate of rotation vector for RK4
phi_n = [phi_n0     zeros(1,C-1)];          % initialized roll vector for RK4
phi_dn = [phi_dn0     zeros(1,C-1)];        % initialized roll rate of rotation vector for RK4

%% Compute Uncoupled Varaibles
[mass,l0,l1,l2,gamma,beta,time] = tether_mass_trueAnomaly(t,tstep,mass_n,t_n,t_dn,t_ddn,gamma_n,beta_n,w0,alpha,c,lMax,mMax);
% solves for the mass, tether length, and deployment rate at each time step

%% Compute Coupled Variables
dtheta_dt=@(TIMEU1,MASSU1,GAMMAU1,BETAU1,L0U1,L1U1,THETA_NU1,THETA_DNU1,PHI_NU1,PHI_DNU1) THETA_DNU1;
% dtheta/dt = theta_dot

dthetaDot_dt=@(TIMEU2,MASSU2,GAMMAU2,BETAU2,L0U2,L1U2,THETA_NU2,THETA_DNU2,PHI_NU2,PHI_DNU2) (0 + ...
    rho0*exp(b*he/2*(1-cos(GAMMAU2 - gamma0)))*(CMD*A*L0U2*(1/2*exp(L0U2*b*cos(THETA_NU2)*cos(PHI_NU2)))*sqrt(Vx0^2 + (R0*(W0*sin(inclination)*cos(BETAU2)))^2) + CmN*r*((exp(L0U2*b*cos(THETA_NU2)*cos(PHI_NU2))*(L0U2*b*cos(THETA_NU2)*cos(PHI_NU2) - 1) + 1)/((cos(THETA_NU2)*cos(PHI_NU2))*b)^2)*sqrt((Vx0*cos(THETA_NU2))^2 + (Vx0*sin(THETA_NU2)*sin(PHI_NU2) + R0*(W0*sin(inclination)*cos(BETAU2))*cos(PHI_NU2))^2))*Vx0*cos(THETA_NU2)*cos(PHI_NU2) - ...
    3*(m2 + MASSU2/3)*w0^2*L0U2^2*sin(THETA_NU2)*cos(THETA_NU2)*(cos(PHI_NU2))^2 - ...
    2*(m2 + MASSU2/2)*L1U2*L0U2*(THETA_DNU2 - w0)*(cos(PHI_NU2))^2 - ...
    2*(m2 + MASSU2/3)*L0U2^2*(w0 - THETA_DNU2)*PHI_DNU2*sin(PHI_NU2)*cos(PHI_NU2))/((m2 + MASSU2/3)*L0U2^2*(cos(PHI_NU2))^2);
% dtheta_dot/dt = **stuff**

dphi_dt=@(TIMEU3,MASSU3,GAMMAU3,BETAU3,L0U3,L1U3,THETA_NU3,THETA_DNU3,PHI_NU3,PHI_DNU3) PHI_DNU3;
% dphi/dt = phi_dot

dphiDot_dt=@(TIMEU4,MASSU4,GAMMAU4,BETAU4,L0U4,L1U4,THETA_NU4,THETA_DNU4,PHI_NU4,PHI_DNU4) (0 + ...
    -rho0*exp(b*he/2*(1-cos(GAMMAU4 - gamma0)))*(CMD*A*L0U4*(1/2*exp(L0U4*b*cos(THETA_NU4)*cos(PHI_NU4)))*sqrt(Vx0^2 + (R0*(W0*sin(inclination)*cos(BETAU4)))^2) + CmN*r*((exp(L0U4*b*cos(THETA_NU4)*cos(PHI_NU4))*(L0U4*b*cos(THETA_NU4)*cos(PHI_NU4) - 1) + 1)/((cos(THETA_NU4)*cos(PHI_NU4))*b)^2)*sqrt((Vx0*cos(THETA_NU4))^2 + (Vx0*sin(THETA_NU4)*sin(PHI_NU4) + R0*(W0*sin(inclination)*cos(BETAU4))*cos(PHI_NU4))^2))*(Vx0*sin(THETA_NU4)*sin(PHI_NU4) + R0*(W0*sin(inclination)*cos(BETAU4))*cos(THETA_NU4)) - ...
    3*(m2 + MASSU4/3)*w0^2*L0U4^2*(cos(THETA_NU4))^2*sin(PHI_NU4)*cos(PHI_NU4) - ...
    2*(m2 + MASSU4/2)*L1U4*L0U4*PHI_DNU4 - ...
    (m2 + MASSU4/3)*L0U4^2*(w0 - THETA_DNU4)^2*cos(PHI_NU4)*sin(PHI_NU4))/((m2 + MASSU4/3)*L0U4^2);
% dphi_dot/dt = **stuff**

[theta0,theta1,phi0,phi1] = rk4_2o_nl_2(dtheta_dt,dthetaDot_dt,dphi_dt,dphiDot_dt,time,tstep,mass,gamma,beta,l0,l1,theta_n,theta_dn,phi_n,phi_dn);
% runs RK4 on equations dtheta_dt, dthetaDot_dt, dphi_dt, and dphi_dot/dt

%% System Model
[x1,y1,z1,x2,y2,z2] = satellite_coord(time,gamma,theta0,phi0,R0,l0,inclination);
% calculates the position of the two satellites in the global Cartesian Coordinate System

% %% Tensile Testing
% [tension,stress] = tension_stress(m2,mass,gamma,beta,l0,l2,theta0,theta1,phi0,phi1,w0,W0,inclination,R0,r,rho0,b,he,CMD,CmA,A);
% % calculates the tension and stress in the tether
% 
% message = sprintf('The maximum stress is %d Pa', max(stress));
% msgbox(message);
% % outputs the maximum stress in a dialogue box

%% Figures
figure (1)
plot_tether(time,l0,l1,inclination,lMax)
% graphs tether length and tether deployment rate and saves it as a .jpg
% 
% figure (2)
% plot_pitch(time,theta0,inclination,lMax)
% % plots pitch and saves it as a .jpg
%  
% figure (3)
% plot_roll(time,phi0,inclination,lMax)
% % plots roll and saves it as a .jpg
% 
% figure (4)
% plot_tension(time,tension,inclination,lMax)
% % plots tension and saves it as a .jpg

% figure (6)
% animate_in_3D(x1,y1,z1,x2,y2,z2,R0,C)
% % animates the orbital paths of m1 and m2 in 3D and saves it as a .gif