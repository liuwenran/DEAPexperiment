
clear all;
ExSignal = '/net/liuwenran/datasets/DEAP/experiment/signal512/sig512/';
ExHeartRate = '/net/liuwenran/datasets/DEAP/experiment/signal512/full512/';
signalflist = dir(ExSignal);
HRflist = dir(ExHeartRate);
peopleNum = 22;
count = 0;
finalSignal = [];
finalHR = [];
for i = 3:peopleNum+2
    signal = load([ExSignal,signalflist(i).name]);
    heartrate = load([ExHeartRate,HRflist(i).name]);
    signal = signal.exdata;
    heartrate = heartrate.heartRate512;
    matsize = size(signal);
    for j = 1:matsize(1)
        for k = 1:matsize(2)
            if heartrate(j,k) > 0
                count = count + 1;
                temp = squeeze(signal(j,k,:));
                temp = temp';
                tempmax = max(temp);
                tempmin = min(temp);
                temp = (temp - tempmin) / (tempmax - tempmin);
                finalSignal = [finalSignal;temp];
                finalHR = [finalHR;heartrate(j,k)];
            else
                error(['heartrate ',num2str(j),' , ',num2str(k),' < 0']);
            end
        end
    end
end

finalHR = floor(finalHR * 100);
count
save(['finalExData/','signal.mat'],'finalSignal');
save(['finalExData/','HeartRate.mat'],'finalHR');

heartrate = finalHR(1:40000);
signal = finalSignal(1:40000,:);
save('finalExData/signal_train.mat','signal');
save('finalExData/HeartRate_train.mat','heartrate');
heartrate = finalHR(40001:end);
signal = finalSignal(40001:end,:);
save('finalExData/signal_test.mat','signal');
save('finalExData/HeartRate_test.mat','heartrate');
