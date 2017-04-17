clear all;
allFacePath = '/net/liuwenran/datasets/DEAP/experiment/ex2_fc_face/RoughFace';
allLabelPath = '/net/liuwenran/datasets/DEAP/experiment/ex1_fc_gt/GTHR_norm_sigPeak1024_2';
allFaceFlist = dir(allFacePath);
allLabelFlist = dir(allLabelPath);

correspondPath = '/net/liuwenran/datasets/DEAP/correspond.mat';
correspond = load(correspondPath);
correspond = correspond.correspond;
frameNum = 3000;

faceIm = cell(22*40*53,400);
label = zeros(22*40*53,1);
count = 0;
for i = 3:length(allFaceFlist)
        
    disp([num2str(i-2),' in person',num2str(length(allFaceFlist) - 2)]);
    
	personName = allFaceFlist(i).name;
	personFacePath = fullfile(allFacePath, personName);
	personFaceFlist = dir(personFacePath);
	
	personLabelName = fullfile(allLabelPath, [personName,'_norm.mat']);
	personLabel = load(personLabelName);
	field = fieldnames(personLabel);
	personLabel = personLabel.(field{1});

	personCorInd = find(correspond(:,1) == (i-2));
	personCor = correspond(personCorInd,:);

	for j = 3:length(personFaceFlist)
        
        disp([num2str(j-2),' in trial',num2str(length(personFaceFlist) - 2)]);
         
		videoName = personFaceFlist(j).name;
		videoPath = fullfile(personFacePath, videoName);
		videoNo = str2num(videoName(6:end));
		trialCorInd = find(personCor(:,2) == videoNo);
		trialCor = personCor(trialCorInd,3);

		for k = 1:53
			if personLabel(trialCor, k) > 0
                count = count + 1;
                oneSample = cell(1,400);
				startpt = (k - 1) * 50 + 1;
				stoppt = (k - 1 + 8) * 50;
                
                ct = 0;
				for m = startpt:stoppt
					frameName = [allFacePath,'/',personName,'/', ...
                                 videoName,'/',personName,'_',videoName,'_',num2str(m),'.png'];
                    ct = ct + 1;
					oneSample(1,ct) = {frameName};
				end
				faceIm(count,:) = oneSample;
				label(count,:) = personLabel(trialCor, k);
			end
		end
	end
end

faceImSize = size(faceIm);
faceIm = faceIm(1:count,:);
label = label(1:count,:);
faceImSize(1)
num = length(label)

newperm = randperm(num);
finalLabel = label(newperm);
finalIm = faceIm(newperm,:);

save(['finalExdata_shuffled/','faceIm.mat'],'finalIm');
save(['finalExdata_shuffled/','label.mat'],'finalLabel');

label = finalLabel(1:30000);
faceIm = finalIm(1:30000,:);
save('finalExdata_shuffled/faceIm_train.mat','faceIm');
save('finalExdata_shuffled/label_train.mat','label');
label = finalLabel(30001:end);
faceIm = finalIm(30001:end,:);
save('finalExdata_shuffled/faceIm_test.mat','faceIm');
save('finalExdata_shuffled/label_test.mat','label');





		


		



