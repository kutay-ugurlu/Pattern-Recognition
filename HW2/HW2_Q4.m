m = 50;
mu = [0 0];
Sigma = [0.25 0.3; 0.3 1];
x1 = -3:0.02:3;
x2 = -3:0.02:3;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];
y = mvnpdf(X,mu,Sigma);
y = reshape(y,length(x2),length(x1));
subplot(1,2,1)
surf(x1,x2,y,'EdgeColor','interp','EdgeAlpha',1)
title('Original Distribution')
xlabel('X1')
ylabel('X2')
zlabel('Multivariate PDF')

%% Parzen 
mu = [0 0];
Sigma = [0.25 0.3; 0.3 1];
n = 50; 
X_sampled = mvnrnd(mu, Sigma, n);
h = 1.55;
V = h/n;
pn = zeros(size(X,1),1);
Estimated_density = zeros(size(X,1),1);
for i = 1:size(X,1)
    x = X(i,:);
    sum = 0;
    for j = 1:n
        sum = sum + 1/V * parzen_win((x-X_sampled(j,:))/h);
    end
    pn = 1/n * sum;
    Estimated_density(i) = pn;
end
subplot(1,2,2)
Estimated_density = reshape(Estimated_density,length(x2),length(x1));
surf(x1,x2,Estimated_density,'EdgeColor','interp','EdgeAlpha',1)
title('Estimated Density')
xlabel('X1')
ylabel('X2')
zlabel('Estimated Multivariate PDF')

    


    
    
    
    
    

    
    