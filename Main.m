function Main(name)
    
    [calbody, readings, empivot, optpivot] = Parse(name);
    dCloud = calbody{1};
    aCloud = calbody{2};
    cCloud = calbody{3};
    
    [RD, pD] = CloudToCloud(dCloud, readings{1,1});
    [RA, pA] = CloudToCloud(aCloud, readings{1,2});
%    [RC, pC] = CloudToCloud(cCloud, readings{1,3});
    
    Cest = zeros(size(readings{1,3}));
    for i = 1:size(cCloud)
        Cest(i,:) = inv(RD)*(RA*cCloud(i, :).' + pA) - inv(RD)*pD;
    end
    
    disp(PostPosition(empivot));
    
    
%     Good testing code
%     disp(readings{1,3});
%     for i = 1:size(readings{1,3})
%         disp((RC*cCloud(i,:).' + pC).');
%     end