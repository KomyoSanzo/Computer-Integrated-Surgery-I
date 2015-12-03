function [minimumDistance, closestPoint] = KDTreeSearch( node, level, point, currentDistance, currentPoint)
    %Searches through the KDTree and searches for the closest point along
    %the mesh. Recursion is used to traverse through the tree and check for
    %edge cases on the call back.
    %INPUT: node. The current node to be traversed.
    %INPUT: level. The current level in the tree.
    %INPUT: point. The point to be compared against.
    %INPUT: currentDistance. The distance that is currently held in 
    %memory and to be compared against 
    %INPUT: currentPoint. The current minimum distance that is held in
    %memory and compared against.
    %OUTPUT: minimumDistance. The minimum distance from the desired point
    %and the point on the mesh.
    %OUTPUT: closestPoint. The closest point on the mesh to the input
    %point.

%The x,y,z axis currently looked at
axis = mod(level, 3) + 1;

%Check if the node is a leaf. If so, set new minimum values
if node.isLeaf()
    closestPoint = closestPointOnTriangle(node.vertices,point);
    minimumDistance= norm(closestPoint - point);
    
    if minimumDistance > currentDistance
        minimumDistance = currentDistance;
        closestPoint = currentPoint;
    end

    return;
end

%If the node contains a specific child and the point lies on that side of
%the axis, then proceed into that child node. 
if node.hasRight() && point(axis) >= node.center(axis)
    [minimumDistance, closestPoint] = KDTreeSearch(node.rightNode, level+1, point, currentDistance, currentPoint);
elseif node.hasLeft() && point(axis) < node.center(axis)
    [minimumDistance, closestPoint] = KDTreeSearch(node.leftNode, level+1, point, currentDistance, currentPoint);
else %Case where it cannot traverse further. 
    minimumDistance = currentDistance;
    closestPoint = currentPoint;
end


%Checks the possibility of the point existing on the otherside of the
%hyperplane. NOTE: Potential errors can arise here as we're comparing
%against a single point as opposed to a mesh. This needs to be hard checked
%against a linear search when there is a large error. 
if point(axis) >= node.center(axis) && node.hasLeft() && point(axis) - minimumDistance <= node.center(axis)
    [minimumDistance, closestPoint] = KDTreeSearch(node.leftNode, level+1, point, minimumDistance, closestPoint);
elseif node.hasRight() && point(axis) + minimumDistance >= node.center(axis)
    [minimumDistance, closestPoint] = KDTreeSearch(node.rightNode, level+1, point, minimumDistance, closestPoint);
end

%Check against current node
testClosest = closestPointOnTriangle(node.vertices, point);
testDistance = norm(testClosest-point);

if testDistance < minimumDistance
    minimumDistance = testDistance;
    closestPoint = testClosest;
end

end


