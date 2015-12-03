function OutputTest(name)
%OUTPUTTEST Function that tests the actual and expected output from a
%particular file. Used for error testing to check the differences between
%our values and the ones provided. 

Expected = csvread(strcat('../DATA/pa4-', name, '-Output.txt'), 1, 0);
Expected_info = fileread(strcat('../DATA/pa4-', name, '-Output.txt'));
Expected_info = strsplit(Expected_info(1,:), ',');

Actual = csvread(strcat('../OUTPUT/pa4-', name, '-Output.txt'), 1, 0);
Actual_info = fileread(strcat('../OUTPUT/pa4-', name, '-Output.txt'));
Actual_info = strsplit(Actual_info(1,:), ',');

Dmax = 0;
Cmax = 0;
Xmax = 0;
for i = 1:length(Actual)
    
    Ddifference = Actual(i,1:3) - Expected(i,1:3);
    Ddifference = sqrt(Ddifference*Ddifference');
    
    Cdifference = Actual(i,4:6) - Expected(i,4:6);
    Cdifference = sqrt(Cdifference*Cdifference');
    
    Xdifference = Actual(i,7) - Expected(i,7);
    Xdifference = sqrt(Xdifference*Xdifference');
    
    if (Ddifference > Dmax)
        Dmax = Ddifference;
    end
    if (Cdifference > Cmax)
        Cmax = Cdifference;
    end
    if (Xdifference > Xmax)
        Xmax = Xdifference;
    end
end
disp(['Your max distance between tracker points expected and actual values is: ', num2str(Dmax)]);
disp(['Your max distance between closest points expected and actual values is: ', num2str(Cmax)]);
disp(['Your max distance between difference expected and actual values is: ', num2str(Xmax)]);
disp(['The max difference betweeen closest points you found is: ', num2str(max(Actual(:, 7)))]);
disp(['The max difference betweeen closest points in the sample output is: ', num2str(max(Expected(:, 7)))]);
end
