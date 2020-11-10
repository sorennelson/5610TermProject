clear

% Official receiver driver code for Math 5610 group project at the
% University of Utah

fID = fopen('receiver_out.txt', 'w');
fprintf('Type "quit" or enter nothing to exit when finished.\n');
filename = input('Please enter the satellite file (e.g. sat1.txt) you would like analyzed:\n', 's');
while strcmp(filename, 'quit') == 0 && strcmp(filename, '') == 0
    [iS, tS, x1S, x2S, x3S] = textread(filename, '%d %f %f %f %f');
    % Set up method params
    xSList = zeros(3,1);
    for i=1:size(iS,1)
        xSList(:,i) = [x1S(i), x2S(i), x3S(i)];
    end
    [tV, xV] = vehicle_solve(xSList, tS);
    conv = carttoveh(tV, xV(1), xV(2), xV(3));
    fprintf(fID, strcat(filename,':\n'));
    fprintf(fID, '%7.2f %d %d %2.4f %d %d %d %2.4f %d %11.2f\n', conv(1),conv(2),conv(3),conv(4),conv(5),conv(6),conv(7),conv(8),conv(9),conv(10));
    fprintf('\n');
    filename = input('Please enter the satellite file (e.g. sat1.txt) you would like analyzed:\n', 's');
end
fclose(fID);


