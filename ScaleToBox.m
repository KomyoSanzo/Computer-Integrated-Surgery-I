function [ u ] = ScaleToBox(x)
    u = cell(size(x));
    for j = 1:length(u)
        u{j} = zeros(size(x{j}));
        for i = 1:3
            min_var = min(x{j}(:,i));
            max_var = max(x{j}(:,i));
            u{j}(:,i) = (x{j}(:,i)-min_var)/(max_var-min_var);
        end
    end
end
