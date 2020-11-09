% This function, alongside satellite_solve, will likely be an ongoing project
function [tV, xV] = vehicle_solve(xSList, tSList)
% Given a matrix of satellite parameters (each row in the form of (11))
% computes the estimated position and receival time of the vehicle. The
% satellites ought to be visible above the horizon
% ---- Parameters ----
% xSList - 3xN double matrix where each column is the position of a satellite
% tSList - 1xN double vector where each entry is tS of the satellite.
% ---- Returns ----
% tV - double - expected receival time from satellites
% xV - 3x1 double vector - expected position of the vehicle on receival, in cartesian coordinates
c = 2.997924580000000000E+08;
[xV, min] = gradient_method_backtracking(xSList, tSList, xSList(1), 10, 0.5, 0.5, 10^-5);
sz = size(xSList);
tV = 0;
% Get average tV from each satellite
for i=1:sz(2)
    tV = tV + tSList(i) + norm(xV - xSList(i))/c;
end
tV = tV / sz(2);
end

% Backtracking gradient descent method used to solve for xV
% Some slight tweaks will need to be made to this
% We'll also need to figure out which alpha,beta, and epsilon parameters
% work best. We also may need to transpose some stuff here.
function [x,fun_val]=gradient_method_backtracking(xSList, tSList, x0,s,alpha,beta,epsilon)
% Gradient method with backtracking stepsize rule
%
% INPUT
%=======================================
% xSList .... 3xN double matrix where each column is the position of a satellite
% tSList .... 1xN double vector where each entry is tS of the satellite.
% x0......... initial point
% s ......... initial choice of stepsize
% alpha ..... tolerance parameter for the stepsize selection
% beta ...... the constant in which the stepsize is multiplied 
%             at each backtracking step (0<beta<1)
% epsilon ... tolerance parameter for stopping rule
% OUTPUT
%=======================================
% x ......... optimal solution (up to a tolerance) 
%             of min f(x)
% fun_val ... optimal function value
x=x0;
grad=G(xSList, tSList, x);
fun_val=f(xSList, tSList, x);
iter=0;
while ((norm(grad)>epsilon)&&(iter<100000000))
    iter=iter+1;
    t=s;
    while (fun_val-f(xSList, tSList,x-t*grad)<alpha*t*norm(grad)^2)
        t=beta*t;
    end
    x=x-t*grad;
    fun_val=f(xSList, tSList, x);
    grad=g(xSList, tSList, x);
end
if iter == 100000000
    fprintf('failed to converge\n');
    return;
end
fprintf('iter_number = %3d norm_grad = %10.11f fun_val = %10.11f \n',iter,norm(grad),fun_val);
end

% Objective function for the satellites and xV
function out = F(xSList, tSList, xV)
    sz = size(xSList); % xSList and tSList should have same number of cols
    out = 0;
    c = 2.997924580000000000E+08;
    for i=1:sz(2)-1
        out = out + (norm(xV - xSList(:,i)) - norm(xV - xSList(:,i+1)) - c*(tSList(i+1) - tSList(i)))^2;
    end
end

% Gradient of objective function for the satellites and xV
function out = G(xSList, tSList, xV)
    sz = size(xSList); % xSList and tSList should have same number of cols
    out = 0;
    c = 2.997924580000000000E+08;
    for i=1:sz(2)-1
        p1 = norm(xV - xSList(:,i)) - norm(xV - xSList(:,i+1)) - c*(tSList(i+1) - tSList(i));
        p2 = ((xV - xSList(:,i))/norm(xV - xSList(:,i))) - ((xV - xSList(:,i+1))/norm(xV - xSList(:,i+1)));
        out = out + p1*p2;
    end
    out = out*2;
end
