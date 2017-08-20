function equal = comparePoints(point1, point2)
equal = 1;
if (point1(1)-point2(1))/point1(1)>0.5
    equal = 0;
elseif (point1(2)-point2(2))/point1(2)>0.5
    equal = 0;
end
return;