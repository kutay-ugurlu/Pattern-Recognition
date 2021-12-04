X = [0 1 2 3; 1 0 4 5; 2 4 0 6; 3 5 6 0];
y = squareform(X);

distances = ["hamming","euclidean","chebychev","correlation",...
    "cosine","minkowski","spearman","mahalanobis"];
figure('units','normalized','outerposition',[0 0 1 1])
for distance = distances
    idx = find(distances == distance);
    subplot(2,4,idx)
    Z = linkage(X,'complete',distance);
    dendrogram(Z)
    title(distance)
end

