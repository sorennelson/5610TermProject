% This function, alongside vehicle_solve, will likely be an ongoing project
function [tS, xS] = satellite_solve(u, v, theta, tV, xV)
% Given vehicle coordinates (in Cartesian), computes approximate ts and xs
% for the given satellite
% ---- Parameters ----
% u - 3x1 double vector - u parameter for satellite motion
% v - 3x1 double vector - v parameter for satellite motion
% theta - phase of satellite orbit
% tV - time vehicle should receive satellite signal
% xV - position of vehicle upon signal receival, in Cartesian coordinates 
% ---- Returns ----
% tS - double - time satellite should send signal to vehicle
% xS - 3x1 double vector - position satellite should send signal in Cartesian coordinates
p = 4.308204499999999825E+04;
h = 2.020000000000000000E+07;
c = 2.997924580000000000E+08;
PI = 3.141592653589793116;
R = 6.367444500000000000E+06;
TOL = 10^-11;
N = 1000000000;
% Naive attempt with the fixed point method
% if mode == 0 <-- Also implement newton's method here?
i = 1;
tS0 = tV;
while i < N
    xS = (R+h)*(u*cos(2*PI*tS0/p + theta)+v*sin(2*PI*tS0/p + theta));
    tS = tV - norm(xV - xS)/c;
    if abs(tS - tS0) < TOL
        return
    end
    i = i+1;
    tS0 = tS;
end
% If the calcation fails NaN is returned for each value
if i == N
    tS = NaN;
    xS = NaN;
end
end