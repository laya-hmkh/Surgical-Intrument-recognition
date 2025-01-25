# Surgical Instrument Recognition using Image Processing and Comparison

This MATLAB script implements a rule-based approach for surgical instrument recognition, utilizing image processing techniques to detect, label, and compare objects in images. The script also determines which instruments are missing, based on a comparison with a ground truth image.

## Overview

The script performs the following major tasks:

1.  **Object Detection and Labeling:** Detects and labels connected components (representing instruments) within an image, generates a table of object properties (area, perimeter, centroid, bounding box).
2.  **Ground Truth and Test Image Processing:** Applies the object detection and labeling to both ground truth and test images.
3.  **Object Comparison:** Compares objects between the ground truth and test images based on area and perimeter, using a predefined tolerance.
4.  **Missing Instrument Detection:** Determines if any instruments from the ground truth are missing from the test image.

## How It Works

The algorithm works as follows:

1.  **`labelObjectsAndCreateTable` Function:**
    *   **Image Loading and Preprocessing:**
        *   Loads an input image from a file path.
        *   If the image is color, converts it to grayscale.
        *   Applies automatic thresholding using `graythresh` and `imbinarize`.
        *   Removes small objects from the binary image using `bwareaopen`.
    *   **Object Labeling:**
        *   Labels connected components in the binary image using `bwlabel`.
    *   **Property Measurement:**
        *   Uses `regionprops` to measure properties such as area, perimeter, centroid, and bounding box for each labeled object.
    *   **Data Extraction and Organization:**
         *  Extracts area, perimeters, centroids, and bounding boxes of each detected object.
         *  Removes the first object that might be background noise and might not be an instrument.
        *   Displays the original image with bounding boxes and object labels.
    *   **Table Creation:**
        *   Creates a table containing the extracted properties for each object.

2.  **Main Script:**
    *   **Ground Truth Processing:** Calls `labelObjectsAndCreateTable` with the ground truth image (`ground_truth.png`), which is assumed to contain all instruments of interest.
    *   **Test Image Processing:** Calls `labelObjectsAndCreateTable` with a test image (e.g., `images/6.png`).
    *   **Object Comparison:**
        *   Compares each object in the ground truth image with each object in the test image using their area and perimeter values.
        *   Objects with area and perimeter within a defined tolerance of each other are considered 'similar'.
    *   **Missing Instrument Detection:**
        *   Identifies which objects in the ground truth image do not have a similar match in the test image based on the previous comparison, and considers them to be 'missing'.
        *   Displays the names of the missing instruments if there are any.

## Files

*   `main.m`: (Replace `main.m` with the actual name of your MATLAB script file) This is the main MATLAB script file that implements the surgical instrument recognition algorithm.
*   `ground_truth.png`: An image containing all of the instruments, used as a reference.
*   `images/6.png`: An example test image with surgical instruments to be analyzed.
*  `function [labeledImg, propertiesTable] = labelObjectsAndCreateTable(imageFile)` : the helper function.

## Usage

1.  Ensure you have MATLAB installed on your system.
2.  Place the MATLAB script file, the ground truth image (`ground_truth.png`), and the test image(s) in the correct locations, as specified in the code.
3.  Run the MATLAB script from the MATLAB command window or by pressing the "Run" button in the editor.

## Dependencies

*   MATLAB Image Processing Toolbox (for functions like `imread`, `rgb2gray`, `graythresh`, `imbinarize`, `bwareaopen`, `bwlabel`, `regionprops`, `imshow`, `rectangle`, `text`)

## Parameters

*   `tolerance_area`: Tolerance value for differences in object areas, used when comparing the ground truth and test images (default is 200).
*   `tolerance_per`: Tolerance value for differences in object perimeters, used when comparing the ground truth and test images (default is 50).
## Future Improvements

*   Implement more sophisticated features for object comparison (e.g., shape descriptors).
*   Explore Machine Learning approaches to improve recognition accuracy.
*   Use a more sophisticated segmentation method.
*   Handle scenarios with partial occlusion and varying object sizes.
