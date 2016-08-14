
clear all;
GTsignal = '/net/liuwenran/datasets/DEAP/experiment/ex1_fc_gt/GTsignal/';
flist = dir(GTsignal);
peopleNum = 22;
for i = 3:peopleNum+2
    data = load([GTsignal,flist(i).name]);
    data = data.data;
    exdata = [];
    for k = 1:40
        ct = 1;
        for j = 1:2:53
            startpt = 128 * 3 + (j - 1) * 128 + 1;
            stoppt = startpt - 1 + 128 * 8;
            data_ready = data(k,startpt:stoppt);
            exdata(k,ct,:) = data_ready;
            ct = ct + 1;
        end
    end
    save(['ExSignal/',flist(i).name(1:3),'_exdata.mat'],'exdata');
end
