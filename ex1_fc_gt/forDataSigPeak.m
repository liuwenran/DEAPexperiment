%prepare data for ex1_fc_gt
clear all;
PPGfile = '/net/liuwenran/datasets/DEAP/experiment/ex1_fc_gt/GTsignal/';
flist = dir(PPGfile);

monolen = 14;
cutlen = 5;
coverlen = 15;


peopleNum = 22;
heartRate = [];
for i = 3:peopleNum+2
    disp([num2str(i-2),' in ',num2str(peopleNum)]);
    data = load([PPGfile,flist(i).name]);
    data = data.data;
    heartPerson = [];
    for j = 1:40
        dataVideo = data(j,:);
        locs = sigPeak(dataVideo,monolen,cutlen);
        locs = clearAdjcent(locs);
        locs = clearFar(locs);
        locs = bestMax(dataVideo, locs, coverlen);
        heartRate = [];
        for k = 1:57
            startpt = 128 * 3 + (k - 1) * 128 + 1;
            stoppt = startpt - 1 + 128 * 4;

            snip = [];
            for m = 1:length(locs)
                if locs(m) >= startpt && locs(m) <= stoppt
                    snip = [snip,locs(m)];
                end
                if locs(m) > stoppt
                    break;
                end
            end
            
            locsdiff = diff(snip);
            overidx = find(locsdiff>154);
            locsdiff(overidx) = [];
            belowidx = find(locsdiff<54);
            locsdiff(belowidx) = [];

            if isempty(locsdiff)
                diffmean = 0;
            else
                diffmean = mean(locsdiff);
            end

            heartRate = [heartRate,diffmean];
%             close all;
        end
        heartPerson = [heartPerson;heartRate];
    end
    save(['dataSigPeak/',flist(i).name(1:3),'_heartRate8s.mat'],'heartPerson');
end
% plot(data_ready);
% hold on;
% plot(locs,pks,'ro');
% plot(locs_tru,pks2,'b*');