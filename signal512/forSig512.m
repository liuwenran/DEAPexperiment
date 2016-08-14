%produce 4s PPG signal ,1s overlap,so 60s has 57 samples
sigPath = '/net/liuwenran/datasets/DEAP/experiment/ex1_fc_gt/GTsignal';
savePath = '/net/liuwenran/datasets/DEAP/experiment/signal512/sig512';
sigFlist = dir(sigPath);

for i = 3:length(sigFlist)
    load(fullfile(sigPath,sigFlist(i).name));
    exdata = [];
    for k = 1:40
        ct = 1;
        for j = 1:57
            startpt = 128 * 3 + (j - 1) * 128 + 1;
            stoppt = startpt - 1 + 128 * 4;
            data_ready = data(k,startpt:stoppt);
            exdata(k,ct,:) = data_ready;
            ct = ct + 1;
        end
    end
    save(fullfile(savePath,sigFlist(i).name),'exdata');
end