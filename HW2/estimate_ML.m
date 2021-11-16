function [mu_hat, sigma_hat] = estimate_ML(X)
% ML Estimator for Gaussian helper function
mu_hat = mean(X)';
sum = zeros(size(X,2),size(X,2));
m = size(X,1);
for i = 1:m
    sum = sum + (X(i,:)-mu_hat)'*(X(i,:)-mu_hat);
end
sigma_hat = sum/m; 
end
