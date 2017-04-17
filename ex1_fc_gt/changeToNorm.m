file = '/net/liuwenran/datasets/DEAP/experiment/ex1_fc_gt/dataSigPeak1024_2/';
flist = dir(file);
matrix = [];
maxnum = 154;
minnum = 54;
for i = 3:length(flist)
    data = load([file,flist(i).name]);
    heartRate = data.heartPerson;
    matsize = size(heartRate);
    for j = 1:matsize(1)
        for k = 1:matsize(2)
            if isnan(heartRate(j,k))
                heartRate(j,k) = 0;
                continue;
            end
            if (heartRate(j,k) < minnum) || (heartRate(j,k) >= maxnum)
                heartRate(j,k) = 0;
                continue;
            end
            heartRate(j,k) = (heartRate(j,k) - minnum) / (maxnum -minnum);
        end
    end
    save(['GTHR_norm_sigPeak1024_2/',flist(i).name(1:3),'_norm.mat'],'heartRate');
end