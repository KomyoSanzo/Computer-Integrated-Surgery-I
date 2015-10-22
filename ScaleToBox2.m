function [ u, min, max ] = ScaleToBox2(x)
u = cell(size(x));

for i = 1:length(x)
    u{i} = zeros(size(x{i}));
end


for i = 1:3
    min = x{1}(1,i);
    max = x{1}(1,i);
    
    for j = 1:length(x)
        if max(x{j}(:,i)) > max
            max = max(x{j}(:,i));
        end
        
        if min(x{j}(:,i)) < min
            min = min(x{j}(:,i));
        end
    end
    for j = 1:length(x)
        u{j}(:,i) = (x{j}(:,i)-min)/(max-min);
    end
end



