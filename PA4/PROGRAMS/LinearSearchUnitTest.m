%3 TRIANGLES ARRANGED AS A PLANE
triangle_1 = [[0 0 0];[0 1 0]; [1 0 0]];
triangle_2 = [[1 0 0];[0 1 0]; [1 1 0]];
triangle_3 = [[1 1 0];[1 0 0]; [2 0 0]];
mesh = {triangle_1, triangle_2, triangle_3};
assert(isequal(linearSearch(mesh, [0 0 -1]),[0 0 0]));
assert(isequal(linearSearch(mesh, [1 1 2]),[1 1 0]));
assert(isequal(linearSearch(mesh, [-1 -1 3]), [0 0 0]));
assert(isequal(round(linearSearch(mesh, [2.5 1.3 5]),4),[1.6 0.4 0]));
assert(isequal(linearSearch(mesh, [4 2 -1.5]), [2 0 0]));

%6 TRIANGLES ARRANGED AS A 3D OBJECT
triangle_1 = [[0 0 0];[0 1 0];[1 0 0]];
triangle_2 = [[1 0 0];[0 1 0];[1 1 0]];

triangle_3 = [[0 0 0];[0 0 1];[1 0 0]];
triangle_4 = [[0 0 1];[0 1 0];[0 1 1]];

triangle_5 = [[0 0 0];[0 0 1];[0 1 0]];
triangle_6 = [[0 0 1];[1 0 0];[1 0 1]];
mesh = {triangle_1, triangle_2, triangle_3, triangle_4, triangle_5, triangle_6};
assert(isequal(linearSearch(mesh, [.5 .5 1.5]), [0 0.5 1]));
assert(isequal(linearSearch(mesh, [.5 .5 0]),[0.5 0.5 0]));
assert(isequal(linearSearch(mesh, [1.5 -.5 1.5]), [1 0 1]));
assert(isequal(linearSearch(mesh, [1.5 2.5 .75]), [1 1 0]));