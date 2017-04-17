sigPath = 'F:\DEAP\ex1_gt\pgsignal';
peopleNum = 22;
sigFlist = dir(sigPath);

person = 2 + 22;
signal = sigFlist(person).name;
signalPath = fullfile(sigPath,signal);

sig = load(signalPath);
sig = sig.data;

video = 3;
sigtest = sig(video,:);

monolen = 14;
cutlen = 5;
locs = sigPeak(sigtest,monolen,cutlen);
figure;
plot(sigtest);
hold on;
plot(locs,sigtest(locs),'ro');
title(['person ',num2str(person - 2),' video ',num2str(video),...
       ' monolen ',num2str(monolen),' cutlen ',num2str(cutlen)]);
set(gcf,'outerposition',get(0,'screensize'));


newlocs = clearAdjcent(locs);
figure;
plot(sigtest);
hold on;
plot(newlocs,sigtest(newlocs),'ro');
title(['person ',num2str(person - 2),' video ',num2str(video),...
       ' monolen ',num2str(monolen),' cutlen ',num2str(cutlen)]);
set(gcf,'outerposition',get(0,'screensize'));


bestlocs = clearFar(newlocs);
figure;
plot(sigtest);
hold on;
plot(bestlocs,sigtest(bestlocs),'ro');
title(['person ',num2str(person - 2),' video ',num2str(video),...
       ' monolen ',num2str(monolen),' cutlen ',num2str(cutlen)]);
set(gcf,'outerposition',get(0,'screensize'));

greatlocs = bestMax(sigtest, bestlocs, 15);
figure;
plot(sigtest);
hold on;
plot(greatlocs,sigtest(greatlocs),'ro');
title(['person ',num2str(person - 2),' video ',num2str(video),...
       ' monolen ',num2str(monolen),' cutlen ',num2str(cutlen)]);
set(gcf,'outerposition',get(0,'screensize'));


