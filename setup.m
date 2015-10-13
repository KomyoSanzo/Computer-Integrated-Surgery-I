function setup(name)

    EMPivot = parseEmpivot(strcat(name, '-empivot.txt'));
    calReadings  = parseReadings(strcat(name, '-calreadings.txt'));
    [dCloud, aCloud, cCloud] = parseCalbody(strcat(name, '-calbody.txt'));
    [RD, pD] = C2C(dCloud, calReadings{1,1});
    [RA, pA] = C2C(aCloud, calReadings{1,2});
    [RC, pC] = C2C(cCloud, calReadings{1,3});
    
    Cest = zeros(size(calReadings{1,3}));
    for i = 1:size(cCloud)
        Cest(i,:) = inv(RD)*(RA*cCloud(i, :).' + pA) - inv(RD)*pD;
    end
    
    gAverage = VectorAverage(EMPivot{1});
    gCloud = cell(length(EMPivot), 1);
    for i = 1:length(EMPivot)
        gCloud{i} = EMPivot{i};
        for j = 1:length(EMPivot{i})
            gCloud{i}(j,:) = gCloud{i}(j,:) - gAverage;
            disp(gAverage);
        end
    end
    
    
    Rlist = cell(1, size(gCloud,2));
    plist = cell(1, size(gCloud,2));
    
    for i = 1:size(gCloud, 2)
        [Rlist{i}, plist{i}] = C2C(EMPivot{i}, gCloud{i});
    end
    
    [Pcal, Ppiv] = pivotCalibration(Rlist, plist);
    disp(Pcal);
    disp(Ppiv);
    
    %Good testing code
    %disp(cCloud);
    %for i = 1:size(calReadings{1,3})
    %    disp((RC*calReadings{1,3}(i,:).' + pC).');
    %end
    
    function [d, a, c] = parseCalbody(filename)
        M = csvread(filename, 1, 0);
        info = fileread(filename);
        info = strsplit(info(1,:), ',');
        dN = str2double(info(1));
        aN = str2double(info(2));
        cN = str2double(info(3));
        d = M(1:dN, :,:);
        a = M(dN+1:(aN+dN), :,:);
        c = M((aN+dN+1):(aN+dN+cN), :,:);
    end

    function R = parseReadings(filename)
        M = csvread(filename, 1, 0);
        info = fileread(filename);
        info = strsplit(info(1,:), ',');
        dN = str2double(info(1));
        aN = str2double(info(2));
        cN = str2double(info(3));
        fN = str2double(info(4));
        R = cell(fN, 3);
        for n = 1:fN
            N = 1 + (n - 1)*(dN+cN+aN);
            R{n, 1} =  M(N:(N+dN-1), :,:);
            R{n, 2} =  M((N+dN):(aN+N+dN-1), :,:);
            R{n, 3} =  M((N+aN+dN):(N+aN+dN+cN-1), :,:);
        end
    end

    function R = parseEmpivot(filename)
        M = csvread(filename, 1, 0);
        info = fileread(filename);
        info = strsplit(info(1,:), ',');
        gN = str2double(info(1));
        fN = str2double(info(2));
        R = cell(fN,1);
        for n = 1:fN
            N = 1 + (n - 1)*(gN);
            R{n, 1} =  M(N:(N+gN-1), :,:);
        end
    end

    function R = parseOptpivot(filename)
        M = csvread(filename, 1, 0);
        info = fileread(filename);
        info = strsplit(info(1,:), ',');
        dN = str2double(info(1));
        hN = str2double(info(2));
        fN = str2double(info(3));
        R = cell(fN, 2);
        for n = 1:fN
            N = 1 + (n - 1)*(dN+hN);
            R{n, 1} =  M(N:(N+dN-1), :,:);
            R{n, 2} =  M((N+dN):(hN+N+dN-1), :,:);
        end
    end


end