%% Same features

load fisheriris
X = meas(:,1:2);
Y = species;

figure('Position',[250 250 600 400]);
gscatter(X(:,1),X(:,2),Y);
h = gca;
lims = [h.XLim h.YLim]; % Extract the x and y axis limits
title('{\bf Scatter Diagram of Iris Measurements 1^{st} and 2^{nd}}');
xlabel('Petal Length (cm)');
ylabel('Petal Width (cm)');
legend('Location','Northwest');

SVMModels = cell(3,1);
classes = unique(Y);
rng(1); % For reproducibility

for j = 1:numel(classes)
    indx = strcmp(Y,classes(j)); % Create binary classes for each classifier
    SVMModels{j} = fitcsvm(X,indx,'ClassNames',[false true],'Standardize',true,...
        'KernelFunction','rbf','BoxConstraint',1);
end

d = 0.02;
[x1Grid,x2Grid] = meshgrid(min(X(:,1)):d:max(X(:,1)),...
    min(X(:,2)):d:max(X(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];
N = size(xGrid,1);
Scores = zeros(N,numel(classes));

for j = 1:numel(classes)
    [~,score] = predict(SVMModels{j},xGrid);
    Scores(:,j) = score(:,2); % Second column contains positive-class scores
end

[~,maxScore] = max(Scores,[],2);

figure('Position',[250 250 600 400]);
h(1:3) = gscatter(xGrid(:,1),xGrid(:,2),maxScore,...
    [1 0 0; 0 1 0; 0 0 1]);
hold on
h(4:6) = gscatter(X(:,1),X(:,2),Y);

title('{\bf Iris Classification Regions for features 1 2}');
xlabel('Petal Length (cm)');
ylabel('Petal Width (cm)');

hold on 

colors = [0 1 1; 1 0 1; 0 0 0];
sizes = [15,60,150];
for j = 1:3
SVM_SV = X(SVMModels{j}.IsSupportVector,:);
h(j+6) = scatter(SVM_SV(:,1),SVM_SV(:,2),'CData',repmat(colors(j,:),size(SVM_SV,1),1),'SizeData',sizes(j)*ones(size(SVM_SV,1),1));
hold on 
end

legend(h,{'setosa region','versicolor region','virginica region',...
    'observed setosa','observed versicolor','observed virginica',...
    'SVs1','SVs2','SVs3'},...
    'Location','NorthwestOutside')

axis tight
hold on 

%% Other features

load fisheriris
X = meas(:,3:4);
Y = species;

figure('Position',[250 250 600 400]);
gscatter(X(:,1),X(:,2),Y);
h = gca;
lims = [h.XLim h.YLim]; % Extract the x and y axis limits
title('{\bf Scatter Diagram of Iris Measurements 3^{rd} and 4^{th}}');
xlabel('Petal Length (cm)');
ylabel('Petal Width (cm)');
legend('Location','Northwest');

SVMModels = cell(3,1);
classes = unique(Y);
rng(1); % For reproducibility

for j = 1:numel(classes)
    indx = strcmp(Y,classes(j)); % Create binary classes for each classifier
    SVMModels{j} = fitcsvm(X,indx,'ClassNames',[false true],'Standardize',true,...
        'KernelFunction','rbf','BoxConstraint',1);
end

d = 0.02;
[x1Grid,x2Grid] = meshgrid(min(X(:,1)):d:max(X(:,1)),...
    min(X(:,2)):d:max(X(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];
N = size(xGrid,1);
Scores = zeros(N,numel(classes));

for j = 1:numel(classes)
    [~,score] = predict(SVMModels{j},xGrid);
    Scores(:,j) = score(:,2); % Second column contains positive-class scores
end

[~,maxScore] = max(Scores,[],2);

figure('Position',[250 250 600 400]);

h(1:3) = gscatter(xGrid(:,1),xGrid(:,2),maxScore,...
    [1 0 0; 0 1 0; 0 0 1]);
hold on
h(4:6) = gscatter(X(:,1),X(:,2),Y);

title('{\bf Iris Classification Regions for features 3 4}');
xlabel('Petal Length (cm)');
ylabel('Petal Width (cm)');

colors = [0 1 1; 1 0 1; 0 0 0];
sizes = [15,60,150];
for j = 1:3
SVM_SV = X(SVMModels{j}.IsSupportVector,:);
h(j+6) = scatter(SVM_SV(:,1),SVM_SV(:,2),'CData',repmat(colors(j,:),size(SVM_SV,1),1),'SizeData',sizes(j)*ones(size(SVM_SV,1),1));
hold on 
end

legend(h,{'setosa region','versicolor region','virginica region',...
    'observed setosa','observed versicolor','observed virginica',...
    'SVs1','SVs2','SVs3'},...
    'Location','NorthwestOutside')

axis tight

%% Save all 
chdir('..')
addpath('export_fig')
chdir('HW3')
figHandles = findall(0,'Type','figure'); 

for i = 1:numel(figHandles)
    export_fig(['Q3_',num2str(i)], '-png', figHandles(i), '-append')
end

close all
