% read in wind data 

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

% define a vector of wind speeds wish to study, 50th pct, gale, storm and
% 99.5th pct

wind_speed = [prctile(wind_data_QC(:,3), 50) 17.5 24.5 prctile(wind_data_QC(:,3), 99.5)];

% % define no of years to study

years = 1985-1949;

% create two vectors of zeros to add the point at which Jan/Feb begins to

decembers = zeros([1, years]);

januarys = zeros([1, years]);

% create two vectors to add the location of dec start and jan start to

x = zeros([1, years]);

y = zeros([1, years]);

% define g = time periods that you wish to loop over (each december)

g = zeros([years, 2]);

% make  empty cells for different speeds

mycell_50p = cell(1,years);
mycell_gale = cell(1, years);
mycell_storm = cell (1, years);
mycell_99p = cell(1, years);

% make empty cells for different directions in 50p

mycell_50p_090 = cell(1,years);
mycell_50p_90180 = cell(1, years);
mycell_50p_180270 = cell (1, years);
mycell_50p_270360 = cell(1, years);

% make empty cells for different directions in gale

mycell_gale_090 = cell(1,years);
mycell_gale_90180 = cell(1, years);
mycell_gale_180270 = cell (1, years);
mycell_gale_270360 = cell(1, years);

% make empty cells for different directions in storm

mycell_storm_090 = cell(1,years);
mycell_storm_90180 = cell(1, years);
mycell_storm_180270 = cell (1, years);
mycell_storm_270360 = cell(1, years);

% make empty cells for different directions in 99.5p

mycell_99p_090 = cell(1,years);
mycell_99p_90180 = cell(1, years);
mycell_99p_180270 = cell (1, years);
mycell_99p_270360 = cell(1, years);

S = cell(1,years);

H = zeros(1, years);

% add Dec 1st and Jan 1st to each value / find the indices of where each
% Dec and Jan begins / define g / make each value in mycell zero and each vector the same length as the
% number of samples for each january, this must be out of the main loop
% else it resets everything to zero

for k = 1:years;
    decembers(k) = datenum([1948+k 12 01 00 00 00]);
    januarys(k) = datenum([1949+k 01 01 00 00 00]);
    x(k) = find(wind_data_QC == decembers(1,k)); 
    y(k) = find(wind_data_QC == januarys(1,k));
    g(k,1) = x(k);
    g(k,2) = y(k);
    mycell_50p{k} = zeros([1 length(S{k})]);
    mycell_gale{k} = zeros([1 length(S{k})]);
    mycell_storm{k} = zeros([1 length(S{k})]);
    mycell_99p{k} = zeros([1 length(S{k})]);
end

% for each year, the array in S should be the period which we wish to
% study, make an vector H where each value corresponds to the no of values
% per december, then loop through all the rows in the chosen time period and
% where >the given speed, make the corresponding value in my cell = the period of
% time over which that value was taken

% this for different speeds 


for k = 1:years;
    S{k} = wind_data_QC([g(k,1):g(k,2)],:);
    H(k) = length(S{k});
    for i = 2:H(k);
            if S{k}(i,3) > wind_speed(:,1);
                mycell_50p{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
            if S{k}(i,3) > wind_speed(:,2);
                mycell_gale{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
            if S{k}(i,3) > wind_speed(:,3);
                mycell_storm{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
            if S{k}(i,3) > wind_speed(:,4);
                mycell_99p{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
    end
end

% this for different directions in 50p
 
for k = 1:years;
    S{k} = wind_data_QC([g(k,1):g(k,2)],:);
    H(k) = length(S{k});
    for i = 2:H(k);
            if S{k}(i,3) > wind_speed(:,1) & S{k}(i,2) >= 0 & S{k}(i,2) <= 90;
                mycell_50p_090{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
            if S{k}(i,3) > wind_speed(:,1) & S{k}(i,2) > 90 & S{k}(i,2) <= 180;
                mycell_50p_90180{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
            if S{k}(i,3) > wind_speed(:,1) & S{k}(i,2) > 180 & S{k}(i,2) <= 270;
                mycell_50p_180270{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
            if S{k}(i,3) > wind_speed(:,1) & S{k}(i,2) > 270 & S{k}(i,2) <= 360;
                mycell_50p_270360{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
    end
end

% this for different directions in gale
 
for k = 1:years;
    S{k} = wind_data_QC([g(k,1):g(k,2)],:);
    H(k) = length(S{k});
    for i = 2:H(k);
            if S{k}(i,3) > wind_speed(:,2) & S{k}(i,2) >= 0 & S{k}(i,2) <= 90;
                mycell_gale_090{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
            if S{k}(i,3) > wind_speed(:,2) & S{k}(i,2) > 90 & S{k}(i,2) <= 180;
                mycell_gale_90180{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
            if S{k}(i,3) > wind_speed(:,2) & S{k}(i,2) > 180 & S{k}(i,2) <= 270;
                mycell_gale_180270{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
            if S{k}(i,3) > wind_speed(:,2) & S{k}(i,2) > 270 & S{k}(i,2) <= 360;
                mycell_gale_270360{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
    end
end


% this for different directions in storm
 
for k = 1:years;
    S{k} = wind_data_QC([g(k,1):g(k,2)],:);
    H(k) = length(S{k});
    for i = 2:H(k);
            if S{k}(i,3) > wind_speed(:,3) & S{k}(i,2) >= 0 & S{k}(i,2) <= 90;
                mycell_storm_090{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
            if S{k}(i,3) > wind_speed(:,3) & S{k}(i,2) > 90 & S{k}(i,2) <= 180;
                mycell_storm_90180{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
            if S{k}(i,3) > wind_speed(:,3) & S{k}(i,2) > 180 & S{k}(i,2) <= 270;
                mycell_storm_180270{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
            if S{k}(i,3) > wind_speed(:,3) & S{k}(i,2) > 270 & S{k}(i,2) <= 360;
                mycell_storm_270360{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
    end
end

% this for different directions in 99.5th pctile
 
for k = 1:years;
    S{k} = wind_data_QC([g(k,1):g(k,2)],:);
    H(k) = length(S{k});
    for i = 2:H(k);
            if S{k}(i,3) > wind_speed(:,4) & S{k}(i,2) >= 0 & S{k}(i,2) <= 90;
                mycell_99p_090{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
            if S{k}(i,3) > wind_speed(:,4) & S{k}(i,2) > 90 & S{k}(i,2) <= 180;
                mycell_99p_90180{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
            if S{k}(i,3) > wind_speed(:,4) & S{k}(i,2) > 180 & S{k}(i,2) <= 270;
                mycell_99p_180270{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
            if S{k}(i,3) > wind_speed(:,4) & S{k}(i,2) > 270 & S{k}(i,2) <= 360;
                mycell_99p_270360{k}(1,i) = S{k}(i,1) - S{k}(i-1,1);
            end
    end
end

% sum up all the values of hours etc. in mycell, this is the
% total number of wind hours in December under the given conditions according to MATLAB time

% for all directions

one_hour = datenum([1949 12 00 01 00 00]) - datenum([1949 12 00 00 00 00]);


for k = 1:years;
    fiftyp_hours(1,k) = sum(mycell_50p{k}/one_hour);
    gale_hours(1,k) = sum(mycell_gale{k}/one_hour);
    storm_hours(1,k) = sum(mycell_storm{k}/one_hour);
    ninetyninep_hours(1,k) = sum(mycell_99p{k}/one_hour);
end

% for 0-90 degress

for k = 1:years;
    fiftyp_090_hours(1,k) = sum(mycell_50p_090{k}/one_hour);
    gale_090_hours(1,k) = sum(mycell_gale_090{k}/one_hour);
    storm_090_hours(1,k) = sum(mycell_storm_090{k}/one_hour);
    ninentyninep_090_hours(1,k) = sum(mycell_99p_090{k}/one_hour);
end

% for 90-180 degress

for k = 1:years;
    fiftyp_90180_hours(1,k) = sum(mycell_50p_90180{k}/one_hour);
    gale_90180_hours(1,k) = sum(mycell_gale_90180{k}/one_hour);
    storm_90180_hours(1,k) = sum(mycell_storm_90180{k}/one_hour);
    ninetyninep_90180_hours(1,k) = sum(mycell_99p_90180{k}/one_hour);
end

% for 180-270 degress

for k = 1:years;
    fiftyp_180270_hours(1,k) = sum(mycell_50p_180270{k}/one_hour);
    gale_180270_hours(1,k) = sum(mycell_gale_180270{k}/one_hour);
    storm_180270_hours(1,k) = sum(mycell_storm_180270{k}/one_hour);
    ninetyninep_180270_hours(1,k) = sum(mycell_99p_180270{k}/one_hour);
end

% for 270-360 

for k = 1:years;
    fiftyp_270360_hours(1,k) = sum(mycell_50p_270360{k}/one_hour);
    gale_270360_hours(1,k) = sum(mycell_gale_270360{k}/one_hour);
    storm_270360_hours(1,k) = sum(mycell_storm_270360{k}/one_hour);
    ninetyninep_270360_hours(1,k) = sum(mycell_99p_270360{k}/one_hour);
end

% make a cell containing yearly data for all scenarios
% format
%1-4 = all dir, 50pct, storm, gale, 99.5th
%thereon each 4 = same as above for 0-90, 90-180 etc.

hourscell = cell(1,20);

hourscell{1,1} = fiftyp_hours;
hourscell{1,2} = gale_hours;
hourscell{1,3} = storm_hours;
hourscell{1,4} = ninetyninep_hours;  
hourscell{1,5} = fiftyp_090_hours;
hourscell{1,6} = gale_090_hours;
hourscell{1,7} = storm_090_hours;
hourscell{1,8} = ninentyninep_090_hours;
hourscell{1,9} = fiftyp_90180_hours;
hourscell{1,10} = gale_90180_hours;
hourscell{1,11} = storm_90180_hours;
hourscell{1,12} = ninetyninep_90180_hours;
hourscell{1,13} = fiftyp_180270_hours;
hourscell{1,14} = gale_180270_hours;
hourscell{1,15} = storm_180270_hours;
hourscell{1,16} = ninetyninep_180270_hours;
hourscell{1,17} = fiftyp_270360_hours;
hourscell{1,18} = gale_270360_hours;
hourscell{1,19} = storm_270360_hours;
hourscell{1,20} = ninetyninep_270360_hours;

% for october

oct_nao = csvread('Oct_NAO.csv');
oct_r_cell = cell(1,20);
oct_p_cell = cell(1,20);
oct_r = zeros(1,20);
oct_p = zeros(1,20);

for k = 1:20;
    [oct_r_cell{k}, oct_p_cell{k}] = corrcoef(hourscell{k}(1:36), oct_nao(1:36,2));
end

for k = 1:20;
    oct_r(k) = oct_r_cell{k}(1,2);
    oct_p(k) = oct_p_cell{k}(1,2);
end

% for november

nov_nao = csvread('Nov_NAO.csv');
nov_r_cell = cell(1,20);
nov_p_cell = cell(1,20);
nov_r = zeros(1,20);
nov_p = zeros(1,20);

for k = 1:20;
    [nov_r_cell{k}, nov_p_cell{k}] = corrcoef(hourscell{k}(1:36), nov_nao(1:36,2));
end

for k = 1:20;
    nov_r(k) = nov_r_cell{k}(1,2);
    nov_p(k) = nov_p_cell{k}(1,2);
end

% for december

dec_nao = csvread('Dec_NAO.csv');
dec_r_cell = cell(1,20);
dec_p_cell = cell(1,20);
dec_r = zeros(1,20);
dec_p = zeros(1,20);

for k = 1:20;
    [dec_r_cell{k}, dec_p_cell{k}] = corrcoef(hourscell{k}(1:36), dec_nao(1:36,2));
end

for k = 1:20;
    dec_r(k) = dec_r_cell{k}(1,2);
    dec_p(k) = dec_p_cell{k}(1,2);
end

% for january

jan_nao = csvread('Jan_NAO.csv');
jan_r_cell = cell(1,20);
jan_p_cell = cell(1,20);
jan_r = zeros(1,20);
jan_p = zeros(1,20);

for k = 1:20;
    [jan_r_cell{k}, jan_p_cell{k}] = corrcoef(hourscell{k}(1:36), jan_nao(2:37,2));
end

for k = 1:20;
    jan_r(k) = jan_r_cell{k}(1,2);
    jan_p(k) = jan_p_cell{k}(1,2);
end

% for feburary

feb_nao = csvread('Feb_NAO.csv');
feb_r_cell = cell(1,20);
feb_p_cell = cell(1,20);
feb_r = zeros(1,20);
feb_p = zeros(1,20);

for k = 1:20;
    [feb_r_cell{k}, feb_p_cell{k}] = corrcoef(hourscell{k}(1:36), feb_nao(2:37,2));
end

for k = 1:20;
    feb_r(k) = feb_r_cell{k}(1,2);
    feb_p(k) = feb_p_cell{k}(1,2);
end

% assimilate all data
% so are left with two 5 x 20 matrices, each row = oct, nov, dec, jan, feb
% correlation coefficient/p-values for the columns outlined above

rs = zeros(5,20);
ps = zeros(5,20);

rs(1,:) = oct_r;
rs(2,:) = nov_r;
rs(3,:) = dec_r;
rs(4,:) = jan_r;
rs(5,:) = feb_r;
ps(1,:) = oct_p;
ps(2,:) = nov_p;
ps(3,:) = dec_p;
ps(4,:) = jan_p;
ps(5,:) = feb_p;
