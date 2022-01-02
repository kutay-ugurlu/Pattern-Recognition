clc, clear;
load fisheriris.mat
feats = meas(:,3:4);
Y = species;
rng(101)

% Cross varidation (train: 50%, test: 50%)
cv = cvpartition(size(feats,1),'HoldOut',0.5);
idx = cv.test;

% Separate to training and test data
feats_Train = feats(~idx,:);
feats_Test = feats(idx,:);
Y_Train = Y(~idx);
Y_Test = Y(idx);

Mdl = TreeBagger(25,feats,Y,'OOBPrediction','On',...
    'Method','classification','SampleWithReplacement','on');


view(Mdl.Trees{1},'Mode','graph')
preds = predict(Mdl.Trees{1},feats_Test);
confusionmatrix = confusionmat(Y_Test,preds);
first_tree_accuracy = sum(diag(confusionmatrix))/sum(sum(confusionmatrix))
preds = predict(Mdl,feats_Test);
confusionmatrix = confusionmat(Y_Test,preds);
ensemble_tree_accuracy = sum(diag(confusionmatrix))/sum(sum(confusionmatrix))