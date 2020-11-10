function [veh_params] = carttoveh(t, x, y, z)
% Takes a time and 3d cartesian coordinates and converts them into standard
% vehicle form (i.e. in the form of (8))
% ---- Parameters ----
% t - double - time in seconds at which the point is located at coordinates x, y, z
% x - double - x position coordinate
% y - double - y position coordinate
% z - double - z position coordinate
% ---- Returns ----
% veh_params - 1x10 double vector in the form of:
%   t psi_d psi_m psi_s NS lambda_d lambda_m lambda_s EW h
veh_params = zeros(1,10);
R = 6.367444500000000000E+06;
s = 8.616408999999999651E+04;
PI = 3.141592653589793116;
% We can easily and immediately solve for t and h
veh_params(1) = t;
veh_params(10) = sqrt(x^2+y^2+z^2) - R;
% Begin spherical coordinate conversion
% theta - inclination -> psi_d psi_m psi_s NS
theta = atan2(sqrt(x^2+y^2), z);
theta = theta-PI/2;
if (theta < 0)
    veh_params(5) = -1;
else
    veh_params(5) = 1;
end
[thd,thm,ths] = radtodms(abs(theta));
veh_params(2) = thd;
veh_params(3) = thm;
veh_params(4) = ths;
% phi - azimuth -> lambda_d lambda_m lambda_s EW
phi = atan2(y,x);
phi = phi - 2*PI*t/s;
phi = atan2(sin(phi), cos(phi));
if (phi < 0)
    veh_params(9) = -1;
else
    veh_params(9) = 1;
end
[phid, phim, phis] = radtodms(abs(phi));
veh_params(6) = phid;
veh_params(7) = phim;
veh_params(8) = phis;
end