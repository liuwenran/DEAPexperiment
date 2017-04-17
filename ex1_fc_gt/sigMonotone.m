function [ sigup, sigdown] = sigMonotone( signal, monolen, cutlen )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
siglen = length(signal);
sigdiff = diff(signal);
ptMono = zeros(1,siglen);
for i = 1:siglen-2
    if sigdiff(i) >= 0 && sigdiff(i+1) >= 0
        ptMono(i+1) = 1;
    elseif sigdiff(i) >=0 && sigdiff(i+1) <= 0
        ptMono(i+1) = 2;
    elseif sigdiff(i) <= 0 && sigdiff(i+1) >= 0
        ptMono(i+1) = -2;
    elseif sigdiff(i) <= 0 && sigdiff(i+1) <= 0
        ptMono(i+1) = -1;
    end
end

ptMono(1) = ptMono(2);
ptMono(end) = ptMono(end-1);

sigup = zeros(1,siglen);
sigdown = zeros(1,siglen);
upsum = 0;
downsum = 0;
for i = 1:monolen
    if ptMono(i) == 1
        upsum = upsum + 1;
    end
    if ptMono(i) == -1
        downsum = downsum + 1;
    end
end
if upsum >= monolen - cutlen
    sigup(1:monolen) = 1;
end
if downsum >= monolen - cutlen
    sigdown(1:monolen) = 1;
end

for i = monolen + 1:siglen
    if ptMono(i) == 1
        upsum = upsum + 1;
    end
    if ptMono(i) == -1
        downsum = downsum + 1;
    end
    if ptMono(i - monolen) == 1
        upsum = upsum - 1;
    end
    if ptMono(i - monolen) == -1
        downsum = downsum - 1;
    end
    
    if upsum >= monolen - cutlen
        sigup(i-monolen+1:i) = 1;
    end
    if downsum >= monolen - cutlen
        sigdown(i-monolen+1:i) = 1;
    end
end

end

