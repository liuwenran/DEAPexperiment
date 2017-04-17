function [ output_args ] = bestMax( signal, locs, cutlen)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
locslen = length(locs);
siglen = length(signal);

for i = 1:locslen
    startpt = 0;
    stoppt = 0;
    if locs(i) <= cutlen
        startpt = 1;
    else
        startpt = locs(i) - cutlen;
    end
    if locs(i) > siglen - cutlen
        stoppt = siglen;
    else
        stoppt = locs(i) + cutlen;
    end
    [y,ind] = max(signal(startpt:stoppt));
    locs(i) = startpt - 1 + ind;
end

output_args = locs;
end


