%% HW2 Q2
%% All features 
load fisheriris
inds = ~strcmp(species,'virginica');
features = 1:4;
X = meas(inds,features);
Y = species(inds);
SVMModel = fitcsvm(X,Y,'Standardize',true,'KernelFunction','RBF',...
    'KernelScale','auto');

CVSVMModel = crossval(SVMModel,'Kfold',10,'Leaveout','off');
kfold_loss = kfoldLoss(CVSVMModel)

SVMModel = fitcsvm(X,Y,'Standardize',true,'KernelFunction','RBF',...
    'KernelScale','auto');

CVSVMModel_xval = crossval(SVMModel,'Leaveout','on');
leave_one_out_loss = kfoldLoss(CVSVMModel_xval)

%% Just 2nd Feature
inds = ~strcmp(species,'virginica');
features = 2;
X = meas(inds,features);
Y = species(inds);
SVMModel = fitcsvm(X,Y,'Standardize',true,'KernelFunction','RBF',...
    'KernelScale','auto');

CVSVMModel = crossval(SVMModel,'Kfold',10,'Leaveout','off');
kfold_loss = kfoldLoss(CVSVMModel)

SVMModel = fitcsvm(X,Y,'Standardize',true,'KernelFunction','RBF',...
    'KernelScale','auto');

CVSVMModel_xval = crossval(SVMModel,'Leaveout','on');
leave_one_out_loss = kfoldLoss(CVSVMModel_xval)
