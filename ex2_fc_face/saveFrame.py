#read avi and save every frame
import cv2
import os
from os import listdir
from os.path import isfile,join

allSavePath = '/net/liuwenran/datasets/DEAP/experiment/ex2_fc_face/data'
allVideoPath = '/net/liuwenran/datasets/DEAP/face_video'
#allVideoFlist = listdir(allVideoPath)
#allVideoFlist = ['s02', 's03', 's05', 's07', 's11', 's14']
allVideoFlist = [ 's20']
for i in allVideoFlist:
	personSavePath = join(allSavePath, i)
	if not os.path.exists(personSavePath):
		os.makedirs(personSavePath)
	personVideoPath = join(allVideoPath, i)
#	personVideoFlist = listdir(personVideoPath)
	if i == 's20':
		personVideoFlist = ['s20_trial07.avi', 's20_trial08.avi']

	for j in personVideoFlist:
		videoSavePath = join(personSavePath,j[0:len(j) - 4])
		if not os.path.exists(videoSavePath):
			os.makedirs(videoSavePath)
		videoPath = join(personVideoPath, j)
		capture = cv2.VideoCapture(videoPath)
		count = 0
		while(capture.isOpened()):
			flag, frame = capture.read()
			if flag:
				count = count + 1
				cv2.imwrite(videoSavePath + '_' + str(count) + '.png', frame)
				if count%100 == 0:
					print i + '/' + j + '/' + str(count)
			else:
				break

