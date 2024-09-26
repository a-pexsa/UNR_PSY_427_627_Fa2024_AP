%% Set up screen
% Variables
screenColor = [128,128,128];
% Below is only relevant for non-full-screen 
screenSize = [400,400];
screenUpperLeft = [200,200];
screenRect = [screenUpperLeft, screenUpperLeft + screenSize];
% screenRect = []; % for fullscreen
% Choose screen, in case you want to display on another screen (e.g. the 
% projector in an fMRI experiment setup)
screens=Screen('Screens');
% Choosing the display with the highest display number is
% a best guess about where you want the stimulus displayed.
screenNumber=max(screens);

% Skip sync tests for now (sync tests cause issues on Mac OS)
Screen('Preference', 'SkipSyncTests', 1);         
% Open window with default settings:
w=Screen('OpenWindow', screenNumber, screenColor, screenRect);
%% Creating lists for each block
% Faces List
directoryPath = 'C:\Users\alipe\OneDrive - University of Nevada, Reno\Code\fLoc_stimuli';  % Change this to your directory path
AdultList = dir(fullfile(directoryPath, 'adult*'));  %Get all images of adults
ChildList = dir(fullfile(directoryPath, 'child*')); %Get all images of children
FacesList = vertcat(AdultList, ChildList); %Combine files into one list of faces

% Places List
HouseList = dir(fullfile(directoryPath, 'House*'));  %Get all images of houses
CorridorList = dir(fullfile(directoryPath, 'Corridor*')); %Get all images of corridors
PlacesList = vertcat(HouseList, CorridorList); %Combine files into one list of places

% Objects List
InstrumentList = dir(fullfile(directoryPath, 'Instrument*'));  %Get all images of instruments
CarList = dir(fullfile(directoryPath, 'Car*')); %Get all images of cars
ObjectsList = vertcat(InstrumentList, CarList); %Combine files into one list of objects
%% Randomly Select Images to Display
%Establish length of each list
numFaces = length(FacesList);
numPlaces = length(PlacesList);
numObjects = length(ObjectsList);

% Randonmly select n images
n=16; %number of images to be displayed in each block
rng('shuffle'); %new seed for each time, avoids duplicate
SelectedIFaces = randperm(numFaces, n); %selecting n images from the numFaces list
SelectedIPlaces = randperm(numPlaces, n); %selecting n images from the numPlaces list
SelectedIObjects = randperm(numObjects, n); %selecting n images from the numObjects list


%% Saving images to arrays
FacesImages = cell(1, n);
PlacesImages = cell(1, n);
ObjectsImages = cell(1, n);

%% Displaying Block 1
for i = 1:n
    facefilePath = fullfile(directoryPath, FacesList(SelectedIFaces(i)).name);
    faceimage{i} = imread(facefilePath);
    faceim_small{i} = imresize(faceimage{i}, 0.125);
    facesimageTexture{i} = Screen('MakeTexture',w,faceim_small{i});
    textureRect = Screen('Rect', facesimageTexture{i});
    textureWidth = textureRect(3) - textureRect(1);
    textureHeight = textureRect(4) - textureRect(2);
    Screen('DrawTexture',w,facesimageTexture{i} ,[], [0,(400 - textureHeight)/2, textureWidth, (400 + textureHeight)/2]); 
    Screen('Flip',w);
    %^^This feels overly complicated but it is the only way I could get it
    WaitSecs(1);
    Screen('Close',[facesimageTexture{i}]);
    Screen('Flip', w);
    WaitSecs(.25);
end
%% Displaying Block 2
%% Close the screen
sca;