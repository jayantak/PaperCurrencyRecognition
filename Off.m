function x = Off(x)

global a;
for i=1:length(x)
    writeDigitalPin(a, strcat('D', int2str(x(i))), 0);
end

return;