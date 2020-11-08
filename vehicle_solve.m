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
PI = 3.141592653589793116;


end

% Backtracking gradient descent method used to solve for xV
% Some slight tweaks will need to be made to this
function [x,fun_val]=gradient_method_backtracking(f,g,x0,s,alpha,beta,epsilon)
% Gradient method with backtracking stepsize rule
%
% INPUT
%=======================================
% f ......... objective function
% g ......... gradient of the objective function
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
grad=g(x);
fun_val=f(x);
iter=0;
while ((norm(grad)>epsilon)&&(iter<100000000))
    iter=iter+1;
    t=s;
    while (fun_val-f(x-t*grad)<alpha*t*norm(grad)^2)
        t=beta*t;
    end
    x=x-t*grad;
    fun_val=f(x);
    grad=g(x);
end
fprintf('iter_number = %3d norm_grad = %2.6f fun_val = %2.6f \n',iter,norm(grad),fun_val);
end

% Objective function for the satellites and xV
function out = F(satellites, xV)
end

% Gradient of objective function for the satellites and xV
function out = G(satellites)
end
