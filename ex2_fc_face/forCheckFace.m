%check if every box has its face
RoughFacePath = 'RoughFace/';
faceFlist = dir(RoughFacePath);
savePath = 'checkface/';


for i = 3:length(faceFlist)
	personName = faceFlist(i).name;
	trialPath = [RoughFacePath,personName];
	trialFlist = dir(trialPath);

	for j = 3:length(trialFlist);
		trialName = trialFlist(j).name;
		imPath = fullfile(trialPath,trialName);
		imFlist = dir(imPath);
		imname = imFlist(3).name;
		copyfile(fullfile(imPath,imname),fullfile(savePath,imname));
	end
end

		