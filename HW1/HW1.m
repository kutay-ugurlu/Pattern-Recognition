% test.m 

%% Part 3 
figure
suptitle({'Mahalanobis Distance Map'})
subplot(1,2,1)
% Grid
x1range = -10:.1:10;
x2range = -10:.1:10;
[xx1, xx2] = meshgrid(x1range,x2range);
XGrid = [xx1(:) xx2(:)];

% Gaussians
sigma1 = [3 .005;.005 5];
sigma2 = [2 .1;.1 .5];

X1 = mvnrnd([3;-3],sigma1,100);
X2 = mvnrnd([-3;3],sigma2,100);

f1 = @(x,y) abs(mahal([x y],X1));
f2 = @(x,y) abs(mahal([x y],X2));

abs_mahal_dist = abs(mahal(XGrid,X1) - mahal(XGrid,X2));

scatter(XGrid(:,1),XGrid(:,2),100,abs_mahal_dist,'filled')
caxis([0,250])
hold on 


fcontour(f1,[-10 10 -10 10],'LineWidth',2,'LineColor','red','LevelList',[1,3,5,7,9]);
hold on 
fcontour(f2,[-10 10 -10 10],'LineWidth',2,'LineColor','magenta','LevelList',[1,3,5,7,9]);
% caxis([0 100])
% abs_d2_mahal = abs(mahal(XGrid,X1) - mahal(XGrid,X2));
% scatter(XGrid(:,1),XGrid(:,2),[],abs_d2_mahal)

title({['{\Sigma}_1 = ',mat2str(sigma1)],['{\Sigma}_2 = ',mat2str(sigma2)]})

h = zeros(2, 1);
h(1) = plot(NaN,NaN,'-r');
h(2) = plot(NaN,NaN,'-magenta');
legend(h, 'X_1','X_2',['red','yellow']);

colorbar

subplot(1,2,2)

x1range = -10:.1:10;
x2range = -10:.1:10;
[xx1, xx2] = meshgrid(x1range,x2range);
XGrid = [xx1(:) xx2(:)];

% Gaussians
sigma1 = [1 0;0 1];
sigma2 = [1 0;0 1];

X1 = mvnrnd([3;-3],sigma1,100);
X2 = mvnrnd([-3;3],sigma2,100);

f1 = @(x,y) abs(mahal([x y],X1));
f2 = @(x,y) abs(mahal([x y],X2));

abs_mahal_dist = abs(mahal(XGrid,X1) - mahal(XGrid,X2));

scatter(XGrid(:,1),XGrid(:,2),100,abs_mahal_dist,'filled')
hold on 


fcontour(f1,[-10 10 -10 10],'LineWidth',2,'LineColor','red','LevelList',[1,3,5,7,9]);
hold on 
fcontour(f2,[-10 10 -10 10],'LineWidth',2,'LineColor','magenta','LevelList',[1,3,5,7,9]);
% caxis([0 100])
% abs_d2_mahal = abs(mahal(XGrid,X1) - mahal(XGrid,X2));
% scatter(XGrid(:,1),XGrid(:,2),[],abs_d2_mahal)

title({['{\Sigma}_1 = ',mat2str(sigma1)],['{\Sigma}_2 = ',mat2str(sigma2)]})

h = zeros(2, 1);
h(1) = plot(NaN,NaN,'-r');
h(2) = plot(NaN,NaN,'-magenta');
legend(h, 'X_1','X_2',['red','yellow']);

colorbar

