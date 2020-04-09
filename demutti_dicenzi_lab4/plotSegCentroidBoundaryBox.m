function plotSegCentroidBoundaryBox(segmentedImage)

% Find connected components (blobs).
labeledImage = logical(segmentedImage);

props = regionprops(labeledImage, 'Area', 'Centroid', 'BoundingBox');
hold on;

% Get all the centroids.
centroids = [props.Centroid];
allXCentroids = centroids(1:2:end);
allYCentroids = centroids(2:2:end);

% Find the largest blob
allAreas = [props.Area];
[~, indexOfLargest] = max(allAreas);

% Plot centroid and bounding box
plot(allXCentroids(indexOfLargest), allYCentroids(indexOfLargest), '*r');
rectangle('Position',(props(indexOfLargest).BoundingBox),'EdgeColor',[1,0,0],'LineWidth',2);

end
