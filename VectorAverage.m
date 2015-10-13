function [ outputVector] = VectorAverage( inputMatrix)
%VECTORAVERAGE takes in an Nx3 list of vectors and returns the average of
%the vectors
%   The x, y, and z components of the individal vectors are averaged
%   together to return one single average

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

