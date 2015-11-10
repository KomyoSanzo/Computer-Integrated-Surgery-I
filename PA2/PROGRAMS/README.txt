Erica Schwarz
Willis Wang

Main.m
Main.m is the driver function. It takes in the name prefix of the data and uses the remaining files as helper functions to calculate and produce the desired output.

Parse.m
Parse.m takes in the name prefix and returns formatted matrices with the data included in each relevant textfile.

CloudToCloud.m
CloudToCloud.m calculates the rotation and displacement from one point cloud system to another and returns the rotation matrix and the displacement vector.

PivotCalibration.m
	PivotCalibration.m takes a list of rotations and translations and uses the pivot calibration algorithm above to return vectors for the estimated dimple position and the pivot position.

VectorAverage.m
VectorAverage is used to compute the average value of a given vector list. It takes in a vector list and returns a vector with the average values.

PostPosition.m
	PostPosition.m is used to calculate the position of the dimple relative to EM tracker base. It takes in a nested cell of frames and poses, calculates the local probe coordinates using data, finds the frame transformations using CloudToCloud and then passes the resulting list of rotations and translations to PivotCalibration.m and returns the resulting position vector as well as the adjusted cloud data for each frame.

CalculateCoefficients.m
	CalculateCoefficients.m is used to find the coefficient matrix C for use in the distortion correction algorithm. It works by taking in adjusted values u and ground truth values p. The adjusted values are then used to construct a 5th-order Bernstein polynomial which are used to solve the least squares problem of FC = p. These coefficients are then returned for later use
. 
CorrectDistortion.m
	CorrectDistortion.m calculates the F matrix by reading in the scaled values u as a parameter. This F matrix is then used to multiply the coefficient matrix, and the resulting output is the adjusted values, which are returned. 

GetLocations.m
	GetLocations.m finds the fiducial points in the EM frame by using the Pcal value from the pivot calibration step. It takes in an average vector value and is used to adjust each point in the cloud. Then a transformation [R, p] is calculated for each frame and is applied to Pcal. 

GetLocationsReg.m
	Uses the registration points from the EM tracker to calculate the locations of the navigational points.

ScaleToBox.m
	ScaleToBox.m takes in a cell-array containing each frame’s data as well as a scaling minimum and maximum along each axis. This is then used to scale all of the data in the cell-array to a value between 0 and 1 for use in the distortion correction algorithm for use in the Bezier curve.

ScaleToBox2.m
	ScaleToBox2.m takes in a cell-array and traverses along each axis to determine the minimum and maximum for each x, y, and z. These values are then used to scale the cell-array to a value between 0 and 1 for use in the distortion algorithm. These values as well as the calculated minimum and maximum are then returned. 
Test.m