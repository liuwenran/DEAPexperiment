%shuffle final exdata
clear all;
all_label = load('../ex1_fc_gt/finalExData_shuffled/HeartRate.mat');
all_signal = load('../ex1_fc_gt/finalExData_shuffled/signal.mat');
all_label = all_label.finalHR;
all_signal = all_signal.finalSignal;

finalHR = all_label;
finalSignal = all_signal(:,1:512);

save(['finalExData_shuffled/','signal.mat'],'finalSignal');
save(['finalExData_shuffled/','HeartRate.mat'],'finalHR');

heartrate = finalHR(1:14000);
signal = finalSignal(1:14000,:);
save('finalExData_shuffled/signal_train.mat','signal');
save('finalExData_shuffled/HeartRate_train.mat','heartrate');
heartrate = finalHR(14001:end);
signal = finalSignal(14001:end,:);
save('finalExData_shuffled/signal_test.mat','signal');
save('finalExData_shuffled/HeartRate_test.mat','heartrate');