%prepare data for ex1_fc_gt
clear all
PGfile = '/media/bbnc/_net/liuwenran/datasets/DEAP/data_preprocessed_matlab/';
flist = dir(PGfile);
peopleNum = 22;
threshold = 40;
heartRate = [];
for i = 3:peopleNum+2
    data = load([PGfile,flist(i).name]);
    data = data.data;
    heartPerson = [];
    for k = 1:40
        data1 = squeeze(data(k,39,:));
        heartRate = [];
        for j = 1:2:53
            startpt = 128 * 3 + (j - 1) * 128 + 1;
            stoppt = startpt - 1 + 128 * 8;
            data_ready = data1(startpt:stoppt);
            [pks,locs] = localMax(data_ready, threshold);
%             [pks,locs] = findpeaks(data_ready);
%             [pks2,locs2] = findpeaks(pks);
%             locs_tru = locs(locs2);
%             locs_diff = diff(locs_tru);
%             toolong = find(locs_diff >= 192);
%             locs_diff(toolong) = [];
%             tooshort = find(locs_diff <= 38.4);
%             locs_diff(tooshort) = [];
%             locsmean = mean(locs_diff);
            locs = locs(2:end-1);
            
%             figure;
%             plot(data_ready);
%             hold on;
%             pks = pks(2:end-1);
%             plot(locs,pks,'ro');
            
            locsdiff = diff(locs);
%             overidx = find(locsdiff>192);
%             locsdiff(overidx) = [];
            diffmean = mean(locsdiff);
            if isnan(diffmean)
                lwr = 1;
            end
            heartRate = [heartRate,diffmean];
%             close all;
        end
        heartPerson = [heartPerson;heartRate];
    end
    save(['data/',flist(i).name(1:3),'_heartRate8s.mat'],'heartPerson');
end
% plot(data_ready);
% hold on;
% plot(locs,pks,'ro');
% plot(locs_tru,pks2,'b*');