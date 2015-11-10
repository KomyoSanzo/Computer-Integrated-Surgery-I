function [Pcal, Ppiv, cloud] = PostPosition(pivot)
%POSTPOSITION Finds the post position by calculating the average and
%performing pivot calculation to the different frames

    %An empty cloud is created and the initial average/frame is calculated
    cloud = cell(length(pivot), 1);
    average = VectorAverage(pivot{1});
    
    %Each value in the cloud is adjusted by the initial average calculated
    %in the first frame
    for i = 1:length(pivot)
        cloud{i} = pivot{i};
        for j = 1:length(pivot{i})
            cloud{i}(j,:) = cloud{i}(j,:) - average;
        end
    end
    
    %List of rotation matrices R and translations p are initialized
    Rlist = cell(1, size(cloud,2));
    plist = cell(1, size(cloud,2));
    
    %Each R and p is calculated and added
    for i = 1:size(cloud, 1)
        [Rlist{i}, plist{i}] = CloudToCloud(pivot{i}, cloud{1});
    end
    
    %List of R's and p's are used to calculate position using the
    %PivotCalibration function
    [Pcal, Ppiv] = PivotCalibration(Rlist, plist);
end