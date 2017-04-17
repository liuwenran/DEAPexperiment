import os
import os.path as osp
import sys
import numpy as np
from os import listdir
from os.path import isfile,join
import scipy.io as sio
import h5py

allFacePath = '/net/liuwenran/datasets/DEAP/experiment/ex2_fc_face/RoughFace'
allLabelPath = '/net/liuwenran/datasets/DEAP/experiment/ex1_fc_gt/GTHR_norm_sigPeak1024_2'
allFaceFlist = listdir(allFacePath)
allLabelFlist = listdir(allLabelPath)

correspondPath = '/net/liuwenran/datasets/DEAP/correspond.mat'
correspondMat = sio.loadmat(correspondPath)
correspond = correspondMat['correspond']

faceIm = ['' for x in range(50000)]
peopleNote = ['' for x in range(50000)]
label = np.zeros(50000)
count = 0
for i, personName in enumerate(allFaceFlist):

    print str(i+1) + ' in ' + str(len(allFaceFlist)) + ' session'
    
    personFacePath = join(allFacePath, personName)
    personFaceFlist = listdir(personFacePath)
    
    personLabelName = join(allLabelPath, personName+'_norm.mat')
    personLabel = h5py.File(personLabelName)
    personLabel = personLabel[personLabel.keys()[0]]
    personLabel = np.transpose(np.array(personLabel))

    personNo = int(personName[1:3])
    personCorInd =  [x for x,a in enumerate(correspond[:,0]) if a==personNo]
    personCor = correspond[personCorInd,:]

    for j,videoName in enumerate(personFaceFlist):

        print str(j+1)+' in '+ str(len(personFaceFlist)) + ' trial'

        videoPath = join(personFacePath, videoName)
        videoNo = int(videoName[5:])

        trialCorInd = [x for x,a in enumerate(personCor[:,1]) if a == videoNo]
        trialCor = personCor[trialCorInd, 2]
        trialCor = trialCor - 1

        for k in range(53):
            if personLabel[trialCor, k] > 0:
                oneSample = ['' for x in range(400)]
                startpt = k * 50 + 1

                frameName = personName+'/'+videoName+'/'+personName+\
                            '_'+videoName+'_'+str(startpt)+'.png'
                
                faceIm[count] = frameName
                label[count] = personLabel[trialCor, k]
                peopleNote[count] = personName
                count = count + 1


faceIm = faceIm[:count]
label = label[:count]
# label = np.floor(label*100)
num = len(label)
num

# newperm = np.random.permutation(np.arange(num))
# finalLabel = [label[i] for i in newperm]
# finalIm = [faceIm[i] for i in newperm]
finalIm = faceIm
finalLabel = label

allfile = h5py.File('finalExData_shuffled/final_notperm.h5','w')
allfile.create_dataset('finalIm', data = finalIm)
allfile.create_dataset('finalLabel', data = finalLabel)
allfile.create_dataset('count',data = count)
allfile.close()

tempbegin = 35000
trainSize  = 35000
for i in range(tempbegin, count):
    if peopleNote[i] != peopleNote[i-1]:
        trainSize = i
        break

print 'trainSize is ' + str(trainSize) + ' personLast is ' + \
       peopleNote[trainSize - 1] + ' personNOTtrain is ' + \
       peopleNote[trainSize]

label = finalLabel[:trainSize]
faceIm = finalIm[:trainSize]
trainfile = h5py.File('finalExData_shuffled/train_float_notperm.h5','w')
trainfile.create_dataset('faceIm', data = faceIm)
trainfile.create_dataset('label', data = label)
trainfile.create_dataset('count',data = len(label))
trainfile.close()

label = finalLabel[trainSize:]
faceIm = finalIm[trainSize:]
testfile = h5py.File('finalExData_shuffled/test_float_notperm.h5','w')
testfile.create_dataset('faceIm', data = faceIm)
testfile.create_dataset('label', data = label)
testfile.create_dataset('count',data = len(label))
testfile.close()


