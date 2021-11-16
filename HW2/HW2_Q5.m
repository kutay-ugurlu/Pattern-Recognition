X = load('fisheriris');
features = X.meas;
classes = X.species;
X = features;
plot3(X(:,1),X(:,2),X(:,3),'bo');
grid on;
maxlim = max(abs(X(:)))*1.1;
axis([-maxlim maxlim -maxlim maxlim -maxlim maxlim]);
axis square
view(-9,12);

%% PCA 
[coeff,score,roots] = pca(X);
basis = coeff(:,1);
normal = coeff(:,2);
[n,p] = size(X);
meanX = mean(X,1);
Xfit = repmat(meanX,n,1) + score(:,1)*coeff(:,1)';
residuals = X - Xfit;

%% Visualize Line Fit 
dirVect = coeff(:,1);
Xfit1 = repmat(meanX,n,1) + score(:,1)*coeff(:,1)';
t = [min(score(:,1))-.2, max(score(:,1))+.2];
endpts = [meanX + t(1)*dirVect'; meanX + t(2)*dirVect'];
plot(endpts(:,1),endpts(:,2),'k-');
X1 = [X(:,1) Xfit1(:,1) nan*ones(n,1)];
X2 = [X(:,2) Xfit1(:,2) nan*ones(n,1)];
hold on
plot(X1',X2','b-', X(:,1),X(:,2),'bo');
hold off
maxlim = max(abs(X(:)))*1.1;
axis([-maxlim maxlim -maxlim maxlim -maxlim maxlim]);
axis square
view(-9,12);
grid on