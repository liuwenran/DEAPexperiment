% make every 1024 signal has its heartRate
originSignalPath = '/net/liuwenran/datasets/DEAP/experiment/ex1_fc_gt/GTHR_norm_peakfinder2';
originSignalFlist = dir(originSignalPath);
savePath = '/net/liuwenran/datasets/DEAP/experiment/signal512/full1024';

for i = 3:length(originSignalFlist)
	originName = originSignalFlist(i).name;
	load(fullfile(originSignalPath,originSignalFlist(i).name));
	matsize = size(heartRate);
	newmat = zeros(matsize);
	for j = 1:matsize(1)
        allzeroFlag = 0;
        
		for k = 1:matsize(2)
            
			if heartRate(j,k) ~= 0
				newmat(j,k) = heartRate(j,k);
			else
				if (k - 1) <= matsize(2) - k
					flag = 0;
					twoD = k - 1;
				else
					flag = 1;
					twoD = matsize(2) - k;
				end

				if twoD ~= 0
					for x = 1:twoD
						if heartRate(j, k - x) ~= 0
							newmat(j, k) = heartRate(j, k - x);
							break;
						elseif heartRate(j, k + x) ~= 0
							newmat(j, k) = heartRate(j, k + x);
							break;
						end
					end
				else
					x = 0;
				end
				
				x = x + 1;
                
				if newmat(j, k) == 0
					if flag == 0
						while heartRate(j, k + x) == 0
							x = x + 1;
                            if (k+x) > matsize(2)
                                allzeroFlag = 1;
                                break;
                            end
                        end
                        if allzeroFlag == 1
                            disp([originName,' ',num2str(j),' is empty!']);
                            newmat(j,:) = 0.66;
                            continue;
                        end
						newmat(j, k) = heartRate(j, k + x);
					else
						while heartRate(j, k - x) == 0
							x = x + 1;
						end
						newmat(j, k) = heartRate(j, k - x);
					end
				end
			end
        end
        
        if allzeroFlag == 1
            continue;
        end
	end
	newsize = size(newmat);
	for m = 1:newsize(1)
		for n = 1:newsize(2)
			if newmat(m, n) == 0 
				error('there should not be 0 in newmat');
			end
		end
	end
	newmatName = fullfile(savePath,originName);
	heartRatefull = newmat;
	save(newmatName, 'heartRatefull');
end


