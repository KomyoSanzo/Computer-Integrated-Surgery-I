function position = PostPosition(pivot)
    
    cloud = cell(length(pivot), 1);
    average = VectorAverage(pivot{1});
    
    for i = 1:length(pivot)
        cloud{i} = pivot{i};
        for j = 1:length(pivot{i})
            cloud{i}(j,:) = cloud{i}(j,:) - average;
        end
    end
    
    Rlist = cell(1, size(cloud,2));
    plist = cell(1, size(cloud,2));
    
    for i = 1:size(cloud, 1)
        [Rlist{i}, plist{i}] = CloudToCloud(pivot{i}, cloud{1});
    end
    
    [position, ~] = PivotCalibration(Rlist, plist);
end