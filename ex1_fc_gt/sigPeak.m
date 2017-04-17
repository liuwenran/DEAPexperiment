function [ output_args ] = sigPeak( signal, monolen ,cutlen )
%SIGPEAK Summary of this function goes here
%   Detailed explanation goes here
siglen = length(signal);
% monolen = 15;
% cutlen = 5;
[sigup, sigdown] = sigMonotone(signal, monolen, cutlen);

oneMono  = zeros(1,length(signal));

for i = 1:length(oneMono)
    if sigup(i) ==1 && sigdown(i) == 0
        oneMono(i) = 1;
    elseif sigup(i) == 0 && sigdown(i) == 1
        oneMono(i) = -1;
    end
end


% uplocs = find(oneMono == 1);
% downlocs = find(oneMono == -1);
% flatlocs = find(oneMono == 0);
% 
% figure;
% plot(uplocs,signal(uplocs),'r.');
% hold on;
% plot(downlocs,signal(downlocs),'g.');
% plot(flatlocs,signal(flatlocs),'b.');

lflag = 0;
rflag = 0;
locs = [];
for i = 2:siglen
    if oneMono(i) == 0 && oneMono(i-1) == 1
        lflag = i;
    end
    if oneMono(i) == -1 && oneMono(i-1) == 0
        if lflag ~= 0
            rflag = i - 1;
        end
    end
    
    if lflag ~= 0 && rflag~=0
        if rflag - lflag > 100
            warning('rflag - lflag > 100');
            lflag = 0;
            rflag = 0;
            continue;
        end
        if lflag > 8
            cutl = lflag - 8;
        else
            cutl = 1;
        end
        if rflag < siglen - 8
            cutr = rflag + 8;
        else
            cutr = siglen;
        end
        
        [y, cutmaxlocs] = max(signal(cutl:cutr));
        locs = [locs,cutl - 1 + cutmaxlocs];
        lflag = 0;
        rflag = 0;
    end
    
    output_args = locs;
    
end

