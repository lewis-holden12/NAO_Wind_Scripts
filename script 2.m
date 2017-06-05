% % for 99.5th pctile winds
% 
% 
% ndjf = csvread('ndjf_annual.csv')
% plot_years = 1949:2015
% plot_years_2 = [1953 1962 1972 1982 1992 2002 2011]
% 
% oct_r_decadal = [-0.19635	0.2484	0.371206667	0.39516	0.12482	0.419608333	0.383653846]
% nov_r_decadal = [0.4386	-0.091652941	0.140511765	0.515776471	0.366976471	0.091993333	0.195435714]
% dec_r_decadal = [0.536 0.237 0.44 0.366 0.405 0.53 0.55]
% jan_r_decadal = [0.0444	0.624782353	0.556088235	0.644452941	0.450352941	0.29154	0.566707143]
% feb_r_decadal = [0.235466667	0.28881875	0.32245625	0.28119375	0.5882125	0.691235714	0.356128571]
mar_r_decadal = [0.436366667	0.300627778	0.4573	0.434166667	0.432772222	0.4798375	0.35262]

ndjf_mean_r_decadale = [0.313	0.363	0.4445	0.431	0.49	0.456] 
ndjf_running_mean = [-1.615555556	-0.187777778	0.691111111	2.216666667	0.36	0.36]
plot_years_2 = [1 2 3 4 5 6]

figure(1)
bar(plot_years_2, ndjf_mean_r_decadale)
set(gca, 'fontsize', 12)
set(gca, 'fontweight', 'bold')
set(gca, 'XTick', plot_years_2, 'XTickLabel',{'Pre-57' '57-66' '67-76' '77-86' '87-96' '97-06' '07-15'})
ylabel('Mean October-March r-value During Period')
title('99.5th Percentile')

figure(2)
scatter(ndjf_running_mean, ndjf_mean_r_decadale, 'k', 'filled')
ylim([0.2 0.6])
xlabel('Mean NDJF NAO Index During Period')
ylabel('Mean November-Feburary r-value During Period')
set(gca, 'fontsize', 12)
set(gca, 'fontweight', 'bold')
title('99.5th Percentile')

hold on
myfit = polyfit(ndjf_running_mean, ndjf_mean_r_decadale, 1);
y=myfit(1)*ndjf_running_mean+myfit(2)
plot(ndjf_running_mean, y, 'k')


[r,p] = corrcoef(ndjf_mean_r_decadale, ndjf_running_mean)


