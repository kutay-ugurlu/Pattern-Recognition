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

% To amplify the difference of the classification success, the number of
% splits are restricted for a single tree to also highlight the adaboost
% success 
t = templateTree('MaxNumSplits',1);
Mdl = fitcensemble(feats_Train,Y_Train,'Method','AdaBoostM2', ...
    'Learners',t,'NumLearningCycles',25);
view(Mdl.Trained{1},'Mode','graph')
preds = predict(Mdl.Trained{1},feats_Test);
confusionmatrix = confusionmat(Y_Test,preds);
first_tree_accuracy = sum(diag(confusionmatrix))/sum(sum(confusionmatrix))
preds = predict(Mdl,feats_Test);
confusionmatrix = confusionmat(Y_Test,preds);
ensemble_tree_accuracy = sum(diag(confusionmatrix))/sum(sum(confusionmatrix))



accs = [];
for lr = 10.^[-8:0]
    t = templateTree('MaxNumSplits',1);
    Mdl = fitcensemble(feats_Train,Y_Train,'Method','AdaBoostM2', ...
    'Learners',t,'NumLearningCycles',25, 'LearnRate',lr);
    preds = predict(Mdl,feats_Test);
    confusionmatrix = confusionmat(Y_Test,preds);
    model_accuracy = sum(diag(confusionmatrix))/sum(sum(confusionmatrix));
    accs(end+1) = model_accuracy;
end

figure
plot(-8:0,1-accs)
ylim([0 0.5])
title('Misclassification Rate vs Learning Rate')
ylabel('Misclassification Rate')
xlabel('Learning Rate Power')