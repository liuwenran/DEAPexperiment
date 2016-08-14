%save rough face to roughFace
allFrameDir = 'data/';
allFrameFlist = dir(allFrameDir);

addpath('mex_functions/');
addpath('models/');

% % Load Models
fitting_model='models/Chehra_f1.0.mat';
load(fitting_model);   

faceDetector = vision.CascadeObjectDetector();



flagPath = 'RoughFaceFlag/';
facePath = 'RoughFace/';
pointPath = 'point/';


peopleNum = length(allFrameFlist);

for i = 3:peopleNum
    person = allFrameFlist(i).name;
    personFrameDir = [allFrameDir,person];
    personFrameFlist = dir(personFrameDir);
    
    beframe = zeros(40,3000);
	nobox = zeros(40,3000);
	trialBox = zeros(40,4);

    disp([num2str(i-2),' in ',num2str(peopleNum -2),' is ',person]);
    for j = 3:length(personFrameFlist)
       
        frameName = personFrameFlist(j).name;
        frameDir = fullfile(personFrameDir,frameName);
        
        if mod(j-2,100) == 0
            disp([num2str(j-2),' in ',num2str(length(personFrameFlist) -2),' is ',frameName]);
        end
        
        if frameName(end-2:end) ~= 'png'
            continue;
        end
        trialName = frameName(5:11);
        [videoNo, frameNo] = nameToNumber(frameName);
        beframe(videoNo,frameNo) = 1;
        im = imread(frameDir);
 		test_image=im2double(im);
        
        if videoNo == 8
            stop = 0;
        end

 		if (sum(trialBox(videoNo,:)) == 0)
%             shift = 10;
%             im_new = imread(fullfile(personFrameDir, personFrameFlist(j+shift).name));
%             test_image_new = im2double(im_new);
    		bbox = step(faceDetector, test_image);
            if ~isempty(bbox)
                boxsize = bbox(3) * bbox(4);
            end
    		if isempty(bbox) || numel(bbox) ~= 4 || boxsize < 20000
    			nobox(videoNo,frameNo) = 1;
    			beginF = 1;
                while (isempty(bbox))||(numel(bbox)~=4 || boxsize < 20000)
                	tframeName = personFrameFlist(j+beginF).name;
                	tframeDir = fullfile(personFrameDir, tframeName);
                	tim = imread(tframeDir);
                	ttest_image = im2double(tim); 
                	bbox = step(faceDetector, ttest_image);
                    if ~isempty(bbox)
                        boxsize = bbox(3) * bbox(4);
                    end
                	beginF = beginF + 1;
                	if beginF == 1000
                        bbox = trialBox(videoNo - 1,:);
%                 		error('you dare believe that there is no valid bbox in 1000 frame!!');
                	end
                end
            end
            trialBox(videoNo,:) = bbox;
        else
        	bbox = trialBox(videoNo,:);
        end
    	faceim = test_image(bbox(2):bbox(2)+bbox(4),bbox(1):bbox(1)+bbox(3),:);

    	if exist(fullfile(facePath,person,trialName)) == 0
    		mkdir(fullfile(facePath,person,trialName));
        end
        faceimPath = fullfile(facePath,person,trialName,frameName);
    	imwrite(faceim, faceimPath,'png');

    	test_init_shape = InitShape(bbox,refShape);
    	test_init_shape = reshape(test_init_shape,49,2);    
    	if size(test_image,3) == 3
        	test_input_image = im2double(rgb2gray(test_image));
    	else
        	test_input_image = im2double((test_image));
    	end
       
    	% % Maximum Number of Iterations 
    	% % 3 < MaxIter < 7
    	MaxIter=6;
    	points = Fitting(test_input_image,test_init_shape,RegMat,MaxIter);
        
        if exist(fullfile(pointPath,person,trialName)) == 0
    		mkdir(fullfile(pointPath,person,trialName));
        end
        points(:,1) = points(:,1) - bbox(1);
        points(:,2) = points(:,2) - bbox(2);
        pointsName = fullfile(pointPath,person,trialName,frameName);
    	pointsName = [pointsName(1:end-4),'.mat'];
    	save(pointsName, 'points');
    end
    if exist(fullfile(flagPath,person)) == 0
    	mkdir(fullfile(flagPath,person));
    end
    beframeName = [fullfile(flagPath,person),'/beframe.mat'];
    save(beframeName, 'beframe');
    noboxName = [fullfile(flagPath,person),'/nobox.mat'];
    save(noboxName, 'nobox');
    trialBoxName = [fullfile(flagPath,person),'/trialBox.mat'];
    save(trialBoxName, 'trialBox');
    rmdir(personFrameDir,'s');
end
