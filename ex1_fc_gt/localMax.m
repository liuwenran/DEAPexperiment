function [ newpks, newlocs ] = localMax( signal ,threshold )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[pks,locs] = findpeaks(signal);
newlocs = [];
newpks = [];
flag = locs(1);
temp = flag;
temppk = pks(1);
for i = 2:length(locs)
    if (locs(i) - flag) < threshold
        temp = [temp,locs(i)];
        temppk = [temppk,pks(i)];
        flag  = locs(i);
        continue;
    end
    [maxtemp,maxidx] = max(temppk);
    newlocs = [newlocs,temp(maxidx)];
    newpks = [newpks,maxtemp];
    flag = locs(i);
    temp = flag;
    temppk = pks(i);
end
[maxtemp,maxidx] = max(temppk);
newlocs = [newlocs,temp(maxidx)];
newpks = [newpks,maxtemp];

    
end
            

