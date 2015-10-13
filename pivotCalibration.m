% Pivot calibration using the pseudo-inverse method

function [Pcal, Ppiv] = PivotCalibration(RList, pList)
    Rall = zeros(0,6);
    tall = zeros(0,0);
    for i = 1:size(RList, 2)
        Rall = vertcat(Rall, horzcat(RList{i}, -1.*eye(3)));
        tall = vertcat(tall, -1.*pList{i});
    end
    
    x = Rall\tall;
    Pcal = x(1:3);
    Ppiv = x(4:6);
end