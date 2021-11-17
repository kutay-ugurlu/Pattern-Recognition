
% First Gaussian
mu = [1 3];
sigma = [1 0.5; 0.5 2];
R = chol(sigma);
z = repmat(mu,100,1) + randn(100,2)*R;

% Second Gaussian
mu = [4 2];
sigma = [1 0.25; 0.25 2];
R = chol(sigma);
z2 = repmat(mu,100,1) + randn(100,2)*R;

x1range = -2:.1:7;
x2range = -2:.1:7;
[xx1, xx2] = meshgrid(x1range,x2range);
XGrid = [xx1(:) xx2(:)];

abs_d2_mahal = abs(mahal(XGrid,z) - mahal(XGrid,z2));

f1 = @(a,b) mahal([a b],z);
f2 = @(a,b) mahal([a b],z2);

scatter(z(:,1), z(:,2),'x')
hold on 
scatter(z2(:,1), z2(:,2),'x','r')
hold on 
scatter(XGrid(:,1),XGrid(:,2),200,abs_d2_mahal,'o','filled');
hold on
fcontour(f1,[-2 7 -2 7],'LineWidth',2,'LevelList',[1 3 5 7 10]);
hold on 
fcontour(f2,[-2 7 -2 7],'LineWidth',2,'LevelList',[1 3 5 7 10]);
hb = colorbar;
