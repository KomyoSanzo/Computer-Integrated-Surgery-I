function [ closestPoint ] = linearSearch( mesh, point)

closestPoint = closestPointOnTriangle(mesh{1}, point);
minDistance = sqrt((point(1)-closestPoint(1))^2+(point(2)-closestPoint(2))^2+(point(3)-closestPoint(3))^2 );

for i = 2:length(mesh)
    testPoint = closestPointOnTriangle(mesh{i}, point);
    testDistance = sqrt((point(1)-testPoint(1))^2+(point(2)-testPoint(2))^2+(point(3)-testPoint(3))^2);
    
    if testDistance < minDistance
        closestPoint = testPoint;
        minDistance = testDistance;
    end
end


end

