function Test(name)
    
    [calbody, readings, empivot, optpivot] = Parse(name);
    
    %get calbody readings
    dCloud = calbody{1};
    aCloud = calbody{2};
    cCloud = calbody{3};
    
    %CloudToCloud testing
    %Tests to see if using the frame transformation on the cloud points
    %returns value very close to original points. Ensures correct
    %rotation and displacement were returned.
    
    for n = 1:size(readings, 1)
        Cest = zeros(size(readings{n,3}));
        [RD, pD] = CloudToCloud(dCloud, readings{n,1});
        [RA, pA] = CloudToCloud(aCloud, readings{n,2});
        [RC, pC] = CloudToCloud(cCloud, readings{n,3});
        for i = 1:size(cCloud)
            Cest(i,:) = RC*cCloud(i, :).' + pC;
        end
        for i = 1:size(aCloud)
            Cest(i,:) = RA*aCloud(i, :).' + pA;
        end
        for i = 1:size(dCloud)
            Cest(i,:) = RA*aCloud(i, :).' + pA;
        end
    end
    
    disp(PostPosition(empivot));
    
    disp(readings{1,3});
    for i = 1:size(readings{1,3})
        disp((RC*cCloud(i,:).' + pC).');
    end