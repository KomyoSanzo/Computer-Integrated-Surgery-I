function Main(name)
    
    [calbody, readings, empivot, optpivot] = Parse(name);
    dCloud = calbody{1};
    aCloud = calbody{2};
    cCloud = calbody{3};
    
    frames = size(readings, 1);
    
    Cest = cell(1, frames);
    for n = 1:frames
        Cest{n} = zeros(size(readings{n,3}));
        [RD, pD] = CloudToCloud(dCloud, readings{n,1});
        [RA, pA] = CloudToCloud(aCloud, readings{n,2});
        for i = 1:size(cCloud)
            Cest{n}(i,:) = RD\(RA*cCloud(i, :).' + pA) - RD\pD;
        end
    end
    
    optframes = size(optpivot, 1);
    
    transpivot = cell(1, optframes);
    for n = 1:optframes
        transpivot{n} = zeros(size(optpivot{n,2}));
        [RD, pD] = CloudToCloud(optpivot{n,1}, dCloud);
            for i = 1:size(optpivot{n,2})
                transpivot{n}(i,:) = RD*optpivot{n,2}(i, :).' + pD;
            end
    end
    
    empPosition = PostPosition(empivot);
    optPosition = PostPosition(transpivot);
    
    filename = strcat('../OUTPUT/', name, '-output-1.txt');
    fopen(filename, 'wt');
    fileID = fopen(filename, 'a');
    spec = '  %3.2f,   %3.2f,   %3.2f\n';
    numC = num2str(size(Cest{1}, 1), '%d');
    numF = num2str(size(Cest, 2), '%d');
    header = [numC, ', ', numF, ', ', filename, '\n'];
    fprintf(fileID, header);
    fprintf(fileID, spec, empPosition.');
    fprintf(fileID, spec, optPosition.');
    for i = 1:size(Cest, 2)
        for n = 1:size(Cest{i},1)
            fprintf(fileID, spec, Cest{i}(n,:));
        end
    end
    fclose(fileID);
end