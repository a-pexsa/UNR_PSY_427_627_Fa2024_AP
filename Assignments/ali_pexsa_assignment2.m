%% Set up screen
% Variables
screenColor = [128,128,128];
% Below is only relevant for non-full-screen 
%screenSize = [400,400];
%screenUpperLeft = [200,200];
%screenRect = [screenUpperLeft, screenUpperLeft + screenSize];
screenRect = []; % for fullscreen
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
[screen_x,screen_y] = Screen('WindowSize', w);
new_img_height = 1024/2;
new_img_width = 1024/2;

%dictate left and right side of screen for images 
%help from past lab screen setups: gets left side of screen and middle
%point using dimensions of image to be shown 
left_rect = [(screen_x / 4) - (new_img_width / 2), (screen_y / 2) - (new_img_height / 2), ...
    (screen_x / 4) + (new_img_width / 2), (screen_y / 2) + (new_img_height / 2)];

%multipled by 3 is essentially flipping from left side to right side 
right_rect = [(3 * screen_x / 4) - (new_img_width / 2), (screen_y / 2) - (new_img_height / 2), ...
    (3 * screen_x / 4) + (new_img_width / 2), (screen_y / 2) + (new_img_height / 2)];
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
SelectedIFaces = randperm(numFaces, n); %selecting n images from the Faceslist
SelectedIPlaces = randperm(numPlaces, n); %selecting n images from the Placeslist
SelectedIObjects = randperm(numObjects, n); %selecting n images from the Objectslist


%% Setting up arrays to store images
FacesImages = cell(1, n);
PlacesImages = cell(1, n);
ObjectsImages = cell(1, n);


%% Displaying Block 1 (Faces, Left)
for i = 1:n
    facefilePath = fullfile(directoryPath, FacesList(SelectedIFaces(i)).name);
    faceimage{i} = imread(facefilePath);
    facesimageTexture{i} = Screen('MakeTexture',w,faceimage{i});
    Screen('DrawTexture',w,facesimageTexture{i} ,[], left_rect); 
    Screen('Flip',w);
    %^^This feels overly complicated but it is the only way I could get it
    WaitSecs(1);
    Screen('Close',[facesimageTexture{i}]);
    Screen('Flip', w);
    WaitSecs(.25);
end
%% Displaying Block 2 (Places, Left)
for i = 1:n
    placefilePath = fullfile(directoryPath, PlacesList(SelectedIPlaces(i)).name);
    placeimage{i} = imread(placefilePath);
    placesimageTexture{i} = Screen('MakeTexture',w,placeimage{i});
    Screen('DrawTexture',w,placesimageTexture{i} ,[], left_rect); 
    Screen('Flip',w);
    WaitSecs(1);
    Screen('Close',[placesimageTexture{i}]);
    Screen('Flip', w);
    WaitSecs(.25);
end
%% Displaying Block 3 (Objects, Left)
for i = 1:n
    objectfilePath = fullfile(directoryPath, ObjectsList(SelectedIObjects(i)).name);
    objectimage{i} = imread(objectfilePath);
    objectim_small{i} = imresize(objectimage{i}, 0.125);
    objectimageTexture{i} = Screen('MakeTexture',w,objectimage{i});
    Screen('DrawTexture',w,objectimageTexture{i} ,[], left_rect); 
    Screen('Flip',w);
    WaitSecs(1);
    Screen('Close',[objectimageTexture{i}]);
    Screen('Flip', w);
    WaitSecs(.25);
end
%% Displaying Block 4 (Faces, Right)
for i = 1:n
    facefilePath = fullfile(directoryPath, FacesList(SelectedIFaces(i)).name);
    faceimage{i} = imread(facefilePath);
    facesimageTexture{i} = Screen('MakeTexture',w,faceimage{i});
    Screen('DrawTexture',w,facesimageTexture{i} ,[], right_rect); 
    Screen('Flip',w);
    WaitSecs(1);
    Screen('Close',[facesimageTexture{i}]);
    Screen('Flip', w);
    WaitSecs(.25);
end
%% Displaying Block 5 (Places, Right)
for i = 1:n
    placefilePath = fullfile(directoryPath, PlacesList(SelectedIPlaces(i)).name);
    placeimage{i} = imread(placefilePath);
    placesimageTexture{i} = Screen('MakeTexture',w,placeimage{i});
    Screen('DrawTexture',w,placesimageTexture{i} ,[], right_rect); 
    Screen('Flip',w);
    WaitSecs(1);
    Screen('Close',[placesimageTexture{i}]);
    Screen('Flip', w);
    WaitSecs(.25);
end
%% Displaying Block 6 (Objects, Right)
for i = 1:n
    objectfilePath = fullfile(directoryPath, ObjectsList(SelectedIObjects(i)).name);
    objectimage{i} = imread(objectfilePath);
    objectimageTexture{i} = Screen('MakeTexture',w,objectimage{i});
    Screen('DrawTexture',w,objectimageTexture{i} ,[], right_rect); 
    Screen('Flip',w);
    WaitSecs(1);
    Screen('Close',[objectimageTexture{i}]);
    Screen('Flip', w);
    WaitSecs(.25);
end
%% Close the screen
sca;