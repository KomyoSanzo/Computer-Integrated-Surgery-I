function [ u ] = ScaleToBox(x)
u = zeros(size(x));

for i = 1:3
    min = min(q(:,i));
    max = max(q(:,i));
    u(:,i) = (x-x_min)/(x_max-x_min);
end

end
