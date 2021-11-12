%% Q1 
sigma_1 = [0.5 0.3;0.3 0.8];
mu_1 = [-0.75;0.75];
X = mvnrnd(mu_1,sigma_1,10000000);
mu_1_hat = mean(X);

A = 2*sum(X-mu_1_hat);

