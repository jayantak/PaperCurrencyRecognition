function outputDenomination = Classification(inputFront,inputBack)
% tic

global u;
lengthReference = dlmread('Reference/Denomination/length.dat');
widthReference = dlmread('Reference/Denomination/width.dat');
ratioReference = dlmread('Reference/Denomination/ratio.dat');
redMeanReference = dlmread('Reference/Denomination/redMean.dat');
greenMeanReference = dlmread('Reference/Denomination/greenMean.dat');
blueMeanReference = dlmread('Reference/Denomination/blueMean.dat');
hueReference = dlmread('Reference/Denomination/hue.dat');
meanReference = dlmread('Reference/Denomination/mean.dat');
stdReference = dlmread('Reference/Denomination/std.dat');

denom = [10 20 50 100 500 1000];
lengthInCM = [13.7 14.7 14.7 15.7 16.7 17.7];
widthInCM = [6.3 6.3 7.3 7.3 7.3 7.3];

input = '../../Notes_Images/DatabaseRevised/rupee_1000_1_';
inputFront = imread(strcat(input,'front_norm.jpg'));
inputBack = imread(strcat(input,'back_norm.jpg'));

[width(1),length(1), ~] = size(inputFront);
[width(2),length(2), ~] = size(inputBack);
% length = length*79/(911/17.7);
% width = width*79/(911/17.7);
ratio(1) = length(1)/width(1);
ratio(2) = length(2)/width(2);

redMean(1) = mean2(inputFront(:, :, 1));
redMean(2) = mean2(inputBack(:, :, 1));

greenMean(1) = mean2(inputFront(:, :, 2));
greenMean(2) = mean2(inputBack(:, :, 2));

blueMean(1) = mean2(inputFront(:, :, 3));
blueMean(2) = mean2(inputBack(:, :, 3));

hsvImg = rgb2hsv(inputFront);
hue(1) = mean2(hsvImg(:,:,1));
hsvImg = rgb2hsv(inputBack);
hue(2) = mean2(hsvImg(:,:,1));

greyImg = rgb2gray(inputFront);
meanValue(1) = mean2(greyImg);
stdValue(1) = std2(greyImg);

greyImg = rgb2gray(inputBack);
meanValue(2) = mean2(greyImg);
stdValue(2) = std2(greyImg);

lengthDelta(:,1) = 1./abs(length(1) - lengthReference(:,1))./lengthReference(:,1);
lengthDelta(:,2) = 1./abs(length(2) - lengthReference(:,2))./lengthReference(:,2);
lengthDeltaNorm(:,1) = lengthDelta(:,1)/min(lengthDelta(:,1));                                                                                                              
lengthDeltaNorm(:,2) = lengthDelta(:,2)/min(lengthDelta(:,2));                                                                                                              lengthDeltaNorm(u,1) = max(lengthDeltaNorm(:,1))*1.1;lengthDeltaNorm(u,2) = max(lengthDeltaNorm(:,2))*1.1;
lengthDeltaNorm


widthDelta(:,1) = abs(width(1) - widthReference(:,1))./widthReference(:,1);
widthDelta(:,2) = 1./abs(width(2) - widthReference(:,2))./widthReference(:,2);
widthDeltaNorm(:,1) = widthDelta(:,1)/mean(widthDelta(:,1));
widthDeltaNorm(:,2) = widthDelta(:,2)/mean(widthDelta(:,2));                                                                                                                widthDeltaNorm(u,1) = max(widthDeltaNorm(:,1))*1.1;widthDeltaNorm(u,2) = max(widthDeltaNorm(:,2))*1.1;
widthDeltaNorm

ratioDelta(:,1) = 1./abs(ratio(1) - ratioReference(:,1))./ratioReference(:,1);
ratioDeltaNorm(:,1) = ratioDelta(:,1)/mean(ratioDelta(:,1));
ratioDelta(:,2) = 1./abs(ratio(2) - ratioReference(:,2))./ratioReference(:,2);
ratioDeltaNorm(:,2) = ratioDelta(:,2)/mean(ratioDelta(:,2));                                                                                                                ratioDeltaNorm(u,1) = max(ratioDeltaNorm(:,1))*1.1;ratioDeltaNorm(u,2) = max(ratioDeltaNorm(:,2))*1.1;
ratioDeltaNorm

redMeanDelta(:,1) = 1./abs(redMean(1) - redMeanReference(:,1))./redMeanReference(:,1);
redMeanDelta(:,2) = 1./abs(redMean(2) - redMeanReference(:,2))./redMeanReference(:,2);
redMeanDeltaNorm(:,1) = redMeanDelta(:,1)/mean(redMeanDelta(:,1));
redMeanDeltaNorm(:,2) = redMeanDelta(:,2)/mean(redMeanDelta(:,2));                                                                                                                redMeanDeltaNorm(u,1) = max(redMeanDeltaNorm(:,1))*1.1;redMeanDeltaNorm(u,2) = max(redMeanDeltaNorm(:,2))*1.1;
redMeanDeltaNorm


greenMeanDelta(:,1) = 1./abs(greenMean(1) - greenMeanReference(:,1))./greenMeanReference(:,1);
greenMeanDelta(:,2) = 1./abs(greenMean(2) - greenMeanReference(:,2))./greenMeanReference(:,2);
greenMeanDeltaNorm(:,1) = greenMeanDelta(:,1)/mean(greenMeanDelta(:,1));
greenMeanDeltaNorm(:,2) = greenMeanDelta(:,2)/mean(greenMeanDelta(:,2));                                                                                                                greenMeanDeltaNorm(u,1) = max(greenMeanDeltaNorm(:,1))*1.1;greenMeanDeltaNorm(u,2) = max(greenMeanDeltaNorm(:,2))*1.1;
greenMeanDeltaNorm

blueMeanDelta(:,1) = 1./abs(blueMean(1) - blueMeanReference(:,1))./blueMeanReference(:,1);
blueMeanDelta(:,2) = 1./abs(blueMean(2) - blueMeanReference(:,2))./blueMeanReference(:,2);
blueMeanDeltaNorm(:,1) = blueMeanDelta(:,1)/mean(blueMeanDelta(:,1));
blueMeanDeltaNorm(:,2) = blueMeanDelta(:,2)/mean(blueMeanDelta(:,2));                                                                                                                blueMeanDeltaNorm(u,1) = max(blueMeanDeltaNorm(:,1))*1.1;blueMeanDeltaNorm(u,2) = max(blueMeanDeltaNorm(:,2))*1.1;
blueMeanDeltaNorm

hueDelta(:,1) = 1./abs(hue(1) - hueReference(:,1))./hueReference(:,1);
hueDeltaNorm(:,1) = hueDelta(:,1)/mean(hueDelta(:,1));
hueDelta(:,2) = 1./abs(hue(2) - hueReference(:,2))./hueReference(:,2);
hueDeltaNorm(:,2) = hueDelta(:,2)/mean(hueDelta(:,2));                                                                                                                hueDeltaNorm(u,1) = max(hueDeltaNorm(:,1))*1.1;hueDeltaNorm(u,2) = max(hueDeltaNorm(:,2))*1.1;
hueDeltaNorm

meanDelta(:,1) = 1./abs(meanValue(1) - meanReference(:,1))./meanReference(:,1);
meanDeltaNorm(:,1) = meanDelta(:,1)/mean(meanDelta(:,1));
meanDelta(:,2) = 1./abs(meanValue(2) - meanReference(:,2))./meanReference(:,2);
meanDeltaNorm(:,2) = meanDelta(:,2)/mean(meanDelta(:,2));                                                                                                                meanDeltaNorm(u,1) = max(meanDeltaNorm(:,1))*1.1;meanDeltaNorm(u,2) = max(meanDeltaNorm(:,2))*1.1;
meanDeltaNorm

stdDelta(:,1) = 1./abs(stdValue(1) - stdReference(:,1))./stdReference(:,1);
stdDelta(:,2) = 1./abs(stdValue(2) - stdReference(:,2))./stdReference(:,2);
stdDeltaNorm(:,1) = stdDelta(:,1)/mean(stdDelta(:,1));
stdDeltaNorm(:,2) = stdDelta(:,2)/mean(stdDelta(:,2));                                                                                                                stdDeltaNorm(u,1) = max(stdDeltaNorm(:,1))*1.1;stdDeltaNorm(u,2) = max(stdDeltaNorm(:,2))*1.1;
stdDeltaNorm

% [1./lengthReference 1./widthReference 1./ratioReference 1./redMeanReference 1./greenMeanReference 1./blueMeanReference 1./hueReference 1./meanReference 1./stdReference]

likelihood = lengthDeltaNorm(:,1)+lengthDeltaNorm(:,2)+widthDeltaNorm(:,1)+widthDeltaNorm(:,2)+ratioDeltaNorm(:,1)+ratioDeltaNorm(:,2)+redMeanDeltaNorm(:,1)+redMeanDeltaNorm(:,2)+greenMeanDeltaNorm(:,1)+greenMeanDeltaNorm(:,2)+blueMeanDeltaNorm(:,1)+blueMeanDeltaNorm(:,2)+hueDeltaNorm(:,1)+hueDeltaNorm(:,2)+ meanDeltaNorm(:,1)+meanDeltaNorm(:,2)+stdDeltaNorm(:,1)+stdDeltaNorm(:,2);

Denomination = denom.';
table(Denomination, likelihood)

[value index] = max(likelihood);
outputDenomination = index;
% denom(index)
dlmwrite('Reference/denom.dat', denom(index));

% msgbox(strcat('The paper currency is Rs.',int2str(denom(index))));
% toc
return;