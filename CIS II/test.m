%Load skull and defect point clouds
ptCloudDefect = pcread('orig9.ply');
ptCloudSkull = pcread('origFull2.ply');

%Fit sphere to defect
figure(1);
hold on;
pcshow(ptCloudDefect);
maxDistance = 0.1;
[defectSphere,defectInlierIndices] = pcfitsphere(ptCloudDefect,maxDistance);
defectInliers = select(ptCloudDefect,defectInlierIndices);

%Fit sphere to skull
pcshow(ptCloudSkull);
hold off;
maxDistance = 0.1;
[skullSphere, skullInlierIndices] = pcfitsphere(ptCloudSkull,maxDistance);

%Shift models to be concentric at origin.
centerDefect = defectSphere.Center;
centerSkull = skullSphere.Center;

ADefect = [1 0 0 0; ...
     0 1 0 0; ...
     0 0 1 0; ...
     -centerDefect(1) -centerDefect(2) -centerDefect(3) 1];
tform = affine3d(ADefect);
ptCloudDefectCentered = pctransform(ptCloudDefect,tform);

ASkull = [1 0 0 0; ...
     0 1 0 0; ...
     0 0 1 0; ...
     -centerSkull(1) -centerSkull(2) -centerSkull(3) 1];
tform = affine3d(ASkull);
ptCloudSkullCentered = pctransform(ptCloudSkull,tform);

%Show centered meshes
figure(2);
pcshow(ptCloudDefectCentered);
hold on;
pcshow(ptCloudSkullCentered);
hold off;

%Segment skull to get outer part (that should match with skull topology)
% maxDistance = 5;
% [outerDefectSphere, defectInlierIndicesOuter] = pcfitsphere(ptCloudDefectCentered,maxDistance);
% ptCloudDefectOuter = select(ptCloudDefectCentered,defectInlierIndicesOuter);
% figure(3);
% pcshow(ptCloudDefectOuter);

%ICP from segmented defect to skull
ptCloudDefectDown = pcdownsample(ptCloudDefectCentered,'random',0.75);
ptCloudSkullDown = pcdownsample(ptCloudSkullCentered,'random',0.75);
tform = pcregrigid(ptCloudDefectDown, ptCloudSkullDown);
ptCloudDefectReg = pctransform(ptCloudDefectCentered,tform);

%Show final point clouds
figure(4);
pcshow(ptCloudDefectReg);
hold on;
pcshow(ptCloudSkullCentered);
hold off;