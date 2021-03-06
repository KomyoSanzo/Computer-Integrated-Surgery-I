function Main(name)
    %Matching part of ICP protocol
    %INPUT: Filename prefix of data to match
    %OUTPUT: Writes file with points on bone with respect to pointer B, the
    %points on the given mesh closest to each of these points, and the
    %distance between the two.
    
    %Parse data from files
    [BodyA, TipA, BodyB, ~, TriangleList, Readings] = Parse(name);
    
    %Find transformation at each frame between the pointers A and
    %and B using CloudToCloud and then use this information to find the
    %point at Atip at each frame in rigid body B coordinates.
    d = zeros(size(Readings,1), 3);
    for i = 1:size(Readings,1)
        [RlistA, plistA] = CloudToCloud(BodyA, Readings{i, 1});
        [RlistB, plistB] = CloudToCloud(BodyB, Readings{i, 2});
        d(i, :) = inv(RlistB)*RlistA*TipA.' + inv(RlistB)*plistA - inv(RlistB)*plistB;
    end

    c = zeros(size(d));
    diff = zeros(size(d, 1), 1);
    
    %Use linearSearch to find the closest point on the given surface mesh
    %to each of the points on the bone in rigid body B coordinates. Find
    %the distances between them.
    for i = 1:size(d, 1)
        c(i, :) = linearSearch(TriangleList, d(i, :));
        xdist = (c(i,1)- d(i,1))^2;
        ydist = (c(i,2) - d(i,2))^2;
        zdist = (c(i,3) - d(i,3))^2;
        diff(i) = sqrt(xdist + ydist + zdist);
    end

    % Write to file
    output = horzcat(d, c, diff);
    num = size(output, 1);
    filename = strcat('../OUTPUT/pa3-', name, '-Output.txt');
    fopen(filename, 'wt');
    fileID = fopen(filename, 'a');
    header = [num2str(num), ' ', strcat('pa3-', name, '-Output.txt')];
    fprintf(fileID, header);
    dlmwrite(filename, output, '-append', 'delimiter', '\t', 'roffset', 1, 'precision', '%5.2f');
    fclose(fileID);
    
end