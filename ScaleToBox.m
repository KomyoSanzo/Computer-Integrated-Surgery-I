function [ u ] = ScaleToBox( x, min, max )
%SCALETOBOX Summary of this function goes here
%   Detailed explanation goes here
u = cell(size(x));

for i = 1:length(x)
    u{i} = zeros(size(x{i}));
end


for i = 1:3
    for j = 1:length(x)
        u{j}(:,i) = (x{j}(:,i)-min)/(max-min);
    end
end


end

