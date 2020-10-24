function [deg, min, sec] = radtodms(x)
    theta = (180*x)/pi;
    deg = floor(theta);
    m = (theta-deg)*60;
    min = floor(m);
    sec = round(((m-min)*60), 4);
end
