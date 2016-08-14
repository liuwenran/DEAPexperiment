% every 4s has its heartrate and 1s stride
secondSignalPath = '/net/liuwenran/datasets/DEAP/experiment/signal512/eachSecond';
secondSignalFlist = dir(secondSignalPath);
savePath = '/net/liuwenran/datasets/DEAP/experiment/signal512/full512';

for i = 3:length(secondSignalFlist)
	fullName = secondSignalFlist(i).name;
	load(fullfile(secondSignalPath,secondSignalFlist(i).name));
	matsize = size(heartRateSecond);
	newmat = zeros(matsize(1),57);
	for j = 1:matsize(1)
		for k = 1:57
            newmat(j, k) = sum(heartRateSecond(j,k:k+3))/4;
		end
	end
	newmatName = fullfile(savePath,fullName);
	heartRate512 = newmat;
	save(newmatName, 'heartRate512');
end


