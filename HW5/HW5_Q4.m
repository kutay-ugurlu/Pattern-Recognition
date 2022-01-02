load lawdata
rhohat = corr(lsat,gpa);

%%
rng default;  % For reproducibility
jackrho = jackknife(@corr,lsat,gpa);
meanrho = mean(jackrho);
yyaxis left
plot(lsat)
ylabel('LSAT')
hold on 
yyaxis right
plot(gpa)
h = ylabel('GPA','Rotation',270);
xlabel('Samples')
h.Position(1) = 16.5; % change horizontal position of ylabel
legend('LSAT,GPA')
n = length(lsat);
biasrho = round((n-1) * (meanrho-rhohat),4);
title({['Real Correlation: ',num2str(rhohat)],['Estimated Correlation: ',num2str(meanrho)]},['Jackknife Estimate Bias for CC_{LSAT-GPA}: ',num2str(biasrho)],'FontWeight','bold')



%%
rng default;  % For reproducibility
jackmed = jackknife(@median,lsat);
meanmed_lsat = mean(jackmed);
n = length(lsat);
bias_lsat_median = (n-1) * (meanmed_lsat-median(lsat))

jackmed = jackknife(@median,gpa);
meanmed_gpa = mean(jackmed);
n = length(gpa);
bias_gpa_median = (n-1) * (meanmed_gpa-median(gpa))

figure
yyaxis left
hp1 = plot(lsat);
ylabel('LSAT')
hold on 
yyaxis right
hp2 = plot(gpa);
legend([hp1,hp2],'LSAT','GPA')
xlabel('Samples')
h = ylabel('GPA','Rotation',270);
h.Position(1) = 16.5; % change horizontal position of ylabel

title({['Real medians: ',num2str(median(lsat)),' - ',num2str(median(gpa))],['Estimated medians: ',num2str(meanmed_lsat),' - ',num2str(meanmed_gpa)],['Jackknife Estimate Bias for LSAT & GPA: ',num2str(bias_lsat_median),' - ',num2str(bias_gpa_median)]})



figHandles = findall(0,'Type','figure'); 

for i = 1:numel(figHandles)
    export_fig(['Q4_',num2str(i)], '-png', figHandles(i), '-append')
end
close all