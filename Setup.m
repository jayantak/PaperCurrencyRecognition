clc;
clear all;
close all;

watermarkArea = [1.5 1.7 2.8 3.1; 1.6 1.6 2.7 3.3; 2 1.8 2.7 3.2; 1.6 2 2.8 3.2; 2 1.9 3.1 4.1; 1.9 1.9 2.7 3.5]
microletteringArea = [11.5 3.5 0.5 0.2; 12.6 2.2 0.3 3.7; 12.3 3.9 0.5 0.3; 13 4 0.5 0.3; 14.1 3.8 0.6 0.4; 15.3 1.9 0.3 1]
registerArea = [0.7 2.7 0.9 0.65; 0.3 1.5 0.9 1; 0.1 2.65 1.5 1.3; 0.1 2.7 1.15 1.1; 0.1 2.4 1.6 1.1; 0.15 2.7 1.9 0.95]
IDMarkArea = [0 0 0 0; 0.4 3 0.55 0.6; 0.1 3.9 1.2 1.1; 0.2 3.9 0.8 1; 0.4 3.7 0.7 0.85; 0.1 3.7 1.5 1.1]
securityThreadArea = [7.3 0 1 6.3; 8.3 0 1 6.3; 8.3 0 1.5 7.3; 8.5 0 2 7.3; 9 0 2 7.3; 9 0 1.8 7.3]
latentImageArea = [12.2 2.2 1 1.8; 13.1 2.45 1.1 1.7; 13.2 2.7 1.15 1.7; 14 2.7 1.3 2; 14.8 2.5 1.2 2.3; 15.8 2.4 1.4 2.35]
OVIArea = [6.2 2 1.7 1.6; 5.8 2 2.2 1.5; 6.3 2.5 2.5 1.8; 5.8 2.35 3.4 1.75; 6.7 2.5 3 1.6; 7 2.5 3.7 1.6]
intaglioArea = [8.8 1 3.3 4; 9.2 1.1 3.3 3.9; 9.5 1.5 3.4 4.0; 10.2 1.5 3.5 3.9; 11.2 1.5 3.5 4; 12.1 1.6 3.2 3.8]


% xlswrite('../../Areas.xls', [watermarkArea.'; microletteringArea.'; registerArea.'; IDMarkArea.'; securityThreadArea.'; latentImageArea.'; OVIArea.'; intaglioArea.']);

dlmwrite('Reference/Counterfeit/WatermarkArea.dat',watermarkArea);
dlmwrite('Reference/Counterfeit/MicroletteringArea.dat', microletteringArea);
dlmwrite('Reference/Counterfeit/RegisterArea.dat', registerArea);
dlmwrite('Reference/Counterfeit/IDMarkArea.dat', IDMarkArea);
dlmwrite('Reference/Counterfeit/SecurityThreadArea.dat', securityThreadArea);
dlmwrite('Reference/Counterfeit/LatentImageArea.dat', latentImageArea);
dlmwrite('Reference/Counterfeit/OVIArea.dat', OVIArea);
dlmwrite('Reference/Counterfeit/IntaglioArea.dat', intaglioArea);

% h = msgbox('Done');