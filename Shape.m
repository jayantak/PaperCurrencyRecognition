function shapeIndex = Shape(S, thresh)

%% Preprocessing
% figure(); imshow(S);
S = rgb2gray(S);
S = imgaussfilt(S);
threshold = graythresh(S);
Sbw = im2bw(S, threshold+thresh);
Sbw = ~ Sbw;
% figure();  imshow(Sbw);
Sbw = bwpropfilt(Sbw,'Area',1);
S = Sbw;
shapeIndex = 0;

%% Triangle
[H, ~, ~]=hough(S);
clear data;
for cnt = 1:max(max(H))
    data(cnt) = sum(sum(H == cnt));
end
[maxval,maxind] = max(data);
medval = median(data);

[p]=polyfit(1:maxind-3,data(1:maxind-3),2);

%% Quadrilaterals
[B,L] = bwboundaries(Sbw, 'noholes');
STATS = regionprops(Sbw, 'all');
W = uint8(abs(STATS(1).BoundingBox(3)-STATS(1).BoundingBox(4))/STATS(1).BoundingBox(4) < 0.2);

extrema = STATS(1).Extrema;
extent = STATS(1).Extent;

%% Checking
if maxval<3*medval
    shapeIndex = 4;
elseif extent<0.7||extent>0.79
    if W == 1
        if (comparePoints(extrema(1,:),extrema(2,:)) && comparePoints(extrema(3,:),extrema(4,:)) && comparePoints(extrema(5,:),extrema(6,:)) && comparePoints(extrema(7,:),extrema(8,:)) && extent<0.75)
            shapeIndex = 6;
        else
            shapeIndex = 3;
        end
    else
        shapeIndex = 2;
    end
else
    shapeIndex = 5;
end
% disp(shapeIndex);

return;