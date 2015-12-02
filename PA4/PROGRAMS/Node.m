classdef Node < handle
    %NODE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        leftNode =[];
        rightNode =[];
        parent = [];
        center = [0, 0, 0];
        vertices = zeros(3, 3);
        
        level;
        index;
        
        
        minimumDis = inf;
        closestPoint = [0, 0, 0];
        
    end
    
    methods
        
        function obj = Node(cent, ind, l)
            obj.center = cent;
            obj.index = ind;
            obj.level = l;
        end
        
        function returnVal = hasLeft(obj)
            if isempty(obj.leftNode)
                returnVal = false;
            else
                returnVal = true;
            end
        end
        
        function returnVal = hasRight(obj)
            if isempty(obj.rightNode)
                returnVal = false;
            else
                returnVal = true;
            end
        end
        
        function returnVal = isLeaf(obj)
            if obj.hasRight() || obj.hasLeft()
                returnVal = false; 
            else
                returnVal = true;
            end
        end
        
    end
    
end

