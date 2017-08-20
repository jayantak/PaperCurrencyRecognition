clc;
close all;
clear all;

global a;
global cam;
global u;
u = 4;
global w;
w = 1;
a = arduino()
cam = webcam(2)
cam.Resolution = '1280x960';
cam.Exposure = -3;
cam.Brightness = 255;
cam.Saturation = 20;
preview(cam);
clc;
topLights = [8, 13, 10];
UVLights = [5, 6, 9, 11];
whiteLights = [3, 7, 12];
On(10);
while(1)
    choice = input('1. Scan new notes into database \n2. Scan input note to check denomination \nEnter choice: ', 's');
    if(strcmp(choice,'1'))
        y = input('Filename: ', 's');
        %         HardwareRun(y);
        HardwareTest(1, y);
    else
        while(1)
            On(10);
            scannedFront = HardwareTest(2);
            inputFront = scannedFront{1};
            imwrite(inputFront, strcat('../../Notes_Images/inputFrontNorm.jpg'));
            inputFrontWhite = scannedFront{2};
            imwrite(inputFrontWhite, strcat('../../Notes_Images/inputFrontWhite.jpg'));
            inputFrontUV = scannedFront{3};
            imwrite(inputFrontUV, strcat('../../Notes_Images/inputFrontUV.jpg'));
            ok = input('Ok? (1/0): ', 's');
            clc;
            if(~continueScan(ok))
                continue;
            else break
            end
        end
        in = input('Please Flip Note', 's');
        while(1)
            On(10);
            scannedBack = HardwareTest(2);
            inputBack = scannedBack{1};
            imwrite(inputBack, strcat('../../Notes_Images/inputBackNorm.jpg'));
            inputBackWhite = scannedBack{2};
            imwrite(inputBackWhite, strcat('../../Notes_Images/inputBackWhite.jpg'));
            inputBackUV = scannedBack{3};
            imwrite(inputBackUV, strcat('../../Notes_Images/inputBackUV.jpg'));
            ok = input('Ok? (1/0): ', 's');
            clc;
            if(~continueScan1(ok))
                continue;
            else break
            end
        end
        Verification(inputFront, inputBack, inputFrontWhite, inputBackWhite, inputFrontUV, inputBackUV);
    end
    On(10);
    x = input('Continue? (1/0)');
    close all;
    clc;
    if x == 0
        break;
    end
end

clear all;