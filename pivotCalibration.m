% Pivot calibration using the pseudo-inverse method

function [Pcal, Ppiv] = pivotCalibration(RList, pList)
    
    Rall = [];
    tall = [];
    for i = 1:size(RList)
        vertcat(Rall, horzcat(RList(i), -1.*eye(3)));
        vertcat(tall, -1.*pList(i));
    end
    
    x = tall\Rall;
    
    Pcal = x(1:3);
    Ppiv = x(4:6);

end