array1 = csvread('Plot_Sheet.csv');

%  = < 0.05

figure(1)
plot(array1(1,1:67), array1(3,1:67))
hold on
plot(array1(1,1:67), array1(4,1:67))
plot(array1(1,1:67), array1(6,1:67))
plot(array1(1,1:67), array1(7,1:67))
plot(array1(1,1:67), array1(11,1:67))
plot(array1(1,1:67), array1(12,1:67))
plot(array1(1,1:67), array1(13,1:67))
xlim([1956 2015])
ylim([20 60])
title('Magnitude of Annual DJF 99.5th Percentile Wind Speed - p < 0.05')
xlabel('Year', 'fontweight', 'bold')
ylabel('DJF 99.5th Percentile Wind Speed (ms^-^1)', 'fontweight', 'bold')
legend('Show')
legend('Belmullet', 'Dyce', 'Lerwick', 'Leuchars', 'Shawbury', 'Stornoway', 'Tiree')
set(gca, 'fontsize', 12)

%  = > 0.05

figure(2)
plot(array1(1,1:67), array1(5,1:67))
hold on
plot(array1(1,1:67), array1(15,1:67))
plot(array1(1,1:67), array1(14,1:67))
plot(array1(1,1:67), array1(10,1:67))
plot(array1(1,1:67), array1(9,1:67))
plot(array1(1,1:67), array1(8,1:67))
plot(array1(1,1:67), array1(2,1:67))
xlim([1949 2015])
title('Magnitude of Annual DJF 99.5th Percentile Wind Speed - p > 0.05')
xlabel('Year', 'fontweight', 'bold')
ylabel('DJF 99.5th Percentile Wind Speed (ms^-^1)', 'fontweight', 'bold')
legend('Show')
legend('Eskdale', 'Valley', 'Valentia', 'Ronaldsway', 'Plymouth', 'Malin Head', 'Aldergrove')
ylim([20 60])
set(gca, 'fontsize', 12)



nineteen57_nineteen86 = zeros(15,1);
nineteen86_twothousand15 = zeros(15,1);
means = zeros(15,1);

for k = 2:15;
        nineteen57_nineteen86(k,1) = mean(array1(k,9:38))
        nineteen86_twothousand15(k,2) = mean(array1(k,39:67))
        means(k) = mean(array1(k,9:67))
end


corrcoef(mean

