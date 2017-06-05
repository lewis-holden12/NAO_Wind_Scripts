load Box_PrePost.csv

boxplot([Box_PrePost], 'labels' ,{'All Pr85', 'All P85', 'p > 0.05 Pr85', 'p > 0.05 P85', 'p < 0.05 Pr85', 'p < 0.05 P85'})
ylabel('r-value', 'fontsize', 14, 'fontweight', 'bold')
set(gca, 'fontsize', 14)
ylim([0 0.8])
title('Evolution of NAO-Wind Magnitude Coupling Pre and Post 1985')