function [radians] = dmstorad(x,y,z)
    theta = (x + y/60 + z/3600);
    radians = (pi*theta)/180;
end