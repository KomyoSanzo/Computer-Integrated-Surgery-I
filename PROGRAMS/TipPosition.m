function [Pcal, Ppiv, cloud] = TipPosition(points)
%POSTPOSITION Finds the post position by calculating the average and
%performing pivot calculation to the different frames

    %An empty cloud is created and the initial average/frame is calculated
    cloud = zeros(size(points));
    average = VectorAverage(points);
    
    %Each value in the cloud is adjusted by the initial average calculated
    %in the first frame
    for i = 1:size(points, 1)
        cloud(i, :) = points(i, :) - average;
    end
    
    %Each R and p is calculated and added
    [Rlist, plist] = CloudToCloud(points, cloud);
    
    %List of R's and p's are used to calculate position using the
    %PivotCalibration function
    [Pcal, Ppiv] = PivotCalibration(Rlist, plist);
end