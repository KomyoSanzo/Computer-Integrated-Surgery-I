function [ u ] = ScaleToBox(x, x_min, x_max)
u = (x-x_min)/(x_max-x_min)
end