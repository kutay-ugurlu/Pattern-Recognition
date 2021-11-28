%% HW3_Q1
load fisheriris
inds = ~strcmp(species,'virginica');

features = 1:4;
all_feature_pairs = nchoosek(features,2);
counter = zeros(size(all_feature_pairs,1),1);

for i = 1:size(all_feature_pairs,1)
    temp_features = all_feature_pairs(i,:);
    X = meas(inds,temp_features);
    y = species(inds);
    setosa_idx = strcmp(y,'setosa');
    versicolor_idx = strcmp(y,'versicolor');
    SVMModel = fitcsvm(X,y);
    % n_support_vectors = sum(SVMModel.IsSupportVector);
    n_support_vectors = size(SVMModel.SupportVectors,1);
    idx = SVMModel.IsSupportVector;
    figure
    scatter(X(setosa_idx,1),X(setosa_idx,2),'bo')
    hold on 
    scatter(X(versicolor_idx,1),X(versicolor_idx,2),'ro')
    hold on 
    scatter(X(idx,1),X(idx,2),'kx')
    title({['Features: ',mat2str(temp_features)],[num2str(n_support_vectors),' support vectors']})
    counter(i) = n_support_vectors;
    legend('Setosa','Versicolor','Support Vectors')
end

min_support_vectors = min(counter);
min_SV_features = all_feature_pairs(find(counter == min_support_vectors),:);


%% Save all 
chdir('..')
addpath('export_fig')
chdir('HW3')
figHandles = findall(0,'Type','figure'); 

for i = 1:numel(figHandles)
    export_fig(['Q1_',num2str(i)], '-png', figHandles(i), '-append')
end

close all