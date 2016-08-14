% make every 1024 signal has its heartRate
fullSignalPath = '/net/liuwenran/datasets/DEAP/experiment/signal512/full1024';
fullSignalFlist = dir(fullSignalPath);
savePath = '/net/liuwenran/datasets/DEAP/experiment/signal512/eachSecond';

for i = 3:length(fullSignalFlist)
	fullName = fullSignalFlist(i).name;
	load(fullfile(fullSignalPath,fullSignalFlist(i).name));
	matsize = size(heartRatefull);
	newmat = zeros(matsize(1),60);
	for j = 1:matsize(1)
		for k = 1:60
			if k <= 52
				newmat(j, k) = heartRatefull(j, ceil(k/2));
			else
				newmat(j, k) = heartRatefull(j, 27);
			end
		end
	end
	newmatName = fullfile(savePath,fullName);
	heartRateSecond = newmat;
	save(newmatName, 'heartRateSecond');
end


