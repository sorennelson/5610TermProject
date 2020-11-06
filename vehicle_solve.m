% This function, alongside satellite_solve, will likely be an ongoing project
function [tV, xV] = vehicle_solve(satellites)
% Given a matrix of satellite parameters (each row in the form of (11))
% computes the estimated position and receival time of the vehicle. The
% satellites ought to be visible above the horizon
% ---- Parameters ----
% satellites - Nx3 double matrix containing the index, tS, and xS of each
% satellite in cartesian coordinates
% ---- Returns ----
% tV - double - expected receival time from satellites
% xV - 3x1 double vector - expected position of the vehicle on receival, in cartesian coordinates
end