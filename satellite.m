clear

% Load in data.dat
T = readtable('./data.dat');
T = table2array(T(:,1));
R = T(1);
s = T(2);

satellites = zeros(int16((size(T,1)-2)/9), 9);
sat_row = 1;
for row=3:size(T,1)
    satellites(sat_row, mod(row-3,9)+1) = T(row);
    if (mod(row-2,9) == 0)
        sat_row = sat_row + 1;
    end
end

% Load in vehicles
% Since we aren't using vehicle.class, instead use our own procedure with
% explanation provided in the report
% Grab the params of each 
[t, p1, p2, p3, NS, l1, l2, l3, EW, h] = textread('vehicles.txt', '%f %d %d %f %d %d %d %f %d %f');
vehicles = zeros(1,10);
% Convert vehicles to cartesian
for i=1:size(t,1)
    vehicles(i,:) = [t(i), p1(i), p2(i), p3(i), NS(i), l1(i), l2(i), l3(i), EW(i), h(i)];
end
cart_vehicles = vehtocart(vehicles, R, s);

xSList = zeros(3, 1);
tSList = zeros(1,1);
iSList = zeros(1,1);
satcount = 0;
% solve position and time of each satellite
for veh=1:size(vehicles,1)
    fID = fopen(strcat(strcat('sat', int2str(veh)), '.txt'), 'w');
    for i=1:24
        u = satellites(i,1:3)';
        v = satellites(i,4:6)';
        theta = satellites(i,9);
        tV = vehicles(veh, 1);
        xV = cart_vehicles(veh,:)';
        [tS, xS] = satellite_solve(u, v, theta, tV, xV);
        if (xS'*xV) >= R^2
            fprintf(fID, '%d %10.11f %f %f %f\n', i, tS, xS(1), xS(2), xS(3));
        end
    end
    fclose(fID);
end