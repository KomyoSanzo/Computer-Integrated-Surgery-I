function [ c ] = closestPointOnTriangle( triangle, point )
    %Finds the closest point on a given triangle to the given point.
    %INPUT: The points of a triangle and the point to find the closest
    %distance on the triangle to.
    %OUTPUT: The closest point on the triangle to the given point.

    p = triangle(1,:);
    q = triangle(2,:);
    r = triangle(3,:);
    
    normal = cross((q-p),(r-q));
    
    lstSquares = [(q(1)-p(1)) (r(1)-p(1)) normal(1); (q(2)-p(2)) (r(2)-p(2)) normal(2); (q(3)-p(3)) (r(3)-p(3)) normal(3)]\(point-p).';
    lambda=lstSquares(1);
    mu=lstSquares(2);
    c = p + lambda*(q-p) + mu*(r-p);
    
    if lambda < 0
        c=ProjectOnSegment(c,r,p);
    elseif mu < 0
        c=ProjectOnSegment(c,p,q);
    elseif lambda + mu > 1
        c=ProjectOnSegment(c,q,r);
    else
        return;
    end

    function [ c ] = ProjectOnSegment(c,p,q)
        lmbda = dot(c-p, q-p)/dot(q-p,q-p);
        lmbda = max([0 min([lmbda 1])]);
        c = p + lmbda*(q-p);
    end

end

