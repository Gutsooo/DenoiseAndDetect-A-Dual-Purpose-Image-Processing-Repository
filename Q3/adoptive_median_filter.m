function [flag,value] = adoptive_median_filter(C,kernel)
black=sum(sum(C==0));
white=sum(sum(C==255));
flag=0;
if(black+white==kernel*kernel)
    flag=1;
    value=255;
    return;
end
if(black+white>kernel*kernel/2)
    for y=1:kernel
        for x=1:kernel
            if(C(y,x)==255)
                C(y,x)=0;
            end
        end
    end
    A=C~=0;
    value=mean(C(A));
    return;
end
value=median(C,'all');
end