function [ output_args ] = clearAdjacent( locs )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
locslen = length(locs);
adjCouple = [];
isadj = zeros(1,locslen);
isdel = zeros(1,locslen);

highbound = 154;
lowbound = 54;

for i = 2:locslen
    if locs(i) - locs(i-1)  < lowbound
        adjCouple = [adjCouple;i-1,i];
        isadj(i-1) = 1;
        isadj(i) = 1;
    end
end

coupleSize = size(adjCouple);
coupleLen = coupleSize(1);

%将两个正常点中间的那两个点删掉一个
for i = coupleLen:-1:1
    ind1 = adjCouple(i,1);
    ind2 = adjCouple(i,2);
    if ind1 - 1 > 0 && isadj(ind1 - 1) == 0 && ind2  < locslen && isadj(ind2 + 1) == 0
        if locs(ind1) - locs(ind1-1) < highbound && locs(ind2+1) - locs(ind2) < highbound
            ind1int = abs(locs(ind1) - locs(ind1-1) - (locs(ind1+2) - locs(ind1)));
            ind2int = abs(locs(ind2) - locs(ind2-2) - (locs(ind2+1) - locs(ind2)));
            if ind1int < ind2int
                isdel(ind2) = 1;
            else
                isdel(ind1) = 1;
            end
            adjCouple(i,:) = [];
        end
    end
end

coupleSize = size(adjCouple);
coupleLen = coupleSize(1);

%删掉两个相邻点的后面那个
for i = 1:coupleLen
    isdel(adjCouple(i,2)) = 1;
end

delind = find(isdel == 1);
locs(delind) = [];

output_args = locs;
end

