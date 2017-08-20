clc;
clear all;
close all;
warning('off', 'all');

counterfeit = 0;
lengthInCM = [13.7 14.7 14.7 15.7 16.7 17.7];
widthInCM = [6.3 6.3 7.3 7.3 7.3 7.3];
denominationsVal = [10, 20, 50, 100, 500, 1000];
denominations = {'10','20','50','100','500','1000'};
orientation = {'front','back'};

index = 5;
location = '../../Notes_Images/DatabaseRevised/rupee_';
fileNames = {};
database = {};
n = 1;
databaseLegend = {'Image','Image-UV','Image-White','Image-Watermark Area', 'GreyScale Image Mean', 'GreyScale Image StD'};
lengthReference = dlmread('Reference/Denomination/length.dat');
widthReference = dlmread('Reference/Denomination/width.dat');
watermarkArea = dlmread('Reference/Counterfeit/WatermarkArea.dat');
microletteringArea = dlmread('Reference/Counterfeit/MicroletteringArea.dat');
registerArea = dlmread('Reference/Counterfeit/RegisterArea.dat');
IDMarkArea = dlmread('Reference/Counterfeit/IDMarkArea.dat');
securityThreadArea = dlmread('Reference/Counterfeit/SecurityThreadArea.dat');
latentImageArea = dlmread('Reference/Counterfeit/LatentImageArea.dat');
OVIArea = dlmread('Reference/Counterfeit/OVIArea.dat');
intaglioArea = dlmread('Reference/Counterfeit/IntaglioArea.dat');
registerObjNum = [3 4 4 5 6 7];


WMMeanSum = zeros(1,6);
WMStdSum = zeros(1,6);
registerMeanSum = zeros(1,6);
registerStdSum = zeros(1,6);
STMeanSum = zeros(1,6);
STStdSum = zeros(1,6);

UVMeanSum = zeros(1,6);
UVHueSum = zeros(1,6);
OVIHueSum = zeros(1,6);

for i = 1:6
    for j = 1:index
        fileNames(n) = strcat(location,denominations(i),'_',int2str(j),'_',orientation(1));
        database{n, 1} = imread(strcat(char(fileNames(n)),'_norm.jpg'));
        database{n, 2} = imread(strcat(char(fileNames(n)),'_uv.jpg'));
        database{n, 3} = imread(strcat(char(fileNames(n)),'_white.jpg'));
        fileNames(n) = strcat(location,denominations(i),'_',int2str(j),'_',orientation(2));
        database{n, 4} = imread(strcat(char(fileNames(n)),'_norm.jpg'));
        database{n, 5} = imread(strcat(char(fileNames(n)),'_uv.jpg'));
        database{n, 6} = imread(strcat(char(fileNames(n)),'_white.jpg'));        
        
        [width(1), length(1), col] = size(database{n,1});
        [width(2), length(2), col] = size(database{n,4});
        
        pixelRatio = mean([mean([length(1)/lengthInCM(i) width(1)/widthInCM(i)]), mean([length(2)/lengthInCM(i) width(2)/widthInCM(i)])]);
        watermarkCrop = imcrop(database{n, 3}, watermarkArea(i,:)*pixelRatio);
        greyImg = rgb2gray(watermarkCrop);
        WMMeanSum(i) = WMMeanSum(i)+mean2(greyImg);

        WMStdSum(i) = WMStdSum(i)+std2(greyImg);
        
        registerCrop = imcrop(database{n, 3}, registerArea(i,:)*pixelRatio);
        greyImg = rgb2gray(registerCrop);
        registerMeanSum(i) = registerMeanSum(i)+mean2(greyImg);
        
        registerStdSum(i) = registerStdSum(i)+std2(greyImg);
        
        securityThreadCrop = imcrop(database{n, 3}, securityThreadArea(i,:)*pixelRatio);
        greyImg = rgb2gray(securityThreadCrop);
        STMeanSum(i) = STMeanSum(i)+mean2(greyImg);
        
        STStdSum(i) = STStdSum(i)+std2(greyImg);
        
        UVMeanSum(i) = UVMeanSum(i) + mean2(rgb2gray(database{n, 2}));
        UVhsv = rgb2hsv(database{n, 2});
        UVHueSum(i) = UVHueSum(i) + mean2(UVhsv(:,:,1));
        
        OVICrop = imcrop(database{n, 2},OVIArea(1,:)*pixelRatio);
        OVICropHSV = rgb2hsv(OVICrop);
        OVIHueSum(i) = OVIHueSum(i) + mean2(OVICropHSV(:,:,1));
        
        n = n + 1;
    end
end



WMMeanReference = WMMeanSum/index;
dlmwrite('Reference/Counterfeit/WMMean.dat',WMMeanReference);
WMStdReference = WMStdSum/index;
dlmwrite('Reference/Counterfeit/WMStd.dat',WMStdReference);

registerMeanReference = registerMeanSum/index;
dlmwrite('Reference/Counterfeit/RegisterMean.dat',registerMeanReference);
registerStdReference = registerStdSum/index;
dlmwrite('Reference/Counterfeit/RegisterStd.dat',registerStdReference);

STMeanReference = STMeanSum/index;
dlmwrite('Reference/Counterfeit/STMean.dat',STMeanReference);
STStdReference = STStdSum/index;
dlmwrite('Reference/Counterfeit/STStd.dat',STStdReference);

UVMeanReference = UVMeanSum/index;
dlmwrite('Reference/Counterfeit/UVMean.dat',UVMeanReference);
UVHueReference = UVHueSum/index;
dlmwrite('Reference/Counterfeit/UVHue.dat',UVHueReference);

OVIHueReference = OVIHueSum/index;
dlmwrite('Reference/Counterfeit/OVIHue.dat',OVIHueReference);

EXCEL = [WMMeanReference.' STMeanReference.' UVMeanReference.' OVIHueReference.' registerObjNum.']  
xlswrite('Counterfeit.xls',EXCEL);


h = msgbox('Done');