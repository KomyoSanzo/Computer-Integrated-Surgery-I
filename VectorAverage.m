function [ outputVector] = VectorAverage( inputMatrix)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

mean_x = 0;
mean_y = 0;
mean_z = 0;

for i = 1:length(inputMatrix(:,1))
    mean_x = mean_x + inputMatrix(i,1);
    mean_y = mean_y + inputMatrix(i,2);
    mean_z = mean_z + inputMatrix(i,3);
end


outputVector = [mean_x, mean_y, mean_z]/length(inputMatrix(:,1));

end

