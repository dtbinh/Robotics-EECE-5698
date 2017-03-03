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
grayImage = rgb2gray(I);
[y,x,m] = harris(grayImage, 1000, 'tile', [2 2], 'disp');
[features, points] = extractFeatures(grayImage,[x y]);

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
    grayImage = rgb2gray(I);
    [y,x,m] = harris(grayImage, 1000, 'tile', [2 2], 'disp');
    [features, points] = extractFeatures(grayImage,[x y]);
    
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
full_tforms = tforms;

%% Output Limits

imageSize = size(I);  % all the images are the same size

% Compute the output limits  for each transform
for i = 1:numel(tforms)
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(2)], [1 imageSize(1)]);
end

%% Set X Limit

avgXLim = mean(xlim, 2);

[~, idx] = sort(avgXLim);

centerIdx = floor((numel(tforms)+1)/2);

centerImageIdx = idx(centerIdx);

%% Apply Center Image Inverse

Tinv = invert(tforms(centerImageIdx));

for i = 1:numel(tforms)
    tforms(i).T = Tinv.T * tforms(i).T;
end

centerImageIdx = idx(centerIdx);

%% Initalize Panorama

for i = 1:numel(tforms)
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(2)], [1 imageSize(1)]);
end

% Find the minimum and maximum output limits
xMin = min([1; xlim(:)]);
xMax = max([imageSize(2); xlim(:)]);

yMin = min([1; ylim(:)]);
yMax = max([imageSize(1); ylim(:)]);

% Width and height of panorama.
width  = round(xMax - xMin);
height = round(yMax - yMin);

% Initialize the "empty" panorama.
panorama = zeros([height width 3], 'like', I);

%% Create the panorama

blender = vision.AlphaBlender('Operation', 'Binary mask', ...
    'MaskSource', 'Input port');

% Create a 2-D spatial reference object defining the size of the panorama.
xLimits = [xMin xMax];
yLimits = [yMin yMax];
panoramaView = imref2d([height width], xLimits, yLimits);

radius = 100;
% Create the panorama.
for i = 1:numImages
    
    disp(['Creating panorama ' num2str(i) ' of '...
        num2str(numImages)]);

    I = readimage(buildingScene, i);

    % Transform I into the panorama.
    warpedImage = imwarp(I, tforms(i), 'OutputView', panoramaView);

    if i==centerIdx % Loop must be stopped on center image.
        BW = imbinarize(warpedImage(:,:,1),0);
        BW = imfill(BW,'holes');
        s = regionprops(BW,'centroid');
        centroids = cat(1, s.Centroid);
        
        offsetx = centroids(1,1);
        offsety = centroids(1,2); 
    end
    
    % Generate a binary mask.
    mask = imwarp(true(size(I,1),size(I,2)), tforms(i), 'OutputView', panoramaView);

    % Overlay the warpedImage onto the panorama.
    panorama = step(blender, panorama, warpedImage, mask);
end

figure
imshow(panorama)


%% Camera locations
cam_loc = panorama;
disp(['offset X = ' num2str(offsetx)]);
disp(['offset Y = ' num2str(offsety)]);

for i=1:numImages
    disp(['Camera Location in panorama ' num2str(i) ' of '...
        num2str(numImages)]);
    
    cam_loc = insertShape(cam_loc,'FilledCircle',...
        [tforms(i).T(3,1)+offsetx tforms(i).T(3,2)+offsety...
        radius],'Color', 'red','Opacity',0.9);
    
end
h = figure; imshow(cam_loc);
savefig(h,'cam_loc_wall.fig');
saveas(h,'cam_loc_wall.png');
