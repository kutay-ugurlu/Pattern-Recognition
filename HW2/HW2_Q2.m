n = 10000;
disp('_______________')
% Part i - ML Estimate of mean 
sigma = sqrt(0.7);
X = sigma * randn(n,1) + 3;
mu_x_ML = mean(X)
% Part ii - MAP Estimate of mean 
mu_0 = 2.8;
sigma_0 = sqrt(0.8);
mu_n = n*sigma_0^2/(n*sigma_0^2+sigma^2) * mean(X) + sigma^2/(n*sigma_0^2+sigma^2) * mu_0


