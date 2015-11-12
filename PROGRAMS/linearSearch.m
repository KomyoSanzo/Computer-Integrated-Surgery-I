function [ closestPoint ] = linearSearch( mesh, point)
    %Uses and linear search to find the closest point on a mesh to a given
    %point.
    %INPUT: A point and a mesh we went to find the closest point on.
    %OUTPUT: The closest point on the mesh to the given point.
    
    %Initialize search
    closestPoint = closestPointOnTriangle(mesh{1}, point);
    minDistance = sqrt((point(1)-closestPoint(1))^2+(point(2)-closestPoint(2))^2+(point(3)-closestPoint(3))^2 );

    %Iterate through every point on mesh and test distance. If smaller than
    %current min, replace as closest point.
    for i = 2:length(mesh)
        testPoint = closestPointOnTriangle(mesh{i}, point);
        testDistance = sqrt((point(1)-testPoint(1))^2+(point(2)-testPoint(2))^2+(point(3)-testPoint(3))^2);

        if testDistance < minDistance
            closestPoint = testPoint;
            minDistance = testDistance;
        end
    end


end

