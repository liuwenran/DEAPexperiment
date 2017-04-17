function [ output_args ] = clearFar( locs )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
locslen = length(locs);
locsdiff = diff(locs);

highbound = 154;
lowbound = 54;

insert = [];
for i = 1:locslen - 1
    if locsdiff(i) > highbound
        if i - 1 <= locslen - 1 - i
            flag = 0;
            twoD = i - 1;
        else
            flag = 1;
            twoD = locslen - 1 - i;
        end
        
        inter = 0;
        if twoD ~= 0
            for x = 1:twoD
                if locsdiff(i - x) < highbound
                    inter = locsdiff(i - x);
                    break;
                elseif locsdiff(i + x) < highbound
                    inter = locsdiff(i + x);
                    break;
                end
            end
        else
            x = 0 ;
        end
        x = x + 1;
        
        if inter == 0
            if flag == 0
                while locsdiff(i+x) > highbound
                    x = x  + 1;
                    if i+x > locslen - 1;
                        error('no diff satisfy');
                    end
                end
                inter = locsdiff(i+x);
            else
                while  locsdiff(i -x) > highbound
                    x = x + 1;
                end
                inter = locsdiff(i -x);
            end
        end
        
        interNo = round((locs(i+1) - locs(i))/inter);
        insert = [insert;i,interNo];
    end
end

insertsize = size(insert);

for i = insertsize(1):-1:1
    head = locs(1:insert(i,1));
    tail = locs((insert(i,1)+1):end);
    peice = round( ( locs((insert(i,1)+1)) -  locs(insert(i,1)) ) / insert(i,2) );
    middle = [1:(insert(i,2) - 1)] * peice + locs(insert(i,1));
    locs = [head,middle,tail];
end

output_args = locs;
end
    

