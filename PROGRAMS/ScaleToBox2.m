function [ u, mini, maxi ] = ScaleToBox2(x)

u = cell(size(x));

mini = zeros(1,3);
maxi = zeros(1,3);

for i = 1:length(x)
    u{i} = zeros(size(x{i}));
end


for i = 1:3
    mini(i) = x{1}(1,i);
    maxi(i) = x{1}(1,i);
    
    for j = 1:length(x)
        if max(x{j}(:,i)) > maxi(i)
            maxi(i) = max(x{j}(:,i));
        end
        
        if min(x{j}(:,i)) < mini(i)
            mini(i) = min(x{j}(:,i));
        end
    end
    for j = 1:length(x)
        u{j}(:,i) = (x{j}(:,i)-mini(i))/(maxi(i)-mini(i));
    end
end



