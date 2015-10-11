function [ R, p ] = C2C( listOfPointsA, listOfPointsB )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

numberOfPoints = length(listOfPointsA(:,1));

averageA = VectorAverage(listOfPointsA);
averageB = VectorAverage(listOfPointsB);

adjustedA = listOfPointsA;
adjustedB = listOfPointsB;

for i = 1:numberOfPoints
    adjustedA(i,:) = adjustedA(i,:) - averageA.';   
    adjustedB(i,:) = adjustedB(i,:) - averageB.';   
end

%Computing H

H = zeros(size(listOfPointsA));
for i = 1:numberOfPoints
    H = H + [adjustedA(i,1)*adjustedB(i,1) adjustedA(i,1)*adjustedB(i,2) adjustedA(i,1)*adjustedB(i,3);
        adjustedA(i,2)*adjustedB(i,1) adjustedA(i,2)*adjustedB(i,2) adjustedA(i,2)*adjustedB(i,3);
        adjustedA(i,3)*adjustedB(i,1) adjustedA(i,3)*adjustedB(i,2) adjustedA(i,3)*adjustedB(i,3)
        ];
end

delta = [H(2,3)-H(3,2) H(3,1)-H(1,3) H(1,2)-H(2,1)].';
G = [trace(H) delta.'; delta H+H.'-trace(H)*eye];
[V, D] = eig(G);

[~, I] = max(diag(D));

q = V(:, I);

R = [q(1)*q(1)+q(2)*q(2)-q(3)*q(3)-q(4)*q(4) 2*(q(2)*q(3)-q(1)*q(4)) 2*(q(2)*q(4)+q(1)*q(3));
    2*(q(2)*q(3)+q(1)*q(4)) q(1)*q(1)-q(2)*q(2)+q(3)*q(3)-q(4)*q(4) 2*(q(3)*q(4)-q(1)*q(2));
    2*(q(2)*q(4)-q(1)*q(3)) 2*(q(3)*q(4)+q(1)*q(2)) q(1)*q(1)-q(2)*q(2)-q(3)*q(3)+q(4)*q(4)];

p = averageB - R*averageA;

end

