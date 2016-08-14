%shuffle final exdata
clear all;
all_label = load('finalExData/HeartRate.mat');
all_signal = load('finalExData/signal.mat');
all_label = all_label.finalHR;
all_signal = all_signal.finalSignal;
num = length(all_label);
newperm = randperm(num);
finalHR = all_label(newperm);
finalSignal = all_signal(newperm,:);

save(['finalExData_shuffled/','signal.mat'],'finalSignal');
save(['finalExData_shuffled/','HeartRate.mat'],'finalHR');

heartrate = finalHR(1:40000);
signal = finalSignal(1:40000,:);
save('finalExData_shuffled/signal_train.mat','signal');
save('finalExData_shuffled/HeartRate_train.mat','heartrate');
heartrate = finalHR(40001:end);
signal = finalSignal(40001:end,:);
save('finalExData_shuffled/signal_test.mat','signal');
save('finalExData_shuffled/HeartRate_test.mat','heartrate');