function [ u ] = ScaleToBox2(x)
u = cell(size(x));

for i = 1:length(x)
    u{i} = zeros(size(x{i}));
end


for i = 1:3
    global_min = x{1}(1,i);
    global_max = x{1}(1,i);
    
    for j = 1:length(x)
        if max(x{j}(:,i)) > global_max
            global_max = max(x{j}(:,i));
        end
        
        if min(x{j}(:,i)) < global_min
            global_min = min(x{j}(:,i));
        end
    end
    for j = 1:length(x)
        u{j}(:,i) = (x{j}(:,i)-global_min)/(global_max-global_min);
    end
end



