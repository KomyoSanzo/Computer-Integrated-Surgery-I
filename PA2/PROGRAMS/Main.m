function Main(name)
    
    [calbody, readings, empivot, optpivot, ctfid, emfid, emnav] = Parse(name);
    dCloud = calbody{1};
    aCloud = calbody{2};
    cCloud = calbody{3};
    
    frames = size(readings, 1);
    
    % Get the optical estimate of C
    Cest = cell(1, frames);
    for n = 1:frames
        Cest{n} = zeros(size(readings{n,3}));
        [RD, pD] = CloudToCloud(dCloud, readings{n,1});
        [RA, pA] = CloudToCloud(aCloud, readings{n,2});
        for i = 1:size(cCloud)
            Cest{n}(i,:) = RD\(RA*cCloud(i, :).' + pA) - RD\pD;
        end
    end
    
    % Get Bernstein coefficients
    Cem = (readings(:, 3)).';
    [Uem, mini, maxi] = (ScaleToBox2(Cem)); 
    U_EMpivot = (ScaleToBox(empivot, mini, maxi));
    Co = CalculateCoefficients(Uem, Cest);

    % Correct distortion and re-parse
    corrected_EM = CorrectDistortion(U_EMpivot.', Co);
    fN = length(empivot);
    gN = length(empivot{1});
    cell_corrected_EM = cell(fN,1);
    for n = 1:fN
        N = 1 + (n - 1)*(gN);
        cell_corrected_EM{n, 1} =  corrected_EM(N:(N+gN-1), :,:);
    end
    
    % Get the post calibration
    [empPost, test, gk] = PostPosition(cell_corrected_EM);
    average = VectorAverage(cell_corrected_EM{1});
    
    % Undistort and reparse EM fiducial points
    U_emfid = (ScaleToBox(emfid, mini, maxi));
    corrected_emfid = CorrectDistortion(U_emfid.', Co);
    fN = length(emfid);
    gN = length(emfid{1});
    cell_corrected_EMFid = cell(fN);
    for n = 1:fN
        N = 1 + (n - 1)*(gN);
        cell_corrected_EMFid{n} =  corrected_emfid(N:(N+gN-1), :,:);
    end
    
    % Get fiducial locations
    fid_locations = GetLocations(cell_corrected_EMFid, test, average, gk);
    
    % Calculate registration frame from fidlocations and ct fidlocations
    [R_reg, p_reg] = CloudToCloud(ctfid, fid_locations);
    
    % Correct new values using Bernstein coefficients and re-parse
    U_nav = ScaleToBox(emnav, mini, maxi);
    corrected_nav = CorrectDistortion(U_nav.', Co);
    fN = length(emnav);
    gN = length(emnav{1});
    cell_corrected_EMNav = cell(fN);
    for n = 1:fN
        N = 1 + (n - 1)*(gN);
        cell_corrected_EMNav{n} =  corrected_nav(N:(N+gN-1), :,:);
    end
    
    % Get the locations and transform them to CT coorrdinates
    nav_locations = GetLocationsReg(cell_corrected_EMNav, test, average, gk, R_reg, p_reg);
    disp(nav_locations);
    
    % Write to file
    filename = strcat('../OUTPUT/', name, '-output-2.txt');
    fopen(filename, 'wt');
    fileID = fopen(filename, 'a');
    spec = '  %3.2f,   %3.2f,   %3.2f\n';
    num = num2str(size(nav_locations, 1), '%d');
    header = [num, ', ', strcat(name, '-output-2.txt'), '\n'];
    fprintf(fileID, header);
    for i = 1:size(nav_locations, 1)
        fprintf(fileID, spec, nav_locations(i, :));
    end
    fclose(fileID);
end