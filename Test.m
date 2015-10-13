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
        [RD, pD] = CloudToCloud(dCloud, readings{n,1});
        [RA, pA] = CloudToCloud(aCloud, readings{n,2});
        [RC, pC] = CloudToCloud(cCloud, readings{n,3});
        for i = 1:size(cCloud)
            difference = readings{n,3}(i,:) - (RC*cCloud(i, :).' + pC).';
            difference = sqrt(difference*difference');
            if difference > 20
                disp('Error: C frame transformation is incorrect');
            end
        end
        for i = 1:size(aCloud)
            difference = readings{n,2}(i,:) - (RA*aCloud(i, :).' + pA).';
            difference = sqrt(difference*difference');
            if difference > 1
                disp('Error: A frame transformation is incorrect');
            end
        end
        for i = 1:size(dCloud)
            difference = readings{n,1}(i,:) - (RD*dCloud(i, :).' + pD).';
            difference = sqrt(difference*difference');
            if difference > 1
                disp('Error: B frame transformation is incorrect');
            end
        end
    end
    OutputTest(name, 10);
end