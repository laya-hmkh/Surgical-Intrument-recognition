clear all;
clc;
close all;

% Define the labels for the surgical instruments
labels = {'Sinus Scissor', 'Sinus Probe', 'Iris Scissor', 'Forceps', 'Adson Cerbellar Retractor'};

% Call the function with the ground truth image file
[labeledImg, propertiesTable] = labelObjectsAndCreateTable('ground_truth.png');

% Display the labeled image
figure;
imshow(labeledImg);

% Display the properties table
disp(propertiesTable);

% Call the function with the test image file
[testlabeledImg, testpropertiesTable] = labelObjectsAndCreateTable('images/6.png');

% Display the labeled image
figure;
imshow(testlabeledImg);

% Display the properties table
disp(testpropertiesTable);

% Function to compare objects based on Area and Perimeter
tolerance_area = 200; % Tolerance for area
tolerance_per = 50; % Tolerance for perimeter
similarObjects = [];

% Compare objects between the two images
for i = 1:height(propertiesTable)
    for j = 1:height(testpropertiesTable)
        areaDiff = abs(propertiesTable.Area(i) - testpropertiesTable.Area(j));
        perimeterDiff = abs(propertiesTable.Perimeter(i) - testpropertiesTable.Perimeter(j));

        if areaDiff < tolerance_area && perimeterDiff < tolerance_per
            similarObjects = [similarObjects; i, j];
        end
    end
end

% Extract the unique values of i
unique_i_values = unique(similarObjects(:, 1));

% Define the range of i
range_i = 1:5;

% Find the missing values
missing_i_values = setdiff(range_i, unique_i_values);

% Display the missing values
if isempty(missing_i_values)
    disp('Complete!.');
else
    fprintf('Name of the surgical instruments that have been missed:\n');
    disp(labels(missing_i_values));
end
