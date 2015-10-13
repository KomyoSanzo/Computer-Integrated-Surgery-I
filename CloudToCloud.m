function [ R, p ] = CloudToCloud( listOfPointsA, listOfPointsB )
%CloudToCloud This function calculates the cloud-to-cloud rigid body
%transformation based on two input variables.
%   The two input variables should composed of an Nx3 sized arrays, where N
%   is the number of vectors in each cloud. The first, second, and third
%   indices should be the x, y, and z coordinates, respectively. 

%The number of points for both variables should be the same. 
numberOfPoints = length(listOfPointsA(:,1));

%Vector averages are found for both clouds
averageA = VectorAverage(listOfPointsA);
averageB = VectorAverage(listOfPointsB);

%Initalize the adjusted arrays
adjustedA = listOfPointsA;
adjustedB = listOfPointsB;

%Recenter each value to the average vector computed above
for i = 1:numberOfPoints
    adjustedA(i,:) = adjustedA(i,:) - averageA;   
    adjustedB(i,:) = adjustedB(i,:) - averageB;   
end

%Computing H

H = zeros(3);
for i = 1:numberOfPoints
    test = [adjustedA(i,1)*adjustedB(i,1) adjustedA(i,1)*adjustedB(i,2) adjustedA(i,1)*adjustedB(i,3); adjustedA(i,2)*adjustedB(i,1) adjustedA(i,2)*adjustedB(i,2) adjustedA(i,2)*adjustedB(i,3); adjustedA(i,3)*adjustedB(i,1) adjustedA(i,3)*adjustedB(i,2) adjustedA(i,3)*adjustedB(i,3)];
    
    H = H + test;
end

%Calculate G from H and perform eigenvalue decomposition
delta = [H(2,3)-H(3,2) H(3,1)-H(1,3) H(1,2)-H(2,1)].';
G = [trace(H) delta.'; delta H+H.'-trace(H)*eye(3)];
[V, D] = eig(G);


%find the index of the maximum eigenvalue and its related vector
[~, I] = max(diag(D));
q = V(:, I);

%Calculate and return R and p
R = [q(1)*q(1)+q(2)*q(2)-q(3)*q(3)-q(4)*q(4) 2*(q(2)*q(3)-q(1)*q(4)) 2*(q(2)*q(4)+q(1)*q(3));
    2*(q(2)*q(3)+q(1)*q(4)) q(1)*q(1)-q(2)*q(2)+q(3)*q(3)-q(4)*q(4) 2*(q(3)*q(4)-q(1)*q(2));
    2*(q(2)*q(4)-q(1)*q(3)) 2*(q(3)*q(4)+q(1)*q(2)) q(1)*q(1)-q(2)*q(2)-q(3)*q(3)+q(4)*q(4)];


p = averageB.' - R*averageA.';

end

