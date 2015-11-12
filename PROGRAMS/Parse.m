function [BodyA, TipA, BodyB, TipB, TriangleList, Readings] = Parse(name)
%PARSE Takes in the front of text file's name and reads in the necessary
%information to be returned.
%INPUT: Filename prefix
%OUTPUT: All data from relevant files in formated matrices and cells

    %The file header has the relevant suffix added and run through helper
    %functions which formats the information to be returned
    [BodyA, TipA, NumA] = parseBody('../INPUT/Problem3-BodyA.txt');
    [BodyB, TipB, NumB] = parseBody('../INPUT/Problem3-BodyB.txt');
    TriangleList = parseMesh('../INPUT/Problem3Mesh.sur');
    Readings = parseReadings(strcat('../INPUT/PA3-', name, '-SampleReadingsTest.txt'), NumA, NumB);
    
    function [BodyPoints, TipPoint, Num] = parseBody(filename)
        M = csvread(filename, 1, 0);
        BodyPoints = M(1:(size(M, 1)-1), :);
        TipPoint = M(size(M, 1), :);
        Num = size(M, 1) - 1;
    end

    function TriangleList = parseMesh(filename)
        M = csvread(filename);
        VertNum = M(1);
        VerticesPoints = M(2:VertNum + 1, 1:3);
        TriangleNum = M(VertNum + 2);
        TrianglePoints = M(VertNum + 3: VertNum + 2 + TriangleNum, 1:3);
        NeighborPoints = M(VertNum + 3: VertNum + 2 + TriangleNum, 4:6);
        TriangleList = cell(TriangleNum, 1);
        for n = 1:TriangleNum
            row1 = (VerticesPoints(TrianglePoints(n, 1) + 1, :));
            row2 = (VerticesPoints(TrianglePoints(n, 2) + 1, :));
            row3 = (VerticesPoints(TrianglePoints(n, 3) + 1, :));
            points = vertcat(row1, row2, row3);
            TriangleList{n} = points;
        end
    end

    function Readings = parseReadings(filename, NumA, NumB)
        M = csvread(filename, 1, 0);
        info = fileread(filename);
        info = strsplit(info(1,:), ',');
        SampNum = str2double(info(2));
        NumS = str2double(info(1));
        Readings = cell(SampNum,2);
        i = 1;
        for n = 1:SampNum
            A = M(i: i + NumA - 1, :);
            i = i + NumA;
            B = M(i: i + NumB - 1, :);
            i = i + NumB;
            i = i + (NumS - NumB - NumA);
            Readings{n, 1} = A;
            Readings{n, 2} = B;
        end
    end

end