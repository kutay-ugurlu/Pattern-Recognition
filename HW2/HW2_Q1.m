% Q1 
m = 1000; 
sigma_1 = [0.5 0.3;0.3 0.8];
mu_1 = [-0.75;0.5];
X = mvnrnd(mu_1,sigma_1,m);
mu_1_hat = mean(X);

sum = zeros(size(sigma_1));
for i = 1:m
    sum = sum + (X(i,:)-mu_1_hat)'*(X(i,:)-mu_1_hat);
end
sigma_1_hat = sum/m; 
mu_1_hat
sigma_1_hat