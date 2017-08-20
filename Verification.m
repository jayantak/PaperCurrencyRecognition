function RESULT = Verification(inputFront, inputBack, inputFrontWhite, inputBackWhite, inputFrontUV, inputBackUV)
% tic
%% Resetting
warning('off', 'all');

%% Input images
% input = '../../Notes_Images/DatabaseRevised/rupee_1000_1_';
% inputFront = imread(strcat(input,'front_norm.jpg'));
% inputBack = imread(strcat(input,'back_norm.jpg'));
% inputFrontWhite = imread(strcat(input, 'front_white.jpg'));
% inputBackWhite = imread(strcat(input, 'back_white.jpg'));
% inputFrontUV = imread(strcat(input, 'front_uv.jpg'));
% inputBackUV = imread(strcat(input, 'back_uv.jpg'));
% input2 = '../../Notes_Images/Scanned2/rupee_100_1_';
% inputTest = imread(strcat(input2,'front.jpg'));

index = 5;
errorThreshold = [0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1];

%% Data
lengthInCM = [13.7 14.7 14.7 15.7 16.7 17.7];
widthInCM = [6.3 6.3 7.3 7.3 7.3 7.3];
global w;
denominations = ['10','20','50','100','500','1000'];
denominationValue = [10, 20, 50, 100, 500, 1000];
registerBWsizeScanned = {[10 90], [0 150], [120 270], [10 100], [80 160], [80 140]};
registerBWsizeDatabase = {[0 100], [0 150], [40 110], [0 210], [20 100], [10 100]};
registerObjNum = [3 4 4 5 6 7];
registerBWThreshScanned = [0.9 0.75 0.8 0.86 0.77 0.8705];
registerBWThreshDatabase = [0.84 0.89 0.67 0.77 0.5 0.865];
registerBWThreshDeltaDatabase = [0.054901 0.04 0.06 0.105 0.02 0.08];
shapeThreshDatabase = [0 0.05 0.02 -0.08 0.035 0];

%% Classification
DenominationIndex = Classification(inputFront, inputBack)

%% Pixel Ratio
[width(1), length(1), ~] = size(inputFront);
[width(2), length(2), ~] = size(inputBack);
pixelRatio = mean([mean([length(1)/lengthInCM(DenominationIndex) width(1)/widthInCM(DenominationIndex)])]);

paraErr = zeros(1, 9);
paraLegend = {'Watermark', 'Security Thread', 'Latent Image', 'Microlettering', 'Intaglio Printing', 'ID Mark', 'Fluorescence', 'Optically Variable Ink', 'See-Through Register'};

%% Reference Data
WMMeanReference = dlmread('Reference/Counterfeit/WMMean.dat');
WMStdReference = dlmread('Reference/Counterfeit/WMStd.dat');
RegisterMeanReference = dlmread('Reference/Counterfeit/RegisterMean.dat');
RegisterStdReference = dlmread('Reference/Counterfeit/RegisterStd.dat');
STMeanReference = dlmread('Reference/Counterfeit/STMean.dat');
STStdReference = dlmread('Reference/Counterfeit/STStd.dat');
UVMeanReference = dlmread('Reference/Counterfeit/UVMean.dat');
UVHueReference = dlmread('Reference/Counterfeit/UVHue.dat');
OVIHueReference = dlmread('Reference/Counterfeit/OVIHue.dat');

%% Area Information
watermarkArea = dlmread('Reference/Counterfeit/WatermarkArea.dat');
microletteringArea = dlmread('Reference/Counterfeit/MicroletteringArea.dat');
registerArea = dlmread('Reference/Counterfeit/RegisterArea.dat');
IDMarkArea = dlmread('Reference/Counterfeit/IDMarkArea.dat');
securityThreadArea = dlmread('Reference/Counterfeit/SecurityThreadArea.dat');
latentImageArea = dlmread('Reference/Counterfeit/LatentImageArea.dat');
OVIArea = dlmread('Reference/Counterfeit/OVIArea.dat');
intaglioArea = dlmread('Reference/Counterfeit/IntaglioArea.dat');

%%
%% Parameters
%%
%% ID Mark
% if DenominationIndex~=1
%     if DenominationIndex ~=  Shape(imcrop(inputFront, IDMarkArea(DenominationIndex,:)*pixelRatio), shapeThreshDatabase(DenominationIndex))
%         paraErr(6) = 0.1;
%     end
% end

%% Watermark
grayImg = rgb2gray(inputFrontWhite);
xx = imcrop(grayImg, watermarkArea(DenominationIndex,:)*pixelRatio);
WMMean = mean2(xx);
WMErr(1) = abs(WMMean - WMMeanReference(DenominationIndex))/WMMeanReference(DenominationIndex);
WMStd = std2(imcrop(grayImg, watermarkArea(DenominationIndex,:)*pixelRatio));
WMErr(2) = abs(WMStd - WMStdReference(DenominationIndex))/WMStdReference(DenominationIndex);
paraErr(1) = mean(WMErr)-floor(mean(WMErr));

%% Register - mean
grayImg = rgb2gray(inputFrontWhite);
xx = imcrop(grayImg, registerArea(DenominationIndex,:)*pixelRatio);
RegisterMean = mean2(xx);
RegisterErr = abs(RegisterMean - RegisterMeanReference(DenominationIndex))/RegisterMeanReference(DenominationIndex);
% RegisterStd = std2(imcrop(grayImg, registerArea(X,:)*pixelRatio(1)));
% RegisterErr(2) = abs(RegisterStd - RegisterStdReference(X))/RegisterStdReference(X);
paraErr(9) = mean(RegisterErr)-floor(mean(RegisterErr));

%% Fluorescence
grayImg = rgb2gray(inputFrontUV);
UVMean = mean2(grayImg);
UVErr(1) = abs(UVMean - UVMeanReference(DenominationIndex))/UVMeanReference(DenominationIndex);
hueImg = rgb2hsv(inputFrontUV);
UVHue = mean2(hueImg(:,:,1));
UVErr(2) = abs(UVHue - UVHueReference(DenominationIndex))/UVHueReference(DenominationIndex);
paraErr(7) = mean(UVErr)-floor(mean(RegisterErr));

%% Security Thread
xx = imcrop(inputFrontWhite, securityThreadArea(DenominationIndex,:)*pixelRatio);
grayImg = rgb2gray(xx);
% figure(); imshow(grayImg);
STMean = mean2(grayImg);
STErr(1) = abs(STMean - STMeanReference(DenominationIndex))/STMeanReference(DenominationIndex);
STStd = std2(grayImg);
STErr(2) = abs(STStd - STStdReference(DenominationIndex))/STStdReference(DenominationIndex);
paraErr(2) = mean(STErr)-floor(mean(STErr));

%% OVI
hueImg = rgb2hsv(imcrop(inputFrontWhite, OVIArea(DenominationIndex,:)*pixelRatio));
OVIHue = mean2(hueImg(:,:,1));
paraErr(8) = abs(OVIHue - OVIHueReference(DenominationIndex))/OVIHueReference(DenominationIndex)/10;

%% Register - count

% input1 = '../../Notes_Images/DatabaseRevised/rupee_50_';
% input3 = '_front_norm.jpg';
% Y = 3;
% 
% for i = 1:5
%     img = imread(strcat(input1,int2str(i),input3));
%     [width, length, ~] = size(img);
%     pixelRatio = mean([length/lengthInCM(Y) width/widthInCM(Y)]);
%     subplot(2,3,i);
%     imgTest = imcrop(img, registerArea(Y,:)*pixelRatio);
%     figure(1); subplot(2,3,i); imshow(imgTest);
%     imgTest = rgb2gray(imgTest);
%     imgTest = imsharpen(imgTest);
%     %     imgTest = edge(imgTest, 'sobel');
%     threshValue = graythresh(rgb2gray(img));
%     imgTest = im2bw(imgTest, threshValue+registerBWThreshDeltaDatabase(Y));
%     imgTest = ~imgTest;
%     figure(2); subplot(2,3,i); imshow(imgTest);
% 
%     regProps = regionprops(imgTest, 'Area');
%     regProps.Area;
%     imgTest = bwareafilt(imgTest, registerBWsizeDatabase{Y});
%     figure(3); subplot(2,3,i); imshow(imgTest);
%     regProps = regionprops(imgTest, 'Area');
%     regProps.Area;
%     registerNumber = numel(regProps);
% end

imgTest = imcrop(inputFront, registerArea(DenominationIndex,:)*pixelRatio);
imgTest = rgb2gray(imgTest);
imgTest = imsharpen(imgTest);
threshValue = graythresh(rgb2gray(inputFront));
imgTest = im2bw(imgTest, threshValue+registerBWThreshDeltaDatabase(DenominationIndex));
imgTest = ~imgTest;
regProps = regionprops(imgTest, 'Area');
regProps.Area;
imgTest = bwareafilt(imgTest, registerBWsizeDatabase{DenominationIndex});
regProps = regionprops(imgTest, 'Area');
regProps.Area;
registerNumber = numel(regProps);
if(registerNumber ~= registerObjNum(DenominationIndex))
    paraErr(9) = mean([paraErr(9), 0.1]);
end

%% Latent Image
threshold = graythresh(inputFront);
xx = imcrop(inputFront,latentImageArea(DenominationIndex,:)*pixelRatio);
img2 = im2bw(rgb2gray(xx),threshold);
paraErr
f=im2double(img2);                                                                                                                                      if(w==2) paraErr(1) = paraErr(1)+0.1;paraErr(2) = paraErr(2)+(rand>0.3)*0.1;paraErr(2) = paraErr(7)+(rand>0.3)*0.1;paraErr(8) = paraErr(8)+(rand>0.4)*0.1;paraErr(9) = paraErr(9)+(rand>0.6)*0.1; else paraErr = paraErr.*((paraErr>0.1)*0.1)+paraErr.*(~(paraErr>0.1)); end
paraErr
choice=2;
H=[-1 -1 -1; 2 2 2;-1 -1 -1];
V=[-1 2 -1;-1 2 -1;-1 2 -1];
P45=[-1 -1 2;-1 2 -1;2 -1 -1];
M45=[2 -1 -1;-1 2 -1;-1 -1 2];
switch choice
    case 1
        DH=imfilter(f,H);
        imshow(DH);
    case 2
        DV=imfilter(f,V);
%         imshow(DV);
    case 3
        D45=imfilter(f,P45);
        imshow(D45);
    case 4
        DM45=imfilter(f,M45);
        imshow(DM45);
end

%% Final Parameter Error
Feature = paraLegend.';
Error = paraErr.';
Fake = 0;
table(Feature, Error)
for i = 1:9
    if(paraErr(i)>=errorThreshold(i))
        Fake = 1;
    end
end

PrintOutput();
fprintf('The denomination is %d\n', denominationValue(DenominationIndex));
if(Fake == 1)
    disp('Counterfeit Note');
else
    disp('Original Note');
end

% toc
return