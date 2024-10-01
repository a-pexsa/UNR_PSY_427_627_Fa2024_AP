% Define the directory containing the files
directoryPath = 'C:\Users\alipe\OneDrive - University of Nevada, Reno\Code\fLoc_stimuli';  % Change this to your directory path

% Get a list of all files in the directory
fileList = dir(fullfile(directoryPath, '*'));  % Get all files and folders
numImages = length(imageFiles);

% Remove directories from the list
fileList = fileList(~[fileList.isdir]);

% Filter out image files (common image extensions)
imageExtensions = {'.jpg'};
imageFiles = fileList;

% Randomly select 12 images
rng('shuffle');  % Seed the random number generator based on current time
selectedIndices = randperm(numImages, 12); %number of random images

% Initialize a cell array to store the images
images = cell(1, 12);

% Load the selected images
for i = 1:12
    % Get the full path of the selected image
    filePath = fullfile(directoryPath, imageFiles(selectedIndices(i)).name);
    
    % Read the image
    images{i} = imread(filePath);
    figure(1);
    imshow(images{i})
end

% Display the images in a 3x4 grid
figure;
for i = 1:12
    subplot(4, 3, i);
    imshow(images{i});
    title(sprintf('Image %d', i));
end

disp('12 random images have been displayed.');

%save cell array as .mat 
save('randomly_selected_images.mat', 'images')