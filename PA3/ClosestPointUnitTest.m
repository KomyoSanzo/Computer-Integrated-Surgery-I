triangle = [[0 0 0];[0 1 0];[1 0 0]];
assert(isequal(closestPointOnTriangle(triangle, [.5 .5 .5]), [.5 .5 0]));
assert(isequal(closestPointOnTriangle(triangle, [.1 1.5 .15]), [0 1 0]));
assert(isequal(closestPointOnTriangle(triangle, [.1 .75 0]), [.1 .75 0]));
assert(isequal(closestPointOnTriangle(triangle, [1.5 1.5 0]), [.5 .5 0]));


triangle = [[0 0 0];[0 0 1];[1 0 0]];
assert(isequal(closestPointOnTriangle(triangle, [.5 .5 .5]), [.5 0 .5]));
assert(isequal(closestPointOnTriangle(triangle, [.1 1.5 .15]), [.1 0 .15]));
assert(isequal(closestPointOnTriangle(triangle, [.1 .75 0]), [.1 0 0]));
assert(isequal(closestPointOnTriangle(triangle, [1.5 1.5 0]), [1 0 0]));

triangle = [[0 0 0];[0 0 1];[0 1 0]];
assert(isequal(closestPointOnTriangle(triangle, [.5 .5 .5]), [0 .5 .5]));
assert(isequal(closestPointOnTriangle(triangle, [.1 1.5 .15]), [0 1 0]));
assert(isequal(closestPointOnTriangle(triangle, [.1 .75 0]), [0 .75 0]));
assert(isequal(closestPointOnTriangle(triangle, [1.5 1.5 0]), [0 1 0]));
