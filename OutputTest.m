function [ output_args ] = OutputTest(filename, thresh)
%OUTPUTTEST Function that tests the actual and expected output from a
%particular file. Used for error testing to check the differences between
%our values and the ones provided. 

Expected = csvread(strcat(filename, '-output1.txt'), 1, 0);
Expected_info = fileread(strcat(filename, '-output1.txt'));
Expected_info = strsplit(Expected_info(1,:), ',');

Actual = csvread(strcat(filename, '-output-1.txt'), 1, 0);
Actual_info = fileread(strcat(filename, '-output1.txt'));
Actual_info = strsplit(Actual_info(1,:), ',');

if str2double(Actual_info(1)) ~= str2double(Expected_info(1))
    disp('The number of EM markers is incorrect');
end

if str2double(Actual_info(2)) ~= str2double(Expected_info(2))
    disp('The number of frames is incorrect!');
end

max = 0;
for i = 1:length(Actual)
    
    difference = Actual(i,:,:) - Expected(i,:,:);
    difference = sqrt(difference*difference');
    if (difference > max)
        max = difference;
    end
    
    if (difference > thresh)
        disp(['You have a large distance at index: ', num2str(i)]);
        disp(['with an error of ', num2str(difference)]);
        disp(sprintf('\n'));
    end
   
end
disp(['Your max distance between expected and actual values is: ', num2str(max)])
    

end

