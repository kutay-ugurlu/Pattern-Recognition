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
    SVMModel = fitcsvm(X,y);
    % n_support_vectors = sum(SVMModel.IsSupportVector);
    n_support_vectors = size(SVMModel.SupportVectors,1);
    counter(i) = n_support_vectors;
end

min_support_vectors = min(counter);
min_SV_features = all_feature_pairs(find(counter == min_support_vectors),:);
