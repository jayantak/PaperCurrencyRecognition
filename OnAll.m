function OnAll()

x = [2 3 4 5 6 7 8 9 10 11 12 13];
global a;
for i=1:length(x)
    writeDigitalPin(a, strcat('D', int2str(x(i))), 1);
end

return;