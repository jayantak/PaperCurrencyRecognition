function n = continueScan1(ok)

global u;

if(strcmp(ok,'1'))
    u = 4;
    n = 1;
else if(strcmp(ok,'1 '))
        u = 5;
        n = 1;
    else if(strcmp(ok,' 1'))
            u = 6;
            n = 1;
        else if(strcmp(ok, '0'))
                n = 0
            else
                n = 1;
            end
        end
    end
end
return