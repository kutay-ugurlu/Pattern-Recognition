%% 
chdir('..')
addpath('export_fig')
chdir('HW4')
%%
load fisheriris
X = meas(:,3:4);
gscatter(X(:,1),X(:,2),species);
dist_temp = pdist(X);
dist = squareform(dist_temp);
S = exp(-dist.^2);
k = 3; % Number of clusters
rng('default') % For reproducibility
mat = tabulate(species);
title({'Known distribution',['Clustering: ',mat2str(repmat([50,33.3],3,1),3)]})
%% Use similarity mat(:,2:end)rix
figure
idx = spectralcluster(S,k,'Distance','precomputed','LaplacianNormalization','symmetric');
gscatter(X(:,1),X(:,2),idx);
mat = tabulate(idx);
title({'Similarity Matrix',['Clustering: ',mat2str(mat(:,2:end),3)]})
%% Laplacian normalized 
figure
idx2 = spectralcluster(X,k,'NumNeighbors',size(X,1),'LaplacianNormalization','symmetric');
gscatter(X(:,1),X(:,2),idx2);
mat = tabulate(idx2);
title({'Normalized Laplacian',['Clustering: ',mat2str(mat(:,2:end),3)]})
%% Laplacian unnormalized
figure
idx2 = spectralcluster(X,k,'NumNeighbors',size(X,1),'LaplacianNormalization','none');
gscatter(X(:,1),X(:,2),idx2);
mat = tabulate(idx2);
title({'Unnormalized Laplacian',['Clustering: ',mat2str(mat(:,2:end),3)]})

%% Distance Euclidean 
figure
idx2 = spectralcluster(X,k,'NumNeighbors',size(X,1),'Distance','euclidean');
gscatter(X(:,1),X(:,2),idx2);
mat = tabulate(idx2);
title({'Euclidean Distance',['Clustering: ',mat2str(mat(:,2:end),3)]})
%% Distance mahalanobis
figure
idx2 = spectralcluster(X,k,'NumNeighbors',size(X,1),'Distance','mahalanobis');
gscatter(X(:,1),X(:,2),idx2);
mat = tabulate(idx2);
title({'Mahalanobis Distance',['Clustering: ',mat2str(mat(:,2:end),3)]})

%%
figHandles = findall(0,'Type','figure'); 

for i = 1:numel(figHandles)
    export_fig(['Q4_',num2str(i)], '-png', figHandles(i), '-append')
end
