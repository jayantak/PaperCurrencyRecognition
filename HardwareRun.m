function HardwareRun(y)

global a;
global cam;
global xstart;
global ystart;
global xsize;
global ysize;
cropRect = [150 200 980 480];

% input = imread( '../../Notes_Images/Scanned/rupee_1000_1_front.jpg');
% img = RemoveWhiteSpace(input);

% imshow(img);
figure(2);
topLights = [10, 8, 13];
UVLights = [5, 6, 9, 11];
whiteLights = [3, 7, 12];

%% Area
cam.Exposure = -3;
cam.Brightness = 220;
cam.Saturation = 20;
On(topLights);
pause(1);
img = snapshot(cam);
img = imcrop(img, cropRect);
img2 = RemoveWhiteSpace(img, 0.8);
subplot(2,2,1); imshow(img2);

%% Norm
cam.Exposure = -3;
cam.Brightness = 200;
pause(2);
img = snapshot(cam);
img = imcrop(img, cropRect);
imgNorm = imcrop(img, [xstart ystart xsize ysize]);
imwrite(imgNorm, strcat('../../Notes_Images/DatabaseRevised/rupee_', y, '_norm.jpg'));
subplot(2,2,2); imshow(imgNorm);

%% White
Off(topLights);
On(whiteLights);
cam.Exposure = -4;
cam.Brightness = 255;
pause(2);
img = snapshot(cam);
img = imcrop(img, cropRect);
imgWhite = imcrop(img, [xstart ystart xsize ysize]);
imwrite(imgWhite, strcat('../../Notes_Images/DatabaseRevised/rupee_', y, '_white.jpg'));
% img2 = RemoveWhiteSpace(img, 0.7);
subplot(2,2,3); imshow(imgWhite);


%% UV
Off(whiteLights);
On(UVLights);
pause(2);
img = snapshot(cam);
img = imcrop(img, cropRect);
imgUV = imcrop(img, [xstart ystart xsize ysize]);
imwrite(imgUV, strcat('../../Notes_Images/DatabaseRevised/rupee_', y, '_uv.jpg'));
% img2 = RemoveWhiteSpace(img, 0.9);
subplot(2,2,4); imshow(imgUV);
Off(UVLights);



return