function J = kernel_generator(I)
[height,width]=size(I);
kernel_min_size = 3;
kernel_max_size = 23;
J=I;
I=padarray(I,[kernel_max_size,kernel_max_size],'replicate');
for x=1:width
    for y=1:height
        for kernel=kernel_min_size:2:kernel_max_size
            pixel=((kernel-1)/2);
            C=I(y-pixel+kernel_max_size:y+pixel+kernel_max_size,x-pixel+kernel_max_size:x+pixel+kernel_max_size);
            [flag,value]=adoptive_median_filter(C,kernel);
            if(flag==1)
                continue;
            else
                J(y,x)=value;
                break;
            end
        end
    end
end
end