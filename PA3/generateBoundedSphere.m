function [ center, radius ] = generateBoundedSphere( triangle_vertices )
    function [distance] = findDistance(pointA, pointB)
        distance = Math.sqrt((pointA(1)-pointB(1))^2 + ...
            (pointA(2)-pointB(2))^2 + (pointA(3)-pointB(3))^2);
    end

    distA = findDistance(triangle_vertices(1,:), triangle_vertices(2,:));
    distB = findDistance(triangle_vertices(1,:), triangle_vertices(3,:));
    distC = findDistance(triangle_vertices(2,:), triangle_vertices(3,:));
    
    if distA > distB
        if distA > distC
            a = triangle_vertices(1,:);
            b = triangle_vertices(2,:);
            c = triangle_vertices(3,:);            
        else
            a = triangle_vertices(3,:);
            b = triangle_vertices(2,:);
            c = triangle_vertices(1,:);
        end
    else
        if distB > distC
            a = triangle_vertices(1,:);
            b = triangle_vertices(3,:);
            c = triangle_vertices(2,:);            
        else
            a = triangle_vertices(3,:);
            b = triangle_vertices(2,:);
            c = triangle_vertices(1,:);            
        end
    end
    
    
    q = (a+b)/2;
    if dot(b-q, b-q) == dot(a-q,a-q) ...
        && dot(c-q, c-q) <= dot(a-q, a-q) ...
        && dot(cross(b-a,c-a), q-a) == 0
        radius = q-a;
        center = q;
        return
    else
        f = (a+b/2);
        u = a-f;
        v = c-f;
        d = cross(cross(u,v),u);
        gamma = (dot(v, v) - dot(u, u))/(dot(2*d, v-u));
        if gamma <= 0
            lambda = 0;
        else
            lambda = gamma;
        end
        
        center = f + lambda * d;
        radius = norm(center-a);      
    end 
end
    
      