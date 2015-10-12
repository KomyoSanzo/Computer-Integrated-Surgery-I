function setup(name)

    parseCalbody('pa1-debug-a-calbody.txt');

    function [d, a, c] = parseCalbody(filename)
        M = csvread(filename, 1, 0);
        info = fileread(filename);
        info = strsplit(info(1,:), ',');
        dN = str2double(info(1));
        aN = str2double(info(2));
        cN = str2double(info(3));
        d = M(1:dN, :,:);
        a = M(dN:(aN+dN), :,:);
        c = M((aN+dN):(aN+dN+cN), :,:);
    end

end