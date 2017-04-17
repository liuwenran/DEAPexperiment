
clear all;
ExSignal = '/net/liuwenran/datasets/DEAP/experiment/signal512/sig512/';
ExHeartRate = '/net/liuwenran/datasets/DEAP/experiment/ex1_fc_gt/GTHR_norm_sigPeak/';
signalflist = dir(ExSignal);
HRflist = dir(ExHeartRate);
peopleNum = 22;
count = 0;
zeroCount = 0;
finalSignal = zeros(22*40*57,512);
finalHR = zeros(22*40*57,1);
for i = 3:peopleNum+2
    disp([num2str(i-2),' in ',num2str(peopleNum)]);
    signal = load([ExSignal,signalflist(i).name]);
    heartrate = load([ExHeartRate,HRflist(i).name]);
    signal = signal.exdata;
    heartrate = heartrate.heartRate;
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
                finalSignal(count,:) = temp;
                finalHR(count,:) = heartrate(j,k);
            elseif heartrate(j,k) == 0
                zeroCount = zeroCount + 1;
            end
        end
    end
end

finalSignal = finalSignal(1:count,:);
finalHR = finalHR(1:count,:);
finalHR = floor(finalHR * 100);
count
zeroCount
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
