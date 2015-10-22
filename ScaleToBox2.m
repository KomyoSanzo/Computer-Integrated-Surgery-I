function [ u, mini, maxi ] = ScaleToBox2(x)
u = cell(size(x));

for i = 1:length(x)
    u{i} = zeros(size(x{i}));
end


for i = 1:3
    mini = x{1}(1,i);
    maxi = x{1}(1,i);
    
    for j = 1:length(x)
        if max(x{j}(:,i)) > maxi
            maxi = max(x{j}(:,i));
        end
        
        if min(x{j}(:,i)) < mini
            mini = min(x{j}(:,i));
        end
    end
    for j = 1:length(x)
        u{j}(:,i) = (x{j}(:,i)-mini)/(maxi-mini);
    end
end



