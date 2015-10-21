function [ u ] = ScaleToBox(x)
    u = cell(size(x))
    
    for j = length(u)
        u{j} = zeros(size(x));

        for i = 1:3
            min = min(x{j}(:,i));
            max = max(x{j}(:,i));
            u{j}(:,i) = (x-x_min)/(x_max-x_min);
        end
    end
end
