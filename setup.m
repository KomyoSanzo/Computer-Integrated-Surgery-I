function [R p] = setup(name)

    C = parseReadings('pa1-debug-a-calreadings.txt');
    [a b c] = parseCalbody('pa1-debug-a-calbody.txt');
    disp(size(c));
    disp(size(C{1,3}));
    [R p] = C2C(C{1,3}, c);

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
        disp(R);
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
        disp(R);
        for n = 1:fN
            N = 1 + (n - 1)*(gN);
            R{n} =  M(N:(N+gN-1), :,:);
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
        disp(R);
        for n = 1:fN
            N = 1 + (n - 1)*(dN+hN);
            R{n, 1} =  M(N:(N+dN-1), :,:);
            R{n, 2} =  M((N+dN):(hN+N+dN-1), :,:);
        end
    end


end