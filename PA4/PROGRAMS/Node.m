classdef Node < handle
    %NODE A node class for the KDTree
    
    properties
        leftNode =[]; %left child
        rightNode =[]; %right child
        parent = [];
        center = [0, 0, 0]; %average of the vertices
        vertices = zeros(3, 3); %The triangle vertices
        
        level; %level of the node
        index; %index of the axis of the node
        
        
    end
    
    methods
        %constructor
        %INPUT: cent. the center of the triangle.
        %INPUT: ind. The index of the triangle.
        %INPUT: l. the level of the triangle
        %OUTPUT: The object class.
        function obj = Node(cent, ind, l)
            obj.center = cent;
            obj.index = ind;
            obj.level = l;
        end
        
        %checks if a left child exists
        function returnVal = hasLeft(obj)
            if isempty(obj.leftNode)
                returnVal = false;
            else
                returnVal = true;
            end
        end
        
        %checks if a right child exists
        function returnVal = hasRight(obj)
            if isempty(obj.rightNode)
                returnVal = false;
            else
                returnVal = true;
            end
        end
        
        
        %checks if is a leaf
        function returnVal = isLeaf(obj)
            if obj.hasRight() || obj.hasLeft()
                returnVal = false; 
            else
                returnVal = true;
            end
        end
        
    end
    
end

