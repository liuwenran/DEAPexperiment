function [ videoNo, frameNo ] = nameToNumber( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

stringlen = length(input_args);
for i = 1:stringlen
	if input_args(i) == 'l'
		flag1 = i + 1;
	end
	if input_args(i) == '_'&& i > 5
		flag2 = i - 1;
		flag3 = i + 1;
	end
	if input_args(i) == '.'
		flag4 = i - 1;
	end
end

videoNo = str2num(input_args(flag1:flag2));
frameNo = str2num(input_args(flag3:flag4));

end

