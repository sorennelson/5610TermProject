function [cart_vehicles] = vehtocart(vehicles, R, s)
%VEHTOCART Returns a matrix of all vehicles converted to cartesian
%coordinates
cart_vehicles = zeros(size(vehicles,1), 3);
for row=1:size(vehicles,1)
    NS = vehicles(row, 5);
    theta = NS * dmstorad(vehicles(row, 2), vehicles(row, 3), vehicles(row, 4));
    
    EW = vehicles(row, 9);
    phi = EW * dmstorad(vehicles(row, 6), vehicles(row, 7), vehicles(row, 8));
    
    time = vehicles(row, 1);
    alt = R + vehicles(row, 10);
    
    cart_vehicles(row, 1) = alt * sin(theta) * cos(phi + 2*pi * time/s);
    cart_vehicles(row, 2) = alt * sin(theta) * sin(phi + 2*pi * time/s);
    cart_vehicles(row, 3) = alt * cos(theta);
end
end

