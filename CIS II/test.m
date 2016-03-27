%Load skull and defect point clouds
ptCloudDefect = pcread('orig.ply');
ptCloudSkull = pcread('origFull.ply');

%Fit sphere to defect
pcshow(ptCloudDefect);
maxDistance = 0.1;
[defectSphere,defectInlierIndices] = pcfitsphere(ptCloudDefect,maxDistance);
defectInliers = select(ptCloudDefect,defectInlierIndices);

%Fit sphere to skull
pcshow(ptCloudSkull);
maxDistance = 0.1;
[skullSphere, skullInlierIndices] = pcfitsphere(ptCloudSkull,maxDistance);

%Shift models to be concentric
centerDefect = defectSphere.Center;
centerSkull = skullSphere.Center;
translation = centerSkull - centerDefect;

A = [1 0 0 0; ...
     0 1 0 0; ...
     0 0 1 0; ...
     translation(1) translation(2) translation(3) 1];
tform = affine3d(A);
ptCloudDefectCentered = pctransform(ptCloudDefect,tform);

%Show centered meshes
figure(1);
pcshow(ptCloudDefectCentered);
hold on;
pcshow(ptCloudSkull);
hold off;

%Segment skull to get outer part (that should match with skull topology)
maxDistance = 5;
[outerDefectSphere, defectInlierIndicesOuter] = pcfitsphere(ptCloudDefectCentered,maxDistance);
ptCloudDefectOuter = select(ptCloudDefectCentered,defectInlierIndicesOuter);
figure(6);
pcshow(ptCloudDefectOuter);

%ICP from segmented defect to skull
ptCloudDefectOuterDown = pcdownsample(ptCloudDefectOuter,'random',0.25);
ptCloudSkullDown = pcdownsample(ptCloudSkull,'random',0.25);
tform = pcregrigid(ptCloudDefectOuterDown, ptCloudSkullDown);
ptCloudDefectReg = pctransform(ptCloudDefectCentered,tform);

%Show final point clouds
figure(2);
pcshow(ptCloudDefectReg);
hold on;
pcshow(ptCloudSkull);
hold off;