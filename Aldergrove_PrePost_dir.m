% load data (all annual CSVS's merged into one CSV) - DO NOT PRINT,
% 600,000x6 matrix

wind_data_initial = csvread('Aldergrove_CSVs.csv');

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

MAT_dates = datenum([wind_data_initial(:,1:4) wind_data_initial(:,7) zeros(length(wind_data_initial),1)]);;

% add the wind dir and wind spd data to Aldergrove_wind_data_QC

wind_data_QC = [MAT_dates wind_data_initial(:,5) wind_data_initial(:,6)];

% define datenum hours and days etc.

one_year = datenum([1950 00 00 00 00 00]) - datenum([1949 00 00 00 00 00]);

one_month = datenum([1949 12 00 00 00 00]) - datenum([1949 11 00 00 00 00]);

one_day = datenum([1949 12 01 00 00 00]) - datenum([1949 12 00 00 00 00]);

one_hour = datenum([1949 12 00 01 00 00]) - datenum([1949 12 00 00 00 00]);

% define strength of wind searching for

percentile = prctile(wind_data_QC(:,3), 99.5);

gale_force_wind = percentile;

% define no of years to study

years = 2016-1949;

% create two vectors of zeros to add the point at which Jan/Feb begins to

januarys = zeros([1, years]);

feburarys = zeros([1, years]);

% create two vectors to add the location of jan start to

x = zeros([1, years]);

y = zeros([1, years]);

%define g = time period that you wish to study

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
    januarys(k) = datenum([1949+k 01 00 00 00 00]);
    feburarys(k) = datenum([1949+k 02 00 00 00 00]);
    x(k) = find(wind_data_QC == januarys(1,k), 1, 'first'); 
    y(k) = find(wind_data_QC == feburarys(1,k), 1, 'first');
    g(k,1) = x(k);
    g(k,2) = y(k);
    mycell{k} = zeros([1 length(S{k})]);
end

% for each year, the array in S should be the period which we wish to
% study, make an vector H where each value corresponds to the no of values
% per january, then loop through all the rows in the chosen time period and
% where >17.5ms-1 make the corresponding value in my cell = the period of
% time over which that value was taken
 
for k = 1:years;
    S{k} = wind_data_QC([g(k,1):g(k,2)],:);
    H(k) = length(S{k});
    for i = 2:H(k);
            if S{k}(i,3) >= gale_force_wind & S{k}(i,2) > 270 & S{k}(i,2) <= 360;
                mycell{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
    end
end

% sum up all the values of hours etc. in each vector in mycell, this is the
% total number of gale hours in January according to MATLAB time

for k = 1:years;
    total_matlab_hours(1,k) = sum(mycell{k});
end

% make a new vector where we will add the human hours to

actual_gale_hours = zeros(1,years);

% convert data from MATLAB hours to human hours

for k = 1:years;
    actual_gale_hours(k) = total_matlab_hours(1,k)/one_hour;
end

% find gale directions

gale_directions = nan(1,length(MAT_dates));

for k = 325071:652563;
    if wind_data_QC(k,3) >= gale_force_wind;
        gale_directions(k) = wind_data_QC(k,2);
    elseif wind_data_QC(k,3) < gale_force_wind;
        gale_directions(k) = nan;
    end
end

gale_directions(isnan(gale_directions))=[];

modal_gale_d = mode(gale_directions);
mean_gale_d = nanmean(gale_directions);
median_gale_d = nanmedian(gale_directions);

gale_ninety = NaN(1, 150000);
gale_oneeighty = NaN(1, 150000);
gale_twoseventy = NaN(1, 150000);
gale_threesixty = NaN(1, 150000);


for k = 1:length(gale_directions);
    if (gale_directions(1,k) <= 90);
        gale_ninety(1,k) = gale_directions(1,k);
    elseif (gale_directions(1,k) > 90 & gale_directions(1,k) <= 180);
        gale_oneeighty(1,k) = gale_directions(1,k);
    elseif (gale_directions(1,k) > 180 & gale_directions(1,k) <=270);
        gale_twoseventy(1,k) = gale_directions(1,k);
    elseif (gale_directions(1,k) > 270 &  gale_directions(1,k) <=360);
        gale_threesixty(1,k) = gale_directions(1,k);
    end
end

gale_ninety(isnan(gale_ninety))=[];
gale_oneeighty(isnan(gale_oneeighty))=[];
gale_twoseventy(isnan(gale_twoseventy))=[];
gale_threesixty(isnan(gale_threesixty))=[];

all_directions = length([gale_ninety, gale_oneeighty, gale_twoseventy, gale_threesixty]);

first_quad_percentage = (length(gale_ninety)/all_directions)*100;
second_quad_percentage = (length(gale_oneeighty)/all_directions)*100;
third_quad_percentage = (length(gale_twoseventy)/all_directions)*100;
fourth_quad_percentage = (length(gale_threesixty)/all_directions)*100;

percentages = [first_quad_percentage second_quad_percentage third_quad_percentage fourth_quad_percentage]
    
rose(gale_directions)
view(90, -90)