% Part i - ML Estimate of mean 
n = 25;
sigma_sq = 0.49;
X = sqrt(sigma_sq) * randn(n,1) + 3;
mu_x_ML = mean(X);
% Part ii - MAP Estimate of mean 
mu_0 = 2.8;
sigma_0_sq = 0.8;
mu_n = n*sigma_0_sq/(n*sigma_0_sq+sigma_sq) * mean(X) + sigma_sq/(n*sigma_0_sq+sigma_sq) * mu_0;




