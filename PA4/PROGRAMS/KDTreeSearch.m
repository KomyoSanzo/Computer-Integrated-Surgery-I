function [minimumDistance, closestPoint] = KDTreeSearch( node, level, point, currentDistance, currentPoint)

axis = mod(level, 3) + 1;

if node.isLeaf()
    closestPoint = closestPointOnTriangle(node.vertices,point);
    minimumDistance= norm(closestPoint - point);
    
    if minimumDistance > currentDistance
        minimumDistance = currentDistance;
        closestPoint = currentPoint;
    end

    return;
    
end


if node.hasRight() && point(axis) >= node.center(axis)
    [minimumDistance, closestPoint] = KDTreeSearch(node.rightNode, level+1, point, currentDistance, currentPoint);
elseif node.hasLeft() && point(axis) < node.center(axis)
    [minimumDistance, closestPoint] = KDTreeSearch(node.leftNode, level+1, point, currentDistance, currentPoint);
else
    minimumDistance = currentDistance;
    closestPoint = currentPoint;
end


if point(axis) >= node.center(axis) && node.hasLeft() && point(axis) - minimumDistance <= node.center(axis)
    [minimumDistance, closestPoint] = KDTreeSearch(node.leftNode, level+1, point, minimumDistance, closestPoint);
elseif point(axis) < node.center(axis) && node.hasRight() && point(axis) + minimumDistance >= node.center(axis)
    [minimumDistance, closestPoint] = KDTreeSearch(node.rightNode, level+1, point, minimumDistance, closestPoint);
end

testClosest = closestPointOnTriangle(node.vertices, point);
testDistance = norm(testClosest-point);

if testDistance < minimumDistance
    minimumDistance = testDistance;
    closestPoint = testClosest;
end
end


