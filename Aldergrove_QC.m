
%-------------------------%re-check data---------------------------


% define variable g which is a logical vector of the row numbers where wind spe = 0

g_data_check = find((wind_data_QC(:,3)) == 0 & wind_data_QC(:,2) >= 1) ;

% chop wind dir and wind speed to size by deleting zero values from logical
% matrix

wind_data_QC(g_data_check,:) = [];

max_dir = max(wind_data_QC(:,2));

min_dir = min(wind_data_QC(:,2));

max_spd = max(wind_data_QC(:,3));

min_spd = min(wind_data_QC(:,3));