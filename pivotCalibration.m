% Pivot calibration using the pseudo-inverse method

function [Pcal, Ppiv] = pivotCalibration(RList, pList)
    Rall = zeros(0,6);
    tall = zeros(0,0);
    for i = 1:size(RList)
        Rall = vertcat(Rall, horzcat(squeeze(RList(i,:,:)), -1.*eye(3)));
        tall =vertcat(tall, -1.*pList(:, i));
    end
    
    x = tall\Rall;
    
    Pcal = x(1:3);
    Ppiv = x(4:6);

end