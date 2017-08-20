function PrintOutput()

global u;
global w;

close all;

watermarkArea = dlmread('Reference/Counterfeit/WatermarkArea.dat');
microletteringArea = dlmread('Reference/Counterfeit/MicroletteringArea.dat');
registerArea = dlmread('Reference/Counterfeit/RegisterArea.dat');
IDMarkArea = dlmread('Reference/Counterfeit/IDMarkArea.dat');
securityThreadArea = dlmread('Reference/Counterfeit/SecurityThreadArea.dat');
latentImageArea = dlmread('Reference/Counterfeit/LatentImageArea.dat');
OVIArea = dlmread('Reference/Counterfeit/OVIArea.dat');
intaglioArea = dlmread('Reference/Counterfeit/IntaglioArea.dat');

lengthInCM = [13.7 14.7 14.7 15.7 16.7 17.7];
widthInCM = [6.3 6.3 7.3 7.3 7.3 7.3];
denominations = [10,20,50,100,500,1000];
shapeThreshDatabase = [0 0.05 0.02 -0.08 0.035 0];
registerBWsizeScanned = {[10 90], [0 150], [120 270], [10 100], [80 160], [80 140]};
registerBWsizeDatabase = {[0 100], [0 150], [40 110], [0 210], [20 100], [10 100]};
registerObjNum = [3 4 4 5 6 7];
registerBWThreshScanned = [0.9 0.75 0.8 0.86 0.77 0.8705];
registerBWThreshDatabase = [0.84 0.89 0.67 0.77 0.5 0.865];
registerBWThreshDeltaDatabase = [0.054901 0.04 0.06 0.105 0.02 0.08];
input = strcat('../../Notes_Images/DatabaseRevised/rupee_',int2str(denominations(u)),'_2_');
inputFront = imread(strcat(input,'front_norm.jpg'));
inputBack = imread(strcat(input,'back_norm.jpg'));
inputFrontWhite = imread(strcat(input, 'front_white.jpg'));
inputBackWhite = imread(strcat(input, 'back_white.jpg'));
inputFrontUV = imread(strcat(input, 'front_uv.jpg'));
inputBackUV = imread(strcat(input, 'back_uv.jpg'));
input2 = strcat('../../Notes_Images/');
inputFront2 = imread(strcat(input2,'inputFrontNorm.jpg'));
inputBack2 = imread(strcat(input2,'inputBackNorm.jpg'));
inputFrontWhite2 = imread(strcat(input2, 'inputFrontWhite.jpg'));
inputBackWhite2 = imread(strcat(input2, 'inputBackWhite.jpg'));
inputFrontUV2 = imread(strcat(input2, 'inputFrontUV.jpg'));
inputBackUV2 = imread(strcat(input2, 'inputBackUV.jpg'));

[width(1), length(1), ~] = size(inputFront);
[width(2), length(2), ~] = size(inputBack);
pixelRatio = mean([mean([length(1)/lengthInCM(u) width(1)/widthInCM(u)])]);

grayImg = rgb2gray(inputFront2);
xx = imcrop(grayImg, watermarkArea(u,:)*pixelRatio);
figure('name','Watermark'); 
subplot(1,2,1); imshow(xx); title('Normal Condition');
grayImg = rgb2gray(inputFrontWhite2);
xx = imcrop(grayImg, watermarkArea(u,:)*pixelRatio);
subplot(1,2,2); imshow(xx); title('White Backlight');

xx = imcrop(inputFront, IDMarkArea(u,:)*pixelRatio);
figure('name', 'Identification Mark');
subplot(1,2,1); imshow(xx); title('Input');
threshold = graythresh(xx);
xx = ~im2bw(xx, threshold+shapeThreshDatabase(u));
subplot(1,2,2); imshow(xx); title('Binary');

if(u==3&&w==2)
    xx = imcrop(inputFront2, registerArea(u,:)*pixelRatio);
else
    xx = imcrop(inputFront, registerArea(u,:)*pixelRatio);
end
figure('name', 'See-through Register');
subplot(1,2,1); imshow(xx); title('Input');
imgTest = rgb2gray(xx);
imgTest = imsharpen(imgTest);
threshValue = graythresh(rgb2gray(inputFront));
imgTest = im2bw(imgTest, threshValue+registerBWThreshDeltaDatabase(u));
imgTest = ~imgTest;
regProps = regionprops(imgTest, 'Area');
regProps.Area;
imgTest = bwareafilt(imgTest, registerBWsizeDatabase{u});
subplot(1,2,2); imshow(imgTest); title('Isolated');

% threshold = graythresh(inputFront);
% img2 = im2bw(rgb2gray(inputFront),threshold);
% f=im2double(img2);
% V=[-1 2 -1;-1 2 -1;-1 2 -1];
% DV=imfilter(f,V);
% figure('name', 'Latent Image');
% imshow(DV); title('Isolated Area');

xx = imcrop(inputFrontWhite2, securityThreadArea(u,:)*pixelRatio);
grayImg = rgb2gray(xx);
figure('name','Security Thread');
subplot(1,2,1); imshow(xx); title('Input');
subplot(1,2,2); imshow(grayImg); title('Grey scale');

xx = edge(rgb2gray(inputFront2), 'sobel');
figure('name', 'Intaglio Printing');
imshow(xx); title('Edge Detection');

return