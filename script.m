file = csvread('annual_AMO_995th_hours_sum.csv');

years = file(1,1:58);
amo = file(2,1:58);
NE = file(3,1:58);
SE = file(4,1:58);
SW = file(5,1:58);
NW = file(6,1:58);
ndjf_2 = csvread('ndjf_annuals.csv');
ndjf = ndjf_2(9:66,2);


figure(1)
bar(years, NE, 'w', 'linewidth', 2)
set(gca, 'fontsize', 12)
set(gca, 'fontweight', 'bold')
xlim([1957 2016])
xlabel('Year')
ylabel('Annual Hours >99.5th Percentile Wind Speed - All Stations')
title('NE')

[r_amo_NE, p_amo_NE] = corrcoef(amo, NE)
[r_ndjf_NE, p_ndjf_NE] = corrcoef(ndjf, NE)

figure(2)
bar(years, SE, 'w','linewidth', 2)
set(gca, 'fontsize', 12)
set(gca, 'fontweight', 'bold')
xlim([1957 2016])
xlabel('Year')
ylabel('Annual Hours >99.5th Percentile Wind Speed - All Stations')
title('SE')

[r_amo_SE, p_amo_SE] = corrcoef(amo, SE)
[r_ndjf_SE, p_ndjf_SE] = corrcoef(ndjf, SE)

figure(3)
bar(years, SW, 'w','linewidth', 2)
set(gca, 'fontsize', 12)
xlim([1957 2016])
set(gca, 'fontweight', 'bold')
xlabel('Year')
ylabel('Annual Hours >99.5th Percentile Wind Speed - All Stations')
title('SW')

[r_amo_SW, p_amo_SW] = corrcoef(amo, SW)
[r_ndjf_SW, p_ndjf_SW] = corrcoef(ndjf, SW)

figure(4)
bar(years, NW, 'w','linewidth', 2)
set(gca, 'fontsize', 12)
set(gca, 'fontweight', 'bold')
xlim([1957 2016])
xlabel('Year')
ylabel('Annual Hours >99.5th Percentile Wind Speed - All Stations')
title('NW')

[r_amo_NW, p_amo_NW] = corrcoef(amo, NW)
[r_ndjf_NW, p_ndjf_NW] = corrcoef(ndjf, NW)

figure(5)
plot(years, amo, 'r', 'linewidth', 2)
set(gca, 'fontweight', 'bold')
set(gca, 'fontsize', 12)
ylabel('Mean Annual AMO Index')
xlabel('Year')
xlim([1957 2016])
hold on
yyaxis right
plot(years, ndjf, 'b', 'linewidth', 2)
legend('Show')
ylabel('Mean NDJF Index')
legend('AMO', 'NAO')
legend('Location', 'northwest')

