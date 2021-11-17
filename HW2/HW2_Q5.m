X = load('fisheriris');
features = X.meas;
classes = X.species;
X = features(:,[3 4]);
figure
scatter(X(:,1),X(:,2),'bo');
grid on;
maxlim = max(abs(X(:)))*1.1;
axis([-maxlim maxlim -maxlim maxlim]);

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
X1 = [X(:,1) Xfit1(:,1)];
X2 = [X(:,2) Xfit1(:,2)];
hold on
plot(X1(1:50,:)',X2(1:50,:)','g-', X(1:50,1),X(1:50,2),'ko');
hold on 
plot(X1(50:100,:)',X2(50:100,:)','r-', X(50:100,1),X(50:100,2),'ko');
hold on 
plot(X1(100:150,:)',X2(100:150,:)','b-', X(100:150,1),X(100:150,2),'ko');

L(1) = plot(nan, nan, 'k-');
L(2) = plot(nan, nan, 'g-');
L(3) = plot(nan, nan, 'r-');
L(4) = plot(nan, nan, 'b-');

legend_cell = cell(4,1);
legend_cell{1} = 'PCA Projection Line';
legend_cell{2} = 'setosa';
legend_cell{3} = 'versicolor';
legend_cell{4} = 'virginica';

legend(L,legend_cell,'Location','southeast');

hold off
maxlim = max(abs(X(:)))*1.1;
axis([0 8 -0.5 3]);
axis square
grid on
setosa = Xfit1(1:50,2);
versicolor = Xfit1(50:100,2);
virginica = Xfit1(100:150,2);
figure
histogram(setosa)
hold on 
histogram(versicolor)
hold on 
histogram(virginica)
legend('setosa','versicolor','virginica')