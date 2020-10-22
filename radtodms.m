function [deg, min, sec] = radtodms(x)
    theta = (180*x)/pi;
    d = floor(theta);
    m = (theta-d)*60;
    deg = d;
    min = floor(m);
    sec = floor(((m-floor(m))*60));
end