function [Pcal, Ppiv] = PivotCalibration(RList, pList)
%PIVOTCALIBRATION Pivot calibration using the pseudo-inverse method

    %initial Rs and ts are initialized with nothing stored
    Rall = zeros(0,6);
    tall = zeros(0,0);
    
    %R and t matrices are generated 
    
    for i = 1:size(RList, 2)
        Rall = vertcat(Rall, horzcat(RList{i}, -1.*eye(3)));
        tall = vertcat(tall, -1.*pList{i});
    end
    
    %Ax=B function is solved using matlab's built in functionality
    x = Rall\tall;
    
    %values are returned
    Pcal = x(1:3);
    Ppiv = x(4:6);
end