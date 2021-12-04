X = [0 1 2 3; 1 0 4 5; 2 4 0 6; 3 5 6 0];
y = squareform(X);

distances = ["hamming","euclidean","cityblock","correlation","cosine"];
figure
for distance = distances
    idx = find(distances == distance);
    subplot(2,3,idx)
    Z = linkage(X,'complete',distance);
    dendrogram(Z)
    title(distance)
end
subplot(2,3,6)
    Z = linkage(X,'complete');
    dendrogram(Z)
    title("default")
sgtitle('Distance Comparisons')
