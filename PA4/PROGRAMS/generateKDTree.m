function [ returnTree ] = generateKDTree(level, listOfTriangles, centroids)
    
    if size(centroids, 1) == 1
        returnTree = Node(centroids(:,1:3), centroids(:,4), level);
        returnTree.vertices = listOfTriangles{centroids(:,4)};
    end
    
    axis = mod(level, 3) + 1;
    
    sortedCenters = sortrows(centroids, axis);
    
    
    median = round(size(centroids,1)/2);
        
    if mod(size(centroids, 1), 2) == 0
        centerPoint = sortedCenters(median+1, :);
        left = sortedCenters(1:median, :);
        right = sortedCenters(median+2:end, :);
        
    else
        centerPoint = sortedCenters(median, :);
        left = sortedCenters(1:median-1,:);
        right = sortedCenters(median+1:end, :);
    end
    
    index = centerPoint(4);
    centerNode = Node(centerPoint(1:3), index, level);
    centerNode.vertices = listOfTriangles{index};
    
    
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
    
    returnTree = centerNode;
end

