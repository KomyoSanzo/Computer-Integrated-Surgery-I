Erica Schwarz
Willis Wang

Main.m- Driver function that name prefix of the data and uses the remaining
        files as helper functions to calculate and produce the desired
        output.

Parse.m- Takes in the name prefix and returns formatted matrices with the
         data included in each relevant textfile.

CloudToCloud.m- Calculates the rotation and displacement from one point
                cloud system to another and returns the rotation matrix
                and the displacement vector.

linearSearch.m- Uses a linear search to find the closest point on a given
                mesh to a given point.

generateBoundedSphere.m- Generates a bounding sphere around a given
                         triangle.

closestPointOnTriangle.m- Finds the closest point on a given triangle to a
                          given point.

VectorAverage.m- Finds the average point in a 3D point list.

Test.m