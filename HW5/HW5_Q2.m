load fisheriris.mat
feats = meas(:,3:4);
Y = species;
Mdl = fitcensemble(feats,Y,'Method','AdaBoostM2','Learners',25);
view(Mdl.Trained{1},'Mode','graph')
predMeanX = predict(Mdl,mean(feats))
