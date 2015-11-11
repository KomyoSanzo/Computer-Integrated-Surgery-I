[BodyA, TipA, BodyB, TipB, TriangleList, Readings] = Parse('A-Debug');

d = zeros(size(Readings,1), 3);
for i = 1:size(Readings,1)
    averageA = VectorAverage(Readings{i, 1});
    averageB = VectorAverage(Readings{i, 2});
    [RlistA, plistA] = CloudToCloud(BodyA, Readings{i, 1});
    [RlistB, plistB] = CloudToCloud(BodyB, Readings{i, 2});
    d(i, :) = inv(RlistB)*RlistA*TipA.' + inv(RlistB)*plistA - inv(RlistB)*plistB;
end