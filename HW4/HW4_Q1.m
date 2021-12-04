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
plot(VERSICOLOR(:,1),VERSICOLOR(:,2),'bo','MarkerSize',5);
hold on 
plot(VIRGINICA(:,1),VIRGINICA(:,2),'r+','MarkerSize',5);
title 'Fisher''s Iris Data';
xlabel 'Petal Lengths (cm)'; 
ylabel 'Petal Widths (cm)';
legend('Setosa','Versicolor','Virginica','Location','northwest')

%% 
% rng(1); % For reproducibility

Cs = {};
Cs{1} = [6 2  ; 1.5  0.3   ; 4 1];
Cs{2} = [5.2 2.5; 4.4 1.25; 3.8 5.5];
Cs{3} = [5   2.4; 4.6 1.45; 3.3 3.5];
Cs{4} = [4.5 2.1; 4.8 1.55; 3.2 3.2];
Cs{5} = [4.2 1.8; 5.2 1.78; 2.5 2.1];
Cs{6} = [4.1 1.4; 5.5 1.89; 1.8 1.05];
Cs{7} = [4   1  ; 6   2   ; 1.5 0.3];
gnd_truth = repelem([3;1;2],50,1);
accs = [];
CONFMATS = {};
for i = 1:7
[idx,C_new] = kmeans(X,3,'MaxIter',1,'Start',Cs{i});
confusion_matrix = confusionmat(gnd_truth,idx);
accuracy = sum(diag(confusion_matrix)) / size(X,1);
C_old = C_new;
accs(end+1) = accuracy;
CONFMATS{end+1} = confusion_matrix;
end
figure
plot(accs)
title({'\bf Accuracy vs Iterations'})
ylabel('Accuracy')
xlabel('kmeans iterations')
%%
x1 = min(X(:,1)):0.01:max(X(:,1));
x2 = min(X(:,2)):0.01:max(X(:,2));
[x1G,x2G] = meshgrid(x1,x2);
XGrid = [x1G(:),x2G(:)]; % Defines a fine grid on the plot

idx2Region = kmeans(XGrid,3,'MaxIter',1,'Start',C_new);
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