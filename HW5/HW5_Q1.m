%% 
clear;  clc;
chdir('..')
addpath('export_fig')
chdir('HW5')
%%
load fisheriris.mat
feats = meas(:,3:4);
Y = species;
%%
tree_model = fitctree(feats,species,'CrossVal','on');
view(tree_model.Trained{1},'Mode','graph')
Ls = [];
for i = 1:10
    model = tree_model.Trained{1};
    preds = predict(model,feats);
    confusion_matrix = confusionmat(species,preds);
    accuracy = sum(diag(confusion_matrix))/sum(sum(confusion_matrix));
    loss = 1 - accuracy;
    Ls(end+1) = loss;
end
mean(Ls)

%%
tree_model = fitctree(feats,species,'CrossVal','on','MaxNumSplits',7);
view(tree_model.Trained{1},'Mode','graph')
Ls = [];
for i = 1:10
    model = tree_model.Trained{1};
    preds = predict(model,feats);
    confusion_matrix = confusionmat(species,preds);
    accuracy = sum(diag(confusion_matrix))/sum(sum(confusion_matrix));
    loss = 1 - accuracy;
    Ls(end+1) = loss;
end
mean(Ls)
%%
tree_model = fitctree(feats,species,'CrossVal','on','SplitCriterion','deviance');
view(tree_model.Trained{1},'Mode','graph')
Ls = [];
for i = 1:10
    model = tree_model.Trained{1};
    preds = predict(model,feats);
    confusion_matrix = confusionmat(species,preds);
    accuracy = sum(diag(confusion_matrix))/sum(sum(confusion_matrix));
    loss = 1 - accuracy;
    Ls(end+1) = loss;
end
mean(Ls)
%%
figHandles = findall(0,'Type','figure'); 

for i = 1:numel(figHandles)
    export_fig(['Q1_',num2str(i)], '-png', figHandles(i), '-append')
end

hTree=findall(0,'Tag','tree viewer'); close(hTree)
