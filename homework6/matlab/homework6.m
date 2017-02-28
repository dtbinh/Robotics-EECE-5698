%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Alex Agudelo
% Homework 6 
% Robotics EECE 5698
% Panoramic Mosaic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
clear figures

%% Load pictures
buildingDir = fullfile('undistortedImages');
buildingScene = imageDatastore(buildingDir, 'IncludeSubfolders', true);

% Display images to be stitched
montage(buildingScene.Files)

%% Registering Image Pairs

% Read the first image from the image set.
I = readimage(buildingScene, 1);

% Initialize features for I(1)
%grayImage = rgb2gray(I);
points = detectSURFFeatures(I)
[y,x,m] = harris(I, 1000, 'tile', [2 2], 'disp');
features = [y,x,m];

% Initialize all the transforms to the identity matrix. Note that the
% projective transform is used here because the building images are fairly
% close to the camera. Had the scene been captured from a further distance,
% an affine transform would suffice.
numImages = numel(buildingScene.Files);
tforms(numImages) = projective2d(eye(3));

% Iterate over remaining image pairs
for n = 2:numImages

    % Store points and features for I(n-1).
    pointsPrevious = points;
    featuresPrevious = features;

    % Read I(n).
    I = readimage(buildingScene, n);

    % Detect and extract SURF features for I(n).
    %grayImage = rgb2gray(I);
    points = detectSURFFeatures(I)
    [y,x,m] = harris(I, 1000, 'tile', [2 2], 'disp');
    features = [y,x,m]

    % Find correspondences between I(n) and I(n-1).
    indexPairs = matchFeatures(features, featuresPrevious, 'Unique', true);

    matchedPoints = points(indexPairs(:,1), :);
    matchedPointsPrev = pointsPrevious(indexPairs(:,2), :);

    % Estimate the transformation between I(n) and I(n-1).
    tforms(n) = estimateGeometricTransform(matchedPoints, matchedPointsPrev,...
        'projective', 'Confidence', 99.9, 'MaxNumTrials', 2000);

    % Compute T(1) * ... * T(n-1) * T(n)
    tforms(n).T = tforms(n-1).T * tforms(n).T;
end
