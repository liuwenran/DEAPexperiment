%turn original 1024 to 5 times 512
sigPath = '/net/liuwenran/datasets/DEAP/experiment/ex1_fc_gt/finalExData/signal.mat';
hrPath = '/net/liuwenran/datasets/DEAP/experiment/ex1_fc_gt/finalExData/HeartRate.mat';

sig = load(sigPath);
hr = load(hrPath);

sig = sig.finalSignal;
hr = hr.finalHR;

finalSignal = [];
finalHR = [];

count = length(hr);

num = 0;
for i = 1:count
    for j = 1:5
        startpt = (j - 1) * 128 + 1;
        stoppt = (j + 3) * 128;
        finalSignal = [finalSignal;sig(i,startpt:stoppt)];
        finalHR = [finalHR;hr(i)];
        num = num + 1;
    end
end

num
save('finalExData/HeartRate.mat','finalHR');
save('finalExData/signal.mat','finalSignal');



