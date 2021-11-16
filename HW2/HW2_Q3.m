m = 250;
sigma = [1.4 0.2;0.2 0.8];
mu_1 = [-1;-1];
X1 = mvnrnd(mu_1,sigma,m);
mu_2 = [1;1];
X2 = mvnrnd(mu_2,sigma,m);
edgealpha = 0.5; 
%% Decision boundary 
% Since class priors are equal 
figure 
subplot(2,2,1)
x0 = 0.5 * (mu_1+mu_2); % = 0 
A = (mu_1-mu_2)'*(inv(sigma))'; % =  -1.1111   -2.2222
% Then decision boundary -> -x1-2x2 = 0 -> x1 = -2x2
scatter(X1(:,1),X1(:,2),'red','MarkerEdgeAlpha',edgealpha)
hold on 
scatter(X2(:,1),X2(:,2),'blue','MarkerEdgeAlpha',edgealpha)
hold on 
x = linspace(-5,5,100);
plot(x,-2*x)
ylabel('Train')
xlim([-10,10])
ylim([-10,10])
conf_mat_1 = zeros(2,2);

for i = 1:m
    x = X1(i,:);
    eval_at_line = A * transpose(x);
    if eval_at_line > 0 
        conf_mat_1(1,1) = conf_mat_1(1,1) + 1;
    else
        conf_mat_1(2,1) = conf_mat_1(2,1) + 1;
    end
    
    x = X2(i,:);
    eval_at_line = A * transpose(x);
    if eval_at_line > 0 
        conf_mat_1(2,2) = conf_mat_1(1,2) + 1;
    else
        conf_mat_1(1,2) = conf_mat_1(2,2) + 1;
    end
end
error_rate_1 = (conf_mat_1(1,2) + conf_mat_1(2,1)) / (2*m);

title({'Known Parameters',['Error rate is ',num2str(error_rate_1)]})

%% ML Estimation 
subplot(2,2,2)
[mu_1_hat,Sigma_1_hat] = estimate_ML(X1);
[mu_2_hat,Sigma_2_hat] = estimate_ML(X2);
Sigma = 0.5 * (Sigma_1_hat+Sigma_2_hat);
x0 = 0.5 * (mu_1_hat+mu_2_hat); % = 0 
A_ML = (mu_1_hat-mu_2_hat)'*(inv(Sigma))'; % 
syms f(x);
scatter(X1(:,1),X1(:,2),'red','MarkerEdgeAlpha',edgealpha)
hold on 
scatter(X2(:,1),X2(:,2),'blue','MarkerEdgeAlpha',edgealpha)
hold on 
f(x) = x0(2) - A_ML(1)/A_ML(2) * (x-x0(1));
fplot(f(x))
xlim([-10,10])
ylim([-10,10])

conf_mat_2 = zeros(2,2);

for i = 1:m
    x = X1(i,:);
    eval_at_line = A * transpose(x);
    if eval_at_line > 0 
        conf_mat_2(1,1) = conf_mat_2(1,1) + 1;
    else
        conf_mat_2(2,1) = conf_mat_2(2,1) + 1;
    end
    
    x = X2(i,:);
    eval_at_line = A * transpose(x);
    if eval_at_line > 0 
        conf_mat_2(2,2) = conf_mat_2(1,2) + 1;
    else
        conf_mat_2(1,2) = conf_mat_2(2,2) + 1;
    end
end
error_rate_2 = (conf_mat_2(1,2) + conf_mat_2(2,1)) / (2*m);
title({'Estimated Parameters',['Error rate is ',num2str(error_rate_2)]})


%% Test Data

X1 = mvnrnd(mu_1,sigma,m);
X2 = mvnrnd(mu_2,sigma,m);

%% Test Data Known 
subplot(2,2,3)

x0 = 0.5 * (mu_1+mu_2); % = 0 
A = (mu_1-mu_2)'*(inv(sigma))'; % =  -1.1111   -2.2222
% Then decision boundary -> -x1-2x2 = 0 -> x1 = -2x2
scatter(X1(:,1),X1(:,2),'red','MarkerEdgeAlpha',edgealpha)
hold on 
scatter(X2(:,1),X2(:,2),'blue','MarkerEdgeAlpha',edgealpha)
hold on 
x = linspace(-5,5,100);
plot(x,-2*x)
ylabel('Test')
xlim([-10,10])
ylim([-10,10])
conf_mat_1 = zeros(2,2);

for i = 1:m
    x = X1(i,:);
    eval_at_line = A * transpose(x);
    if eval_at_line > 0 
        conf_mat_1(1,1) = conf_mat_1(1,1) + 1;
    else
        conf_mat_1(2,1) = conf_mat_1(2,1) + 1;
    end
    
    x = X2(i,:);
    eval_at_line = A * transpose(x);
    if eval_at_line > 0 
        conf_mat_1(2,2) = conf_mat_1(1,2) + 1;
    else
        conf_mat_1(1,2) = conf_mat_1(2,2) + 1;
    end
end
error_rate_1 = (conf_mat_1(1,2) + conf_mat_1(2,1)) / (2*m);

title({'Known Parameters',['Error rate is ',num2str(error_rate_1)]})

%% ML Estimation Test data
subplot(2,2,4)
scatter(X1(:,1),X1(:,2),'red','MarkerEdgeAlpha',edgealpha)
hold on 
scatter(X2(:,1),X2(:,2),'blue','MarkerEdgeAlpha',edgealpha)
hold on 
syms f(x)
f(x) = x0(2) - A_ML(1)/A_ML(2) * (x-x0(1));
fplot(f(x))
xlim([-10,10])
ylim([-10,10])

conf_mat_2 = zeros(2,2);

for i = 1:m
    x = X1(i,:);
    eval_at_line = A_ML * transpose(x);
    if eval_at_line > 0 
        conf_mat_2(1,1) = conf_mat_2(1,1) + 1;
    else
        conf_mat_2(2,1) = conf_mat_2(2,1) + 1;
    end
    
    x = X2(i,:);
    eval_at_line = A_ML * transpose(x);
    if eval_at_line > 0 
        conf_mat_2(2,2) = conf_mat_2(1,2) + 1;
    else
        conf_mat_2(1,2) = conf_mat_2(2,2) + 1;
    end
end
error_rate_2 = (conf_mat_2(1,2) + conf_mat_2(2,1)) / (2*m);
title({'Estimated Parameters',['Error rate is ',num2str(error_rate_2)]})


