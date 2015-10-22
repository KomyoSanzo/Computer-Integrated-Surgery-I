function Main(name)
    
    [calbody, readings, empivot, optpivot, ctfid, emfid, emnav] = Parse(name);
    dCloud = calbody{1};
    aCloud = calbody{2};
    cCloud = calbody{3};
    
    frames = size(readings, 1);
    
    Cest = cell(1, frames);
    for n = 1:frames
        Cest{n} = zeros(size(readings{n,3}));
        [RD, pD] = CloudToCloud(dCloud, readings{n,1});
        [RA, pA] = CloudToCloud(aCloud, readings{n,2});
        for i = 1:size(cCloud)
            Cest{n}(i,:) = RD\(RA*cCloud(i, :).' + pA) - RD\pD;
        end
    end
    
    disp(size(empivot));
    disp(size(empivot{1}));
    
    Cem = (readings(:, 3)).';
    Uem = (ScaleToBox2(Cem)); 
    
    U_EMpivot = (ScaleToBox2(empivot));
    
    disp(size(U_EMpivot));
    disp(size(U_EMpivot{1}));
    
    Co = CalculateCoefficients(Uem, Cest);

    corrected_EM = CorrectDistortion(U_EMpivot.', Co);
    
    fN = length(empivot);
    gN = length(empivot{1});
    
    cell_corrected_EM = cell(fN,1);
    for n = 1:fN
        N = 1 + (n - 1)*(gN);
        cell_corrected_EM{n, 1} =  corrected_EM(N:(N+gN-1), :,:);
    end
    
    disp(cell_corrected_EM);
    disp(empivot);
    empPosition = PostPosition(cell_corrected_EM);
    disp(empPosition);
    
%     optframes = size(optpivot, 1);
%     
%     transpivot = cell(1, optframes);
%     for n = 1:optframes
%         transpivot{n} = zeros(size(optpivot{n,2}));
%         [RD, pD] = CloudToCloud(optpivot{n,1}, dCloud);
%             for i = 1:size(optpivot{n,2})
%                 transpivot{n}(i,:) = RD*optpivot{n,2}(i, :).' + pD;
%             end
%     end
%    
%     optPosition = PostPosition(transpivot);
    
%     filename = strcat('../OUTPUT/', name, '-output-1.txt');
%     fopen(filename, 'wt');
%     fileID = fopen(filename, 'a');
%     spec = '  %3.2f,   %3.2f,   %3.2f\n';
%     numC = num2str(size(Cest{1}, 1), '%d');
%     numF = num2str(size(Cest, 2), '%d');
%     header = [numC, ', ', numF, ', ', filename, '\n'];
%     fprintf(fileID, header);
%     fprintf(fileID, spec, empPosition.');
%     fprintf(fileID, spec, optPosition.');
%     for i = 1:size(Cest, 2)
%         for n = 1:size(Cest{i},1)
%             fprintf(fileID, spec, Cest{i}(n,:));
%         end
%     end
%     fclose(fileID);
end