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
end