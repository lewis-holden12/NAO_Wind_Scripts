% for 99.5th pctile winds

oct_r_decadal = [-0.19635	0.2484	0.371206667	0.39516	0.12482	0.419608333	0.383653846];
nov_r_decadal = [0.4386	-0.091652941	0.140511765	0.515776471	0.366976471	0.091993333	0.195435714];
dec_r_decadal = [0.536 0.237 0.44 0.366 0.405 0.53 0.55];
jan_r_decadal = [0.0444	0.624782353	0.556088235	0.644452941	0.450352941	0.29154	0.566707143];
feb_r_decadal = [0.235466667	0.28881875	0.32245625	0.28119375	0.5882125	0.691235714	0.356128571];
mar_r_decadal = [0.436366667	0.300627778	0.4573	0.434166667	0.432772222	0.4798375	0.35262]

djfm_mean_r_decadale = [0.313058334	0.36280722	0.443961121	0.43145334	0.469084416	0.498153304	0.456363929] 
djfm_running_mean = [-0.1375 -1.302	-0.041	0.408	1.73	0.36 0.6811]
plot_years_2 = [1 2 3 4 5 6 7]

csvread box1.csv

figure(1)
boxplot(ans, plot_years_2)
ylabel('Mean December-March r-value During Period')
hold on
yyaxis right;
plot(plot_years_2, djfm_running_mean)
ylim([-4 4])
set(gca, 'fontsize', 12)
set(gca, 'fontweight', 'bold')
set(gca, 'XTick', plot_years_2, 'XTickLabel',{'Pre-57' '57-66' '67-76' '77-86' '87-96' '97-06' '07-15'})
ylabel('Mean DJFM NAO Index During Period')
title('>99.5th Percentile')

figure(2)
scatter(djfm_running_mean, djfm_mean_r_decadale, 'k', 'filled')
ylim([0.2 0.6])
xlabel('Mean DJFM NAO Index During Period')
ylabel('Mean December-March r-value During Period')
set(gca, 'fontsize', 12)
set(gca, 'fontweight', 'bold')
title('>99.5th Percentile')

hold on
myfit = polyfit(djfm_running_mean, djfm_mean_r_decadale, 1);
y=myfit(1)*djfm_running_mean+myfit(2)
plot(djfm_running_mean, y, 'k')


[r,p] = corrcoef(djfm_mean_r_decadale, djfm_running_mean)


