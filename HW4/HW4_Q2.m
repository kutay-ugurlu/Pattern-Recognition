load fisheriris.mat
X = meas(:,3:4);
GMModel = fitgmdist(X,3);
figure
y = [zeros(50,1);ones(50,1);2*ones(50,1)];
h = gscatter(X(:,1),X(:,2),y);
hold on
gmPDF = @(x,y) arrayfun(@(x0,y0) pdf(GMModel,[x0 y0]),x,y);
g = gca;
fcontour(gmPDF,[g.XLim g.YLim])
title('{\bf Scatter Plot and Fitted Gaussian Mixture Contours}')
legend(h,'Model0','Model1','Model2')
hold off
