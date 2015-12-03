function [ returnTree ] = generateKDTree(level, listOfTriangles, centroids)
    %Generates the KDTree object class by converting each triangle into a
    %centroid point and splits it along each axis using recursion.
    %INPUT: level. The current level of the node being generated
    %INPUT: listOfTriangles a 1xn sized cell where each cell contains a 3x3
    %matrix holding the vertices of each triangle.
    %INPUT: centroids. The center of each triangle calculated by averaging
    %the vertices. nx4 where the 4th value is the index against the
    %listOfTriangles.
    %OUTPUT: the center node of the current iteration. It is the root in
    %the original call.
    
    %Check if there is only one point left to iterate through
    if size(centroids, 1) == 1
        returnTree = Node(centroids(:,1:3), centroids(:,4), level);
        returnTree.vertices = listOfTriangles{centroids(:,4)};
        return;
    end
    
    
    %determines the x, y, or z axis
    axis = mod(level, 3) + 1;

    
    %sort along relevant axis
    sortedCenters = sortrows(centroids, axis);
    
    
    median = round(size(centroids,1)/2);
        
    %check if there is an odd number of triangles left and splits the
    %remaining triangles into two while maintaing a center point.
    if mod(size(centroids, 1), 2) == 0
        centerPoint = sortedCenters(median+1, :);
        left = sortedCenters(1:median, :);
        right = sortedCenters(median+2:end, :);
        
    else
        centerPoint = sortedCenters(median, :);
        left = sortedCenters(1:median-1,:);
        right = sortedCenters(median+1:end, :);
    end
    
    
    %generate the center node
    index = centerPoint(4);
    centerNode = Node(centerPoint(1:3), index, level);
    centerNode.vertices = listOfTriangles{index};
    
    
    %Generate left and right child branches
    if size(left, 1) >= 1
        leftNode = generateKDTree(level +1, listOfTriangles, left);
        leftNode.parent = centerNode;
  
        centerNode.leftNode = leftNode;
    end
    if size(right, 1) >= 1
        rightNode = generateKDTree(level +1, listOfTriangles, right);
        rightNode.parent = centerNode;
        
        centerNode.rightNode= rightNode;
    end
    
    %return current center node.
    returnTree = centerNode;
end

