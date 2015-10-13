function Main(name)
    
    [calbody, readings, empivot, optpivot] = Parse(name);
    dCloud = calbody{1};
    aCloud = calbody{2};
    cCloud = calbody{3};
    
    [RD, pD] = CloudToCloud(dCloud, readings{1,1});
    [RA, pA] = CloudToCloud(aCloud, readings{1,2});
    [RC, pC] = CloudToCloud(cCloud, readings{1,3});
    
    Cest = zeros(size(readings{1,3}));
    for i = 1:size(cCloud)
        Cest(i,:) = inv(RD)*(RA*cCloud(i, :).' + pA) - inv(RD)*pD;
    end
    
    
    gCloud = cell(length(empivot), 1);
    gAverage = VectorAverage(empivot{1});
    
    for i = 1:length(empivot)
        gCloud{i} = empivot{i};
        for j = 1:length(empivot{i})
            gCloud{i}(j,:) = gCloud{i}(j,:) - gAverage;
        end
    end
    
    Rlist = cell(1, size(gCloud,2));
    plist = cell(1, size(gCloud,2));
    
    for i = 1:size(gCloud, 1)
        [Rlist{i}, plist{i}] = CloudToCloud(empivot{i}, gCloud{i});
    end
    
    [Ptip, Ppiv] = PivotCalibration(Rlist, plist);
    
%     Good testing code
%     disp(readings{1,3});
%     for i = 1:size(readings{1,3})
%         disp((RC*cCloud(i,:).' + pC).');
%     end