function [ u ] = ScaleToBox(x)
<<<<<<< HEAD
    u = cell(size(x))
    
    for j = length(u)
        u{j} = zeros(size(x));

        for i = 1:3
            min = min(x{j}(:,i));
            max = max(x{j}(:,i));
            u{j}(:,i) = (x-x_min)/(x_max-x_min);
        end
    end
=======
u = zeros(size(x));


for i = 1:3
    min = min(q(:,i));
    max = max(q(:,i));
    u(:,i) = (x-x_min)/(x_max-x_min);
end


>>>>>>> 94f6e2fd19b86377621a47dc4e9a8f4101b49f50
end
