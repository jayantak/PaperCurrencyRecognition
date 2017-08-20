clc;
clear all;
close all;

denominations = {'10','20','50','100','500','1000'};
orientation = {'front','back'};

index = 5;
location = '../../Notes_Images/DatabaseRevised/rupee_';
fileNames = {};
database = {};
n = 1;
databaseLegend = {'Image', 'Denomination', 'Index', 'Orientation', 'Length', 'Width','Aspect Ratio', 'Red Channel Mean', 'Green Channel Mean', 'Blue Channel Mean', 'Hue Angle Mean', 'Mean(Grey)', 'Std(Grey)'};
lengthSum = zeros(6,2);
widthSum = zeros(6,2);
ratioSum = zeros(6,2);
redMeanSum = zeros(6,2);
greenMeanSum = zeros(6,2);
blueMeanSum = zeros(6,2);
hueSum = zeros(6,2);
meanSum = zeros(6,2);
stdSum = zeros(6,2);

for k = 1:2
    for i = 1:6
        for j = 1:index
            fileNames(n) = strcat(location,denominations(i),'_',int2str(j),'_',orientation(k),'_norm.jpg');
            database{n, 1} = imread(char(fileNames(n)));
            
            [width,length, col] = size(database{n, 1});
            database{n, 2} = char(denominations(i));
            database{n, 3} = j;
            database{n, 4} = char(orientation(k));
            
            database{n, 5} = length;
            lengthSum(i,k) = lengthSum(i,k)+length;
            
            database{n, 6} = width; 
            widthSum(i,k) = widthSum(i,k)+width;
            
            database{n, 7} = length/width;
            ratioSum(i,k) = ratioSum(i,k)+length/width;
            
            database{n, 8} = mean2(database{n, 1}(:, :, 1));
            redMeanSum(i,k) = redMeanSum(i,k)+database{n, 8};
            
            database{n, 9} = mean2(database{n, 1}(:, :, 2));
            greenMeanSum(i,k) = greenMeanSum(i,k)+database{n, 9};
            
            database{n, 10} = mean2(database{n, 1}(:, :, 3));
            blueMeanSum(i,k) = blueMeanSum(i,k)+database{n,10};
            
            hsvImg = rgb2hsv(database{n, 1});
            database{n, 11} = mean2(hsvImg(:,:,1));
            hueSum(i,k) = hueSum(i,k)+database{n, 11};
           
            greyImg = rgb2gray(database{n, 1});
            database{n, 12} = mean2(greyImg);
            meanSum(i,k) = meanSum(i,k)+database{n,12};
            
            database{n, 13} = std2(greyImg);
            stdSum(i,k) = stdSum(i,k)+database{n,13};
    
            n = n + 1;
        end
    end
end

lengthReference = lengthSum/index;
dlmwrite('Reference/Denomination/length.dat',lengthReference);
widthReference = widthSum/index;
dlmwrite('Reference/Denomination/width.dat',widthReference);
ratioReference = ratioSum/index;
dlmwrite('Reference/Denomination/ratio.dat',ratioReference);
redMeanReference = redMeanSum/index;
dlmwrite('Reference/Denomination/redMean.dat',redMeanReference);
greenMeanReference = greenMeanSum/index;
dlmwrite('Reference/Denomination/greenMean.dat',greenMeanReference);
blueMeanReference = blueMeanSum/index;
dlmwrite('Reference/Denomination/blueMean.dat',blueMeanReference);
hueReference = hueSum/index;
dlmwrite('Reference/Denomination/hue.dat',hueReference);
meanReference = meanSum/index;
dlmwrite('Reference/Denomination/mean.dat',meanReference);
stdReference = stdSum/index;
dlmwrite('Reference/Denomination/std.dat',stdReference);

ReferenceValues = [lengthReference(:,1) widthReference(:,1) ratioReference(:,1) redMeanReference(:,1) greenMeanReference(:,1) blueMeanReference(:,1) hueReference(:,1) meanReference(:,1) stdReference(:,1)]
xlswrite('Denomination.xls',ReferenceValues);

noOfNotes = (n-1)/2;

database;
h = msgbox('Done');