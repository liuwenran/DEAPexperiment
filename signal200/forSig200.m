%produce 4s PPG signal ,1s overlap,so 60s has 57 samples
sigPath = '/net/liuwenran/datasets/DEAP/experiment/signal512/sig512';
savePath = '/net/liuwenran/datasets/DEAP/experiment/signal200/sig200';
sigFlist = dir(sigPath);

for i = 3:length(sigFlist)
    oldData = load(fullfile(sigPath,sigFlist(i).name));
    oldData = oldData.exdata;
    tempData = oldData(:,:,1:2:end);
    tempData(:,:,4:4:224) = [];
    exdata = tempData;
    save(fullfile(savePath,sigFlist(i).name),'exdata');
end