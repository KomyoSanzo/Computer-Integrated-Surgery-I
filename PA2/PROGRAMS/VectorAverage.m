function [ outputVector] = VectorAverage( inputMatrix)
%VECTORAVERAGE takes in an Nx3 list of vectors and returns the average of
%the vectors
%   The x, y, and z components of the individal vectors are averaged
%   together to return one single average

outputVector = mean(inputMatrix);

end

