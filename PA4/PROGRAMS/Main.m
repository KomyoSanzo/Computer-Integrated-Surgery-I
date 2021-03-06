function Main(name)
    %Iterative matching ICP protocol
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
    
    %Use KD tree to find the closest point on the given surface mesh
    %to each of the points on the bone in rigid body B coordinates. Find
    %the transformation that minimizes this distance. Iterate until
    %threshold is reached. Ignore points that are outliers (closest point
    %is more than a certain threshold away). Keep track of residual sum.
    
    res_sum = zeros(0);
    res_idx = 1;
    
    %Finds initial total difference between points for determining
    %convergence. Initiates KD tree.
    centroids = zeros(length(TriangleList), 4);
    for i = 1:length(TriangleList)
        centroids(i, 1:3) = mean(TriangleList{i});
        centroids (i, 4) = i;
    end
    root = generateKDTree(1, TriangleList, centroids);
    idx = 1;
    c_valid = zeros(0, 3);
    d_valid = zeros(0, 3);
    diff_tot = 0;
    for i = 1:size(d, 1)
        [~, c(i, :)] = KDTreeSearch(root, 1, d(i, :), inf, [0 0 0]);
        xdist = (c(i,1)- d(i,1))^2;
        ydist = (c(i,2) - d(i,2))^2;
        zdist = (c(i,3) - d(i,3))^2;
        diff(i) = sqrt(xdist + ydist + zdist);
        diff_tot = diff_tot + diff(i);
        d_valid(idx, :) = d(i, :);
        c_valid(idx, :) = c(i, :);
        idx = idx + 1;
    end
    res_sum(res_idx) = diff_tot;
    res_idx = res_idx + 1;
    [Rreg, preg] = CloudToCloud(d_valid, c_valid);
    for i = 1:size(d, 1)
        d(i, :) = Rreg*d(i, :).' + preg;
    end
    res_sum(res_idx) = diff_tot;
    res_idx = res_idx + 1;

    %Iteration loop
    diff_avg = mean(diff);
    diff_std = std(diff);
    diff_old = realmax;
    while (diff_old - diff_tot) > 0.00001;
        idx = 1;
        c_valid = zeros(0, 3);
        d_valid = zeros(0, 3);
        diff_old = diff_tot;
        diff_tot = 0;
        for i = 1:size(d, 1)
            [~, c(i, :)] = KDTreeSearch(root, 1, d(i, :), inf, [0 0 0]);
            xdist = (c(i,1)- d(i,1))^2;
            ydist = (c(i,2) - d(i,2))^2;
            zdist = (c(i,3) - d(i,3))^2;
            diff(i) = sqrt(xdist + ydist + zdist);
            diff_tot = diff_tot + diff(i);
            if diff(i) < (diff_avg + diff_std)
                d_valid(idx, :) = d(i, :);
                c_valid(idx, :) = c(i, :);
                idx = idx + 1;
            end
        end
        diff_avg = mean(diff);
        diff_std = std(diff);
        res_sum(res_idx) = diff_tot;
        res_idx = res_idx + 1;
        [Rreg, preg] = CloudToCloud(d_valid, c_valid);
        for i = 1:size(d, 1)
            d(i, :) = Rreg*d(i, :).' + preg;
        end
    end
    
    diff_tot = 0;
    %Final distances (accomodates edge cases of KD trees)
    for i = 1:size(d, 1)
        if diff(i) < (diff_avg)
            [~, c(i, :)] = KDTreeSearch(root, 1, d(i, :), inf, [0 0 0]);
        else
            c(i, :) = linearSearch(TriangleList, d(i, :));
        end
        xdist = (c(i,1)- d(i,1))^2;
        ydist = (c(i,2) - d(i,2))^2;
        zdist = (c(i,3) - d(i,3))^2;
        diff(i) = sqrt(xdist + ydist + zdist);
        diff_tot = diff_tot + diff(i);
    end
    res_sum(res_idx) = diff_tot;
    plot(res_sum);
    
    % Write to file
    output = horzcat(d, c, diff);
    num = size(output, 1);
    filename = strcat('../OUTPUT/pa4-', name, '-Output.txt');
    fopen(filename, 'wt');
    fileID = fopen(filename, 'a');
    header = [num2str(num), ' ', strcat('pa4-', name, '-Output.txt')];
    fprintf(fileID, header);
    dlmwrite(filename, output, '-append', 'delimiter', '\t', 'roffset', 1, 'precision', '%5.2f');
    fclose(fileID);
    
end
    