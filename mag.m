% load data (all annual CSVS's merged into one CSV) - DO NOT PRINT,
% 600,000x6 matrix

wind_data_initial = csvread('Aldergrove_CSVS.csv');

% add a minutes column

minutes = zeros([length(wind_data_initial) 1]);
wind_data_initial(:,7) = minutes;

% loop over and add in 0, 30, 20, 40, 12, 24, 36, 48, 15, 30, 45 where appropriate

for k = 2:length(wind_data_initial);
    if wind_data_initial(k,4) == wind_data_initial(k-1,4)+1;
        wind_data_initial(k,7) = 0;
    elseif wind_data_initial(k,4) == wind_data_initial(k-1,4) & wind_data_initial(k+1,4) == wind_data_initial(k,4)+3;
        wind_data_initial(k,7) = 30;
    elseif wind_data_initial(k,4) == wind_data_initial(k-1,4) & wind_data_initial(k+3,4) == wind_data_initial(k,4);
        wind_data_initial(k,7) =12;
    elseif wind_data_initial(k,4) == wind_data_initial(k-1,4) & wind_data_initial(k+1,4) == wind_data_initial(k,4) & wind_data_initial(k-1,7) == 12 ;
        wind_data_initial(k,7) = 24;
    elseif wind_data_initial(k,4) == wind_data_initial(k-1,4) & wind_data_initial(k+1,4) == wind_data_initial(k,4) & wind_data_initial(k-1,7) == 24 ;
        wind_data_initial(k,7) = 36;
    elseif wind_data_initial(k,4) == wind_data_initial(k-1,4) & wind_data_initial(k+1,4) == wind_data_initial(k,4) & wind_data_initial(k-1,7) == 36 ;
        wind_data_initial(k,7) = 48;
    elseif wind_data_initial(k,4) == wind_data_initial(k-1,4) & wind_data_initial(k+1,4) == wind_data_initial(k,4)+1 & wind_data_initial(k-1,7) == 48 ;
        wind_data_initial(k,7) = 0;
    elseif wind_data_initial(k,4) == wind_data_initial(k-1,4) & wind_data_initial(k+2,4) == wind_data_initial(k,4);
        wind_data_initial(k,7) =15;
    elseif wind_data_initial(k,4) == wind_data_initial(k-1,4) & wind_data_initial(k+1,4) == wind_data_initial(k,4) & wind_data_initial(k-1,7) == 15 ;
        wind_data_initial(k,7) = 30;
    elseif wind_data_initial(k,4) == wind_data_initial(k-1,4) & wind_data_initial(k+1,4) == wind_data_initial(k,4)+1 & wind_data_initial(k-1,7) == 30 ;
        wind_data_initial(k,7) = 45;
    elseif wind_data_initial(k,4) == wind_data_initial(k-1,4) & wind_data_initial(k+1,4) == wind_data_initial(k,4);
        wind_data_initial(k,7) = 20;    
    elseif wind_data_initial(k,4) == wind_data_initial(k-1,4) & wind_data_initial(k+1,4) == wind_data_initial(k,4)+1 & wind_data_initial(k-1,7) == 20 ;
        wind_data_initial(k,7) = 40;
    elseif wind_data_initial(k,4) == wind_data_initial(k-1,4) & wind_data_initial(k+1,4) == wind_data_initial(k,4)+1;
        wind_data_initial(k,7) = 30;
    elseif wind_data_initial(k,4) == 23 & wind_data_initial(k-1,4) == 23 & wind_data_initial(k-1,7) == 0;
        wind_data_initial(k,7) = 30;
    elseif wind_data_initial(k,4) == 23 & wind_data_initial(k-1,4) == 23 & wind_data_initial(k-1,7) == 20;
        wind_data_initial(k,7) = 40;
    elseif wind_data_initial(k,4) == wind_data_initial(k-1,4) & wind_data_initial(k+1,4) == wind_data_initial(k,4)+2 & wind_data_initial(k-1,7) == 0;
        wind_data_initial(k,7) = 30;     
    elseif wind_data_initial(k,4) == wind_data_initial(k-1,4) & wind_data_initial(k+1,4) == 0 & wind_data_initial(k-1,7) == 0 & wind_data_initial(k+1,3) == wind_data_initial(k,3)+1;
        wind_data_initial(k,7) = 30;     
    end
end

% convert to matdate using datenum

MAT_dates = datenum([wind_data_initial(:,1:4) wind_data_initial(:,7) zeros(length(wind_data_initial),1)]);

% add the wind dir and wind spd data to Aldergrove_wind_data_QC

wind_data_QC = [MAT_dates wind_data_initial(:,5) wind_data_initial(:,6)];

% define strength of wind searching for

gale_force_wind = prctile(wind_data_QC(:,3), 99.5);
   
% define no of years to study

years = 2016-1949;

% create two vectors of zeros to add the point at which Jan/Feb begins to

november = zeros([1, years]);
feburary = zeros([1, years]);
x = zeros([1, years]);
y = zeros([1, years]);
g = zeros([years, 2]);

% make two empty cells and one empty vector

mycell = cell(1,years);

S = cell(1,years);

H = zeros(1, years);

% add Jan 1st and Feb 1st to each value / find the indices of where each
% jan and feb begins / define g / make each value in mycell zero and each vector the same length as the
% number of samples for each january, this must be out of the main loop
% else it resets everything to zero

for k = 1:years;
    november(k) = datenum([1948+k 11 01 00 00 00]);
    feburary(k) = datenum([1949+k 02 01 00 00 00]);
    x(k) = find(wind_data_QC == november(1,k)); 
    y(k) = find(wind_data_QC == feburary(1,k));
    g(k,1) = x(k);
    g(k,2) = y(k);
    mycell{k} = zeros([1 length(S{k})]);
end

% for each year, the array in S should be the period which we wish to
% study, make an vector H where each value corresponds to the no of values
% per january, then loop through all the rows in the chosen time period and
% where >17.5ms-1 make the corresponding value in my cell = the period of
% time over which that value was taken

pct = zeros(1,67)
 
for k = 1:years;
    S{k} = wind_data_QC([g(k,1):g(k,2)],:);
    H(k) = length(S{k});
    for i = 1:length(H(k));
        if 
        pct(k) = prctile(S{k}(:,3), 99.5)
end

% plot

plot_years = [1949:2015];

plot(plot_years, pct)
hold on
yyaxis right
%plot(plot_years, ndj_nao(1:67,2), 'r')

% add nao timeseries

ndj_nao = csvread('NDJ_NAO.csv');

[rall, pall] = corrcoef(pct(1,1:67), ndj_nao(2:68,2))
[rpre85, ppre85] = corrcoef(pct(1, 1:37), ndj_nao(2:38,2))
[rpost85, ppost85] = corrcoef(pct(1, 38:67), ndj_nao(39:68,2))

rs = [rpre85(1,2) ppre85(1,2) rpost85(1,2) ppost85(1,2)]
