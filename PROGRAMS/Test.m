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
    
    
    Caverage = 0;
    Daverage = 0;
    Aaverage = 0;
    
    for n = 1:size(readings, 1)
        [RD, pD] = CloudToCloud(dCloud, readings{n,1});
        [RA, pA] = CloudToCloud(aCloud, readings{n,2});
        [RC, pC] = CloudToCloud(cCloud, readings{n,3});
        
        averageError = 0;
        for i = 1:size(cCloud)
            difference = readings{n,3}(i,:) - (RC*cCloud(i, :).' + pC).';
            difference = sqrt(difference*difference');
            averageError = averageError + difference;
            if difference > 20
                disp('Error: C frame transformation is incorrect');
            end
        end
        averageError = averageError/length(cCloud);
        Caverage = Caverage+averageError;
        
        averageError = 0;
        for i = 1:size(aCloud)
            difference = readings{n,2}(i,:) - (RA*aCloud(i, :).' + pA).';
            difference = sqrt(difference*difference');        
            averageError = averageError + difference;
            
            if difference > 1
                disp('Error: A frame transformation is incorrect');
            end
        end
        averageError = averageError/length(aCloud);
        Aaverage = Aaverage + averageError;
        
        averageError = 0;
        for i = 1:size(dCloud)
            difference = readings{n,1}(i,:) - (RD*dCloud(i, :).' + pD).';
            difference = sqrt(difference*difference');     
            averageError = averageError + difference;
           
            if difference > 1
                disp('Error: B frame transformation is incorrect');
            end
        end
        
        averageError = averageError/length(dCloud);
        Daverage = Daverage+averageError;
      
    end
    
    disp(['Average error for C Cloud across all frames is: ', num2str(Caverage/size(readings,1))]);
    disp(['Average error for A Cloud across all frames is: ', num2str(Aaverage/size(readings,1))]);
    disp(['Average error for D Cloud across all frames is: ', num2str(Daverage/size(readings,1))]);
       
    DebugOrUnknown = strsplit(name, '-');
    if (strcmp(DebugOrUnknown(2), 'debug'))
        OutputTest(name, 10);
    end
    
end