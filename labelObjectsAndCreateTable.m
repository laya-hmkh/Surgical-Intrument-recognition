function [labeledImg, propertiesTable] = labelObjectsAndCreateTable(imageFile)
    % Load the image
    img = imread(imageFile);

    % Convert to grayscale if the image is in color
    if size(img, 3) == 3
        img = rgb2gray(img);
    end

    % Apply thresholding to create a binary image
    threshold = graythresh(img);
    binaryImage = imbinarize(img, threshold);

    % Remove small objects
    binaryImage = bwareaopen(binaryImage, 50);

    % Label connected components
    labeledImg = bwlabel(binaryImage);

    % Use regionprops to measure properties of each object
    props = regionprops(labeledImg, 'Area', 'Perimeter', 'Centroid', 'BoundingBox');

    % Extract properties
    areas = [props.Area];
    perimeters = [props.Perimeter];
    centroids = vertcat(props.Centroid); % Combine centroids into a matrix
    boundingBoxes = vertcat(props.BoundingBox); % Combine bounding boxes into a matrix

    % Remove the first object
    areas(1) = [];
    perimeters(1) = [];
    centroids(1, :) = [];
    boundingBoxes(1, :) = [];
    props(1) = []; % Remove the first element from the props array

    % Display the original image with bounding boxes
    imshow(img);
    hold on;

    % Loop through each object and draw bounding boxes
    for k = 1:length(props)
        % Draw the bounding box
        rectangle('Position', boundingBoxes(k, :), 'EdgeColor', 'r', 'LineWidth', 2);

        % Label the object with its index
        text(centroids(k, 1), centroids(k, 2), num2str(k), 'Color', 'yellow', 'FontSize', 12, 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
    end

    hold off;

    % Create a table with the properties
    propertiesTable = table(boundingBoxes, areas', perimeters', centroids(:,1), centroids(:,2), ...
                            'VariableNames', {'BoundingBox', 'Area', 'Perimeter', 'CentroidX', 'CentroidY'});
end
