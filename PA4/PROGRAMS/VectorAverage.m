function [ outputVector] = VectorAverage( inputMatrix)
%VECTORAVERAGE takes in an Nx3 list of vectors and returns the average of
%the vectors.
%INPUT: List of 3 dimensional points.
%OUPUT: The average of all the points.
%   The x, y, and z components of the individal vectors are averaged
%   together to return one single average

outputVector = mean(inputMatrix);

end

