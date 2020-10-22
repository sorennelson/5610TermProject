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

