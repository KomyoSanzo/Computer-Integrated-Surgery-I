function g = GetLocations(pivot, Pcal)
%GetLocation finds the fiducial points in the EM frame by using the Pcal
%value from the pivot calibration step

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
    
    %Each point is calculated using the previously found Pcal value
    g = zeros(size(cloud, 1), 3);
    for i = 1:size(cloud, 1)
        point = Rlist{i}*Pcal + plist{i};
        g(i, 1) = point(1);
        g(i, 2) = point(2);
        g(i, 3) = point(3);
    end
    
end