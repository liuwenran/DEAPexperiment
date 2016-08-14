%save PPG signal only
PGfile = '/net/liuwenran/datasets/DEAP/data_preprocessed_matlab/';
flist = dir(PGfile);
peopleNum = 22;
for i = 3:peopleNum+2
    data = load([PGfile,flist(i).name]);
    data = data.data;
    data = data(:,39,:);
    data = squeeze(data);
    save(['GTsignal/',flist(i).name(1:3),'.mat'],'data');
end