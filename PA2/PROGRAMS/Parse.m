function [calbody, readings, empivot, optpivot, ctfid, emfid, emnav] = Parse(name)
%PARSE Takes in the front of text file's name and reads in the necessary
%information to be returned.

    %The file header has the relevant suffix added and run through helper
    %functions which formats the information to be returned
    calbody = parseCalbody(strcat('../DATA/', name, '-calbody.txt'));
    readings = parseReadings(strcat('../DATA/', name, '-calreadings.txt'));
    empivot = parseEmpivot(strcat('../DATA/', name, '-empivot.txt'));
    optpivot = parseOptpivot(strcat('../DATA/', name, '-optpivot.txt'));
    ctfid = parseCTFiducials(strcat('../DATA/', name, '-ct-fiducials.txt'));
    emfid = parseEMFiducials(strcat('../DATA/', name, '-em-fiducialss.txt'));
    emnav = parseEMNav(strcat('../DATA/', name, '-EM-nav.txt'));
    
    function R = parseCalbody(filename)
        M = csvread(filename, 1, 0);
        info = fileread(filename);
        info = strsplit(info(1,:), ',');
        dN = str2double(info(1));
        aN = str2double(info(2));
        cN = str2double(info(3));
        R = cell(1, 3);
        R{1} = M(1:dN, :,:);
        R{2} = M(dN+1:(aN+dN), :,:);
        R{3} = M((aN+dN+1):(aN+dN+cN), :,:);
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

    function R = parseCTFiducials(filename)
        M = csvread(filename, 1, 0);
        info = fileread(filename);
        info = strsplit(info(1,:), ',');
        bN = str2double(info(1));
        R = M;
    end

    function R = parseEMFiducials(filename)
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

    function R = parseEMNav(filename)
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


end