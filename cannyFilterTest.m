global u;
u = 0;
global w;
w = 0;
choice = input('1. Scan new notes into database \n2. Scan input note to check denomination \n3. Scan input note to check counterfeit \nEnter choice: ');
while(1)
    ok = input('Ok? (1/0): ', 's');
    if(~continueScan(ok))
        continue;
    else break
    end
end
in = input('Please Flip Note', 's');
while(1)
    ok = input('Ok? (1/0): ', 's');
    if(~continueScan1(ok))
        continue;
    else break
    end
end
disp(u)
disp(w)