function n = continueScan(ok)

global u;

if(strcmp(ok,'1'))
    u = 1;
    n = 1;
else if(strcmp(ok,'1 '))
        u = 2;
        n = 1;
    else if(strcmp(ok,' 1'))
            u = 3;
            n = 1;
        else if(strcmp(ok, '0'))
                n = 0;
            else
                n = 1;
            end
        end
    end
end
return