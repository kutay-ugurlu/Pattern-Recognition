load fisheriris
X = meas(:,3:4);
setosa_idx = strcmp(species,"setosa");
versicolor_idx = strcmp(species,"versicolor");
virginica_idx = strcmp(species,"virginica");

SETOSA = X(setosa_idx,:);
VERSICOLOR = X(versicolor_idx,:);
VIRGINICA = X(virginica_idx,:);

figure;
plot(SETOSA(:,1),SETOSA(:,2),'k*','MarkerSize',5);
hold on 
plot(VERSICOLOR(:,1),VERSICOLOR(:,2),'ko','MarkerSize',5);
hold on 
plot(VIRGINICA(:,1),VIRGINICA(:,2),'k+','MarkerSize',5);
title 'Fisher''s Iris Data';
xlabel 'Petal Lengths (cm)'; 
ylabel 'Petal Widths (cm)';

%% 

rng(1); % For reproducibility
[idx,C] = kmeans(X,3);
x1 = min(X(:,1)):0.01:max(X(:,1));
x2 = min(X(:,2)):0.01:max(X(:,2));
[x1G,x2G] = meshgrid(x1,x2);
XGrid = [x1G(:),x2G(:)]; % Defines a fine grid on the plot

%% Ground Truth vector 
gnd_truth = repelem([3;1;2],50,1);
confusion_matrix = confusionmat(gnd_truth,idx);
accuracy = sum(diag(confusion_matrix)) / size(X,1)


%%
C = [mean(VERSICOLOR);mean(VIRGINICA);mean(SETOSA)];
idx2Region = kmeans(XGrid,3,'MaxIter',1,'Start',C);
    % Assigns each node in the grid to the closest centroid
    
figure;
gscatter(XGrid(:,1),XGrid(:,2),idx2Region,...
    [0,0.75,0.75;0.75,0,0.75;0.75,0.75,0],'..');
hold on;
plot(X(setosa_idx,1),X(setosa_idx,2),'k*','MarkerSize',5);
hold on 
plot(X(versicolor_idx,1),X(versicolor_idx,2),'ko','MarkerSize',5);
hold on 
plot(X(virginica_idx,1),X(virginica_idx,2),'k+','MarkerSize',5);title 'Fisher''s Iris Data';
xlabel 'Petal Lengths (cm)';
ylabel 'Petal Widths (cm)'; 
legend('Region 1','Region 2','Region 3','Data','Location','SouthEast');
hold off;