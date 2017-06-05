% load data (all annual CSVS's merged into one CSV) - DO NOT PRINT
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

% define datenum hours in datenum

one_hour = datenum([1949 12 00 01 00 00]) - datenum([1949 12 00 00 00 00]);

% define strength of wind searching for

FPW = prctile(wind_data_QC(:,3), 50);
GFW = 34;
SFW = prctile(wind_data_QC(:,3), 97);
NPW = prctile(wind_data_QC(:,3), 99.5);
   
% define no of years to study

years = 2016-1948;

% create  vectors of zeros to add the point at which different months begin

october = zeros([1, years]);
november = zeros([1, years]);
december = zeros([1, years]);
january = zeros([1, years]);
november = zeros([1, years]);
march = zeros([1, years]);
april = zeros([1, years]);

% create  vectors to add the location of month starts to

O = zeros([1, years]);
N = zeros([1, years]);
D = zeros([1, years]);
D_2 = zeros([1, years]);
F = zeros([1, years]);
M = zeros([1, years]);

% define T = time period that you wish to study

Oct_T = zeros([years, 2]);
Nov_T = zeros([years, 2]);
Dec_T = zeros([years, 2]);
Jan_T = zeros([years, 2]);
Feb_T = zeros([years, 2]);
Mar_T = zeros([years, 2]);

% make empty cells and one  vector

oct_cell_50 = cell(1,years);
oct_cell_gale = cell(1,years);
oct_cell_storm = cell(1,years);
oct_cell_99 = cell(1,years);
oct50NE = cell(1, years);
oct50SE = cell(1, years);
oct50SW = cell(1, years); 
oct50NW = cell(1, years);
octgNE = cell(1, years); 
octgSE = cell(1, years);
octgSW = cell(1, years);
octgNW = cell(1, years);
octsNE = cell(1, years); 
octsSE = cell(1, years);
octsSW = cell(1, years);
octsNW = cell(1, years);
oct99NE = cell(1, years);
oct99SE = cell(1, years);
oct99SW = cell(1, years);
oct99NW = cell(1, years);
nov_cell_50 = cell(1,years);
nov_cell_gale = cell(1,years);
nov_cell_storm = cell(1,years);
nov_cell_99 = cell(1,years);
nov50NE = cell(1, years);
nov50SE = cell(1, years);
nov50SW = cell(1, years); 
nov50NW = cell(1, years);
novgNE = cell(1, years); 
novgSE = cell(1, years);
novgSW = cell(1, years);
novgNW = cell(1, years);
novsNE = cell(1, years); 
novsSE = cell(1, years);
novsSW = cell(1, years);
novsNW = cell(1, years);
nov99NE = cell(1, years);
nov99SE = cell(1, years);
nov99SW = cell(1, years);
nov99NW = cell(1, years);
dec_cell_50 = cell(1,years);
dec_cell_gale = cell(1,years);
dec_cell_storm = cell(1,years);
dec_cell_99 = cell(1,years);
dec50NE = cell(1, years);
dec50SE = cell(1, years);
dec50SW = cell(1, years); 
dec50NW = cell(1, years);
decgNE = cell(1, years); 
decgSE = cell(1, years);
decgSW = cell(1, years);
decgNW = cell(1, years);
decsNE = cell(1, years); 
decsSE = cell(1, years);
decsSW = cell(1, years);
decsNW = cell(1, years);
dec99NE = cell(1, years);
dec99SE = cell(1, years);
dec99SW = cell(1, years);
dec99NW = cell(1, years);
jan_cell_50 = cell(1,years);
jan_cell_gale = cell(1,years);
jan_cell_storm = cell(1,years);
jan_cell_99 = cell(1,years);
jan50NE = cell(1, years);
jan50SE = cell(1, years);
jan50SW = cell(1, years); 
jan50NW = cell(1, years);
jangNE = cell(1, years); 
jangSE = cell(1, years);
jangSW = cell(1, years);
jangNW = cell(1, years);
jansNE = cell(1, years); 
jansSE = cell(1, years);
jansSW = cell(1, years);
jansNW = cell(1, years);
jan99NE = cell(1, years);
jan99SE = cell(1, years);
jan99SW = cell(1, years);
jan99NW = cell(1, years);
feb_cell_50 = cell(1,years);
feb_cell_gale = cell(1,years);
feb_cell_storm = cell(1,years);
feb_cell_99 = cell(1,years);
feb50NE = cell(1, years);
feb50SE = cell(1, years);
feb50SW = cell(1, years); 
feb50NW = cell(1, years);
febgNE = cell(1, years); 
febgSE = cell(1, years);
febgSW = cell(1, years);
febgNW = cell(1, years);
febsNE = cell(1, years); 
febsSE = cell(1, years);
febsSW = cell(1, years);
febsNW = cell(1, years);
feb99NE = cell(1, years);
feb99SE = cell(1, years);
feb99SW = cell(1, years);
feb99NW = cell(1, years);
mar_cell_50 = cell(1,years);
mar_cell_gale = cell(1,years);
mar_cell_storm = cell(1,years);
mar_cell_99 = cell(1,years);
mar50NE = cell(1, years);
mar50SE = cell(1, years);
mar50SW = cell(1, years); 
mar50NW = cell(1, years);
margNE = cell(1, years); 
margSE = cell(1, years);
margSW = cell(1, years);
margNW = cell(1, years);
marsNE = cell(1, years); 
marsSE = cell(1, years);
marsSW = cell(1, years);
marsNW = cell(1, years);
mar99NE = cell(1, years);
mar99SE = cell(1, years);
mar99SW = cell(1, years);
mar99NW = cell(1, years);
S_oct = cell(1,years);
S_nov = cell(1,years);
S_dec = cell(1, years);
S_jan = cell(1, years);
S_feb = cell(1, years);
S_mar = cell(1, years);
H_oct = zeros(1, years);
H_nov = zeros(1, years);
H_dec = zeros(1,years);
H_jan = zeros(1,years);
H_feb = zeros(1,years);
H_mar = zeros(1,years);

% add first and last of each month to each month / find the indices of where each
% of those months begins begins / define T, time period to be studied / make each value in mycell zero and each vector the same length as the
% number of samples for each months, this must be out of the main loop
% else it resets everything to zero


for k = 1:years;
    october(k) = datenum([1948+k 10 01 00 00 00]);
    november(k) = datenum([1948+k 11 01 00 00 00]);
    december(k) = datenum([1948+k 12 01 00 00 00]);
    december_2(k) = datenum([1948+k 12 31 23 00 00]);
    january(k) = datenum([1948+k 01 01 00 00 00]);
    feburary(k) = datenum([1948+k 02 01 00 00 00]);
    march(k) = datenum([1948+k 03 01 00 00 00]);
    april(k) = datenum([1948+k 04 01 00 00 00]);
    O(k) = find(wind_data_QC == october(1,k)); 
    N(k) = find(wind_data_QC == november(1,k));
    D(k) = find(wind_data_QC == december(1,k));
    D_2(k) = find(wind_data_QC == december_2(1,k));
    J(k) = find(wind_data_QC == january(k));
    F(k) = find(wind_data_QC == feburary(1,k));
    M(k) = find(wind_data_QC == march(1,k));
    A(k) = find(wind_data_QC == april(1,k));
    Oct_T(k,1) = O(k);
    Oct_T(k,2) = N(k);
    Nov_T(k,1) = N(k);
    Nov_T(k,2) = D(k);
    Dec_T(k,1) = D(k);
    Dec_T(k,2) = D_2(k);
    Jan_T(k,1) = J(k);
    Jan_T(k,2) = F(k);
    Feb_T(k,1) = F(k);
    Feb_T(k,2) = M(k);
    Mar_T(k,1) = M(k);
    Mar_T(k,2) = A(k);
    oct_cell_50{k} = zeros([1 length(S_oct{k})]);
    oct_cell_gale{k} = zeros([1 length(S_oct{k})]);
    oct_cell_storm{k} = zeros([1 length(S_oct{k})]);
    oct_cell_99{k} = zeros([1 length(S_oct{k})]);
    oct50NE = zeros([1 length(S_oct{k})]);
    oct50SE = zeros([1 length(S_oct{k})]);
    oct50SW = zeros([1 length(S_oct{k})]);
    oct50NW = zeros([1 length(S_oct{k})]);
    octgNE = zeros([1 length(S_oct{k})]);
    octgSE = zeros([1 length(S_oct{k})]);
    octgSW = zeros([1 length(S_oct{k})]);
    octgNW = zeros([1 length(S_oct{k})]);
    octsNE = zeros([1 length(S_oct{k})]);
    octsSE = zeros([1 length(S_oct{k})]);
    octsSW = zeros([1 length(S_oct{k})]);
    octsNW = zeros([1 length(S_oct{k})]);
    oct99NE = zeros([1 length(S_oct{k})]);
    oct99SE = zeros([1 length(S_oct{k})]);
    oct99SW = zeros([1 length(S_oct{k})]);
    oct99NW = zeros([1 length(S_oct{k})]);
    nov_cell_50{k} = zeros([1 length(S_nov{k})]);
    nov_cell_gale{k} = zeros([1 length(S_nov{k})]);
    nov_cell_storm{k} = zeros([1 length(S_nov{k})]);
    nov_cell_99{k} = zeros([1 length(S_nov{k})]);
    nov50NE = zeros([1 length(S_oct{k})]);
    nov50SE = zeros([1 length(S_oct{k})]);
    nov50SW = zeros([1 length(S_oct{k})]);
    nov50NW = zeros([1 length(S_oct{k})]);
    novgNE = zeros([1 length(S_oct{k})]);
    novgSE = zeros([1 length(S_oct{k})]);
    novgSW = zeros([1 length(S_oct{k})]);
    novgNW = zeros([1 length(S_oct{k})]);
    novsNE = zeros([1 length(S_oct{k})]);
    novsSE = zeros([1 length(S_oct{k})]);
    novsSW = zeros([1 length(S_oct{k})]);
    novsNW = zeros([1 length(S_oct{k})]);
    nov99NE = zeros([1 length(S_oct{k})]);
    nov99SE = zeros([1 length(S_oct{k})]);
    nov99SW = zeros([1 length(S_oct{k})]);
    nov99NW = zeros([1 length(S_oct{k})]);
    dec_cell_50{k} = zeros([1 length(S_dec{k})]);
    dec_cell_gale{k} = zeros([1 length(S_dec{k})]);
    dec_cell_storm{k} = zeros([1 length(S_dec{k})]);
    dec_cell_99{k} = zeros([1 length(S_dec{k})]);
    dec50NE = zeros([1 length(S_oct{k})]);
    dec50SE = zeros([1 length(S_oct{k})]);
    dec50SW = zeros([1 length(S_oct{k})]);
    dec50NW = zeros([1 length(S_oct{k})]);
    decgNE = zeros([1 length(S_oct{k})]);
    decgSE = zeros([1 length(S_oct{k})]);
    decgSW = zeros([1 length(S_oct{k})]);
    decgNW = zeros([1 length(S_oct{k})]);
    decsNE = zeros([1 length(S_oct{k})]);
    decsSE = zeros([1 length(S_oct{k})]);
    decsSW = zeros([1 length(S_oct{k})]);
    decsNW = zeros([1 length(S_oct{k})]);
    decs99NE = zeros([1 length(S_oct{k})]);
    dec99SE = zeros([1 length(S_oct{k})]);
    dec99SW = zeros([1 length(S_oct{k})]);
    dec99NW = zeros([1 length(S_oct{k})]);
    jan_cell_50{k} = zeros([1 length(S_jan{k})]);
    jan_cell_gale{k} = zeros([1 length(S_jan{k})]);
    jan_cell_storm{k} = zeros([1 length(S_jan{k})]);
    jan_cell_99{k} = zeros([1 length(S_jan{k})]);
    jan50NE = zeros([1 length(S_oct{k})]);
    jan50SE = zeros([1 length(S_oct{k})]);
    jan50SW = zeros([1 length(S_oct{k})]);
    jan50NW = zeros([1 length(S_oct{k})]);
    jangNE = zeros([1 length(S_oct{k})]);
    jangSE = zeros([1 length(S_oct{k})]);
    jangSW = zeros([1 length(S_oct{k})]);
    jangNW = zeros([1 length(S_oct{k})]);
    jansNE = zeros([1 length(S_oct{k})]);
    jansSE = zeros([1 length(S_oct{k})]);
    jansSW = zeros([1 length(S_oct{k})]);
    jansNW = zeros([1 length(S_oct{k})]);
    jans99NE = zeros([1 length(S_oct{k})]);
    jan99SE = zeros([1 length(S_oct{k})]);
    jan99SW = zeros([1 length(S_oct{k})]);
    jan99NW = zeros([1 length(S_oct{k})]);
    feb_cell_50{k} = zeros([1 length(S_feb{k})]);
    feb_cell_gale{k} = zeros([1 length(S_feb{k})]);
    feb_cell_storm{k} = zeros([1 length(S_feb{k})]);
    feb_cell_99{k} = zeros([1 length(S_feb{k})]);
    feb50NE = zeros([1 length(S_oct{k})]);
    feb50SE = zeros([1 length(S_oct{k})]);
    feb50SW = zeros([1 length(S_oct{k})]);
    feb50NW = zeros([1 length(S_oct{k})]);
    febgNE = zeros([1 length(S_oct{k})]);
    febgSE = zeros([1 length(S_oct{k})]);
    febgSW = zeros([1 length(S_oct{k})]);
    febgNW = zeros([1 length(S_oct{k})]);
    febsNE = zeros([1 length(S_oct{k})]);
    febsSE = zeros([1 length(S_oct{k})]);
    febsSW = zeros([1 length(S_oct{k})]);
    febsNW = zeros([1 length(S_oct{k})]);
    febs99NE = zeros([1 length(S_oct{k})]);
    feb99SE = zeros([1 length(S_oct{k})]);
    feb99SW = zeros([1 length(S_oct{k})]);
    feb99NW = zeros([1 length(S_oct{k})]);
    mar_cell_50{k} = zeros([1 length(S_mar{k})]);
    mar_cell_gale{k} = zeros([1 length(S_mar{k})]);
    mar_cell_storm{k} = zeros([1 length(S_mar{k})]);
    mar_cell_99{k} = zeros([1 length(S_mar{k})]);
    mar50NE = zeros([1 length(S_oct{k})]);
    mar50SE = zeros([1 length(S_oct{k})]);
    mar50SW = zeros([1 length(S_oct{k})]);
    mar50NW = zeros([1 length(S_oct{k})]);
    margNE = zeros([1 length(S_oct{k})]);
    margSE = zeros([1 length(S_oct{k})]);
    margSW = zeros([1 length(S_oct{k})]);
    margNW = zeros([1 length(S_oct{k})]);
    marsNE = zeros([1 length(S_oct{k})]);
    marsSE = zeros([1 length(S_oct{k})]);
    marsSW = zeros([1 length(S_oct{k})]);
    marsNW = zeros([1 length(S_oct{k})]);
    mars99NE = zeros([1 length(S_oct{k})]);
    mar99SE = zeros([1 length(S_oct{k})]);
    mar99SW = zeros([1 length(S_oct{k})]);
    mar99NW = zeros([1 length(S_oct{k})]);
end

% for each year, the array in S should be the period which we wish to
% study, make an vector H where each value corresponds to the no of values
% per january, then loop through all the rows in the chosen time period and
% where >17.5ms-1 make the corresponding value in my cell = the period of
% time over which that value was taken

% october loop
 
for k = 1:years;
    S_oct{k} = wind_data_QC([Oct_T(k,1):Oct_T(k,2)],:);
    H_oct(k) = length(S_oct{k});
    for i = 2:H_oct(k);
            if S_oct{k}(i,3) >= FPW;
                oct_cell_50{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else oct_cell_50{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) > GFW;
                oct_cell_gale{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else oct_cell_gale{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) > SFW;
                oct_cell_storm{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else oct_cell_gale{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) > NPW;
                oct_cell_99{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else oct_cell_99{k}(1,i) = 0;
            end 
            if S_oct{k}(i,3) >= FPW & S_oct{k}(i,2) <= 90;
                oct50NE{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else oct50NE{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) >= FPW & S_oct{k}(i,2) > 90 & S_oct{k}(i,2) <= 180;
                oct50SE{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else oct50SE{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) >= FPW & S_oct{k}(i,2) > 180 & S_oct{k}(i,2) <= 270;
                oct50SW{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else oct50SW{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) >= FPW & S_oct{k}(i,2) > 270 & S_oct{k}(i,2) <= 360;
                oct50NW{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else oct50NW{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) >= GFW & S_oct{k}(i,2) <= 90;
                octgNE{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else octgNE{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) >= GFW & S_oct{k}(i,2) > 90 & S_oct{k}(i,2) <= 180;
                octgSE{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else octgSE{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) >= GFW & S_oct{k}(i,2) > 180 & S_oct{k}(i,2) <= 270;
                octgSW{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else octgSW{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) >= GFW & S_oct{k}(i,2) > 270 & S_oct{k}(i,2) <= 360;
                octgNW{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else octgNW{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) >= SFW & S_oct{k}(i,2) <= 90;
                octsNE{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else octsNE{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) >= SFW & S_oct{k}(i,2) > 90 & S_oct{k}(i,2) <= 180;
                octsSE{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else octsSE{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) >= SFW & S_oct{k}(i,2) > 180 & S_oct{k}(i,2) <= 270;
                octsSW{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else octsSW{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) >= SFW & S_oct{k}(i,2) > 270 & S_oct{k}(i,2) <= 360;
                octsNW{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else octsNW{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) >= NPW & S_oct{k}(i,2) <= 90;
                oct99NE{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else oct99NE{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) >= NPW & S_oct{k}(i,2) > 90 & S_oct{k}(i,2) <= 180;
                oct99SE{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else oct99SE{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) >= NPW & S_oct{k}(i,2) > 180 & S_oct{k}(i,2) <= 270;
                oct99SW{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else oct99SW{k}(1,i) = 0;
            end
            if S_oct{k}(i,3) >= NPW & S_oct{k}(i,2) > 270 & S_oct{k}(i,2) <= 360;
                oct99NW{k}(1,i) = S_oct{k}(i,1) - S_oct{k}(i-1,1);
            else oct99NW{k}(1,i) = 0;
            end
    end
end

% november loop
 
for k = 1:years;
    S_nov{k} = wind_data_QC([Nov_T(k,1):Nov_T(k,2)],:);
    H_nov(k) = length(S_nov{k});
    for i = 2:H_nov(k);
            if S_nov{k}(i,3) >= FPW;
                nov_cell_50{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else nov_cell_50{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) > GFW;
                nov_cell_gale{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else nov_cell_gale{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) > SFW;
                nov_cell_storm{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else nov_cell_storm{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) > NPW;
                nov_cell_99{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else nov_cell_99{k}(1,i) = 0;
            end 
            if S_nov{k}(i,3) >= FPW & S_nov{k}(i,2) <= 90;
                nov50NE{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else nov50NE{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) >= FPW & S_nov{k}(i,2) > 90 & S_nov{k}(i,2) <= 180;
                nov50SE{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else nov50SE{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) >= FPW & S_nov{k}(i,2) > 180 & S_nov{k}(i,2) <= 270;
                nov50SW{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else nov50SW{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) >= FPW & S_nov{k}(i,2) > 270 & S_nov{k}(i,2) <= 360;
                nov50NW{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else nov50NW{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) >= GFW & S_nov{k}(i,2) <= 90;
                novgNE{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else novgNE{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) >= GFW & S_nov{k}(i,2) > 90 & S_nov{k}(i,2) <= 180;
                novgSE{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else novgSE{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) >= GFW & S_nov{k}(i,2) > 180 & S_nov{k}(i,2) <= 270;
                novgSW{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else novgSW{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) >= GFW & S_nov{k}(i,2) > 270 & S_nov{k}(i,2) <= 360;
                novgNW{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else novgNW{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) >= SFW & S_nov{k}(i,2) <= 90;
                novsNE{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else novsNE{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) >= SFW & S_nov{k}(i,2) > 90 & S_nov{k}(i,2) <= 180;
                novsSE{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else novsSE{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) >= SFW & S_nov{k}(i,2) > 180 & S_nov{k}(i,2) <= 270;
                novsSW{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else novsSW{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) >= SFW & S_nov{k}(i,2) > 270 & S_nov{k}(i,2) <= 360;
                novsNW{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else novsNW{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) >= NPW & S_nov{k}(i,2) <= 90;
                nov99NE{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else nov99NE{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) >= NPW & S_nov{k}(i,2) > 90 & S_nov{k}(i,2) <= 180;
                nov99SE{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else nov99SE{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) >= NPW & S_nov{k}(i,2) > 180 & S_nov{k}(i,2) <= 270;
                nov99SW{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else nov99SW{k}(1,i) = 0;
            end
            if S_nov{k}(i,3) >= NPW & S_nov{k}(i,2) > 270 & S_nov{k}(i,2) <= 360;
                nov99NW{k}(1,i) = S_nov{k}(i,1) - S_nov{k}(i-1,1);
            else nov99NW{k}(1,i) = 0;
            end
    end
end

% december loop
 
for k = 1:years;
    S_dec{k} = wind_data_QC([Dec_T(k,1):Dec_T(k,2)],:);
    H_dec(k) = length(S_dec{k});
    for i = 2:H_dec(k);
            if S_dec{k}(i,3) >= FPW;
                dec_cell_50{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else dec_cell_50{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) > GFW;
                dec_cell_gale{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else dec_cell_gale{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) > SFW;
                dec_cell_storm{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else dec_cell_storm{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) > NPW;
                dec_cell_99{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else dec_cell_99{k}(1,i) = 0;
            end 
            if S_dec{k}(i,3) >= FPW & S_dec{k}(i,2) <= 90;
                dec50NE{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else dec50NE{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) >= FPW & S_dec{k}(i,2) > 90 & S_dec{k}(i,2) <= 180;
                dec50SE{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else dec50SE{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) >= FPW & S_dec{k}(i,2) > 180 & S_dec{k}(i,2) <= 270;
                dec50SW{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else dec50SW{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) >= FPW & S_dec{k}(i,2) > 270 & S_dec{k}(i,2) <= 360;
                dec50NW{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else dec50NW{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) >= GFW & S_dec{k}(i,2) <= 90;
                decgNE{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else decgNE{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) >= GFW & S_dec{k}(i,2) > 90 & S_dec{k}(i,2) <= 180;
                decgSE{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else decgSE{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) >= GFW & S_dec{k}(i,2) > 180 & S_dec{k}(i,2) <= 270;
                decgSW{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else decgSW{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) >= GFW & S_dec{k}(i,2) > 270 & S_dec{k}(i,2) <= 360;
                decgNW{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else decgNW{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) >= SFW & S_dec{k}(i,2) <= 90;
                decsNE{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else decsNE{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) >= SFW & S_dec{k}(i,2) > 90 & S_dec{k}(i,2) <= 180;
                decsSE{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else decsSE{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) >= SFW & S_dec{k}(i,2) > 180 & S_dec{k}(i,2) <= 270;
                decsSW{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else decsSW{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) >= SFW & S_dec{k}(i,2) > 270 & S_dec{k}(i,2) <= 360;
                decsNW{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else decsNW{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) >= NPW & S_dec{k}(i,2) <= 90;
                dec99NE{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else dec99NE{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) >= NPW & S_dec{k}(i,2) > 90 & S_dec{k}(i,2) <= 180;
                dec99SE{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else dec99SE{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) >= NPW & S_dec{k}(i,2) > 180 & S_dec{k}(i,2) <= 270;
                dec99SW{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else dec99SW{k}(1,i) = 0;
            end
            if S_dec{k}(i,3) >= NPW & S_dec{k}(i,2) > 270 & S_dec{k}(i,2) <= 360;
                dec99NW{k}(1,i) = S_dec{k}(i,1) - S_dec{k}(i-1,1);
            else dec99NW{k}(1,i) = 0;
            end
    end
end

% january loop
 
for k = 1:years;
    S_jan{k} = wind_data_QC([Jan_T(k,1):Jan_T(k,2)],:);
    H_jan(k) = length(S_jan{k});
    for i = 2:H_jan(k);
            if S_jan{k}(i,3) >= FPW;
                jan_cell_50{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jan_cell_50{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) > GFW;
                jan_cell_gale{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jan_cell_gale{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) > SFW;
                jan_cell_storm{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jan_cell_storm{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) > NPW;
                jan_cell_99{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jan_cell_99{k}(1,i) = 0;
            end 
            if S_jan{k}(i,3) >= FPW & S_jan{k}(i,2) <= 90;
                jan50NE{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jan50NE{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) >= FPW & S_jan{k}(i,2) > 90 & S_jan{k}(i,2) <= 180;
                jan50SE{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jan50SE{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) >= FPW & S_jan{k}(i,2) > 180 & S_jan{k}(i,2) <= 270;
                jan50SW{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jan50SW{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) >= FPW & S_jan{k}(i,2) > 270 & S_jan{k}(i,2) <= 360;
                jan50NW{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jan50NW{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) >= GFW & S_jan{k}(i,2) <= 90;
                jangNE{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jangNE{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) >= GFW & S_jan{k}(i,2) > 90 & S_jan{k}(i,2) <= 180;
                jangSE{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jangSE{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) >= GFW & S_jan{k}(i,2) > 180 & S_jan{k}(i,2) <= 270;
                jangSW{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jangSW{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) >= GFW & S_jan{k}(i,2) > 270 & S_jan{k}(i,2) <= 360;
                jangNW{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jangNW{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) >= SFW & S_jan{k}(i,2) <= 90;
                jansNE{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jansNE{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) >= SFW & S_jan{k}(i,2) > 90 & S_jan{k}(i,2) <= 180;
                jansSE{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jansSE{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) >= SFW & S_jan{k}(i,2) > 180 & S_jan{k}(i,2) <= 270;
                jansSW{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jansSW{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) >= SFW & S_jan{k}(i,2) > 270 & S_jan{k}(i,2) <= 360;
                jansNW{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jansNW{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) >= NPW & S_jan{k}(i,2) <= 90;
                jan99NE{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jan99NE{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) >= NPW & S_jan{k}(i,2) > 90 & S_jan{k}(i,2) <= 180;
                jan99SE{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jan99SE{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) >= NPW & S_jan{k}(i,2) > 180 & S_jan{k}(i,2) <= 270;
                jan99SW{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jan99SW{k}(1,i) = 0;
            end
            if S_jan{k}(i,3) >= NPW & S_jan{k}(i,2) > 270 & S_jan{k}(i,2) <= 360;
                jan99NW{k}(1,i) = S_jan{k}(i,1) - S_jan{k}(i-1,1);
            else jan99NW{k}(1,i) = 0;
            end
    end
end

% feburary loop
 
for k = 1:years;
    S_feb{k} = wind_data_QC([Feb_T(k,1):Feb_T(k,2)],:);
    H_feb(k) = length(S_feb{k});
    for i = 2:H_feb(k);
            if S_feb{k}(i,3) >= FPW;
                feb_cell_50{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else feb_cell_50{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) > GFW;
                feb_cell_gale{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else feb_cell_gale{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) > SFW;
                feb_cell_storm{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else feb_cell_gale{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) > NPW;
                feb_cell_99{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else feb_cell_99{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) >= FPW & S_feb{k}(i,2) <= 90;
                feb50NE{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else feb50NE{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) >= FPW & S_feb{k}(i,2) > 90 & S_feb{k}(i,2) <= 180;
                feb50SE{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else feb50SE{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) >= FPW & S_feb{k}(i,2) > 180 & S_feb{k}(i,2) <= 270;
                feb50SW{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else feb50SW{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) >= FPW & S_feb{k}(i,2) > 270 & S_feb{k}(i,2) <= 360;
                feb50NW{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else feb50NW{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) >= GFW & S_feb{k}(i,2) <= 90;
                febgNE{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else febgNE{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) >= GFW & S_feb{k}(i,2) > 90 & S_feb{k}(i,2) <= 180;
                febgSE{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else febgSE{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) >= GFW & S_feb{k}(i,2) > 180 & S_feb{k}(i,2) <= 270;
                febgSW{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else febgSW{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) >= GFW & S_feb{k}(i,2) > 270 & S_feb{k}(i,2) <= 360;
                febgNW{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else febgNW{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) >= SFW & S_feb{k}(i,2) <= 90;
                febsNE{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else febsNE{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) >= SFW & S_feb{k}(i,2) > 90 & S_feb{k}(i,2) <= 180;
                febsSE{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else febsSE{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) >= SFW & S_feb{k}(i,2) > 180 & S_feb{k}(i,2) <= 270;
                febsSW{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else febsSW{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) >= SFW & S_feb{k}(i,2) > 270 & S_feb{k}(i,2) <= 360;
                febsNW{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else febsNW{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) >= NPW & S_feb{k}(i,2) <= 90;
                feb99NE{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else feb99NE{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) >= NPW & S_feb{k}(i,2) > 90 & S_feb{k}(i,2) <= 180;
                feb99SE{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else feb99SE{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) >= NPW & S_feb{k}(i,2) > 180 & S_feb{k}(i,2) <= 270;
                feb99SW{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else feb99SW{k}(1,i) = 0;
            end
            if S_feb{k}(i,3) >= NPW & S_feb{k}(i,2) > 270 & S_feb{k}(i,2) <= 360;
                feb99NW{k}(1,i) = S_feb{k}(i,1) - S_feb{k}(i-1,1);
            else feb99NW{k}(1,i) = 0;
            end 
    end
end

% march loop
 
for k = 1:years;
    S_mar{k} = wind_data_QC([Mar_T(k,1):Mar_T(k,2)],:);
    H_mar(k) = length(S_mar{k});
    for i = 2:H_mar(k);
            if S_mar{k}(i,3) >= FPW;
                mar_cell_50{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else mar_cell_50{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) > GFW;
                mar_cell_gale{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else mar_cell_gale{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) > SFW;
                mar_cell_storm{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else mar_cell_storm{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) > NPW;
                mar_cell_99{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else mar_cell_99{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) >= FPW & S_mar{k}(i,2) <= 90;
                mar50NE{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else mar50NE{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) >= FPW & S_mar{k}(i,2) > 90 & S_mar{k}(i,2) <= 180;
                mar50SE{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else mar50SE{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) >= FPW & S_mar{k}(i,2) > 180 & S_mar{k}(i,2) <= 270;
                mar50SW{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else mar50SW{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) >= FPW & S_mar{k}(i,2) > 270 & S_mar{k}(i,2) <= 360;
                mar50NW{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else mar50NW{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) >= GFW & S_mar{k}(i,2) <= 90;
                margNE{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else margNE{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) >= GFW & S_mar{k}(i,2) > 90 & S_mar{k}(i,2) <= 180;
                margSE{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else margSE{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) >= GFW & S_mar{k}(i,2) > 180 & S_mar{k}(i,2) <= 270;
                margSW{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else margSW{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) >= GFW & S_mar{k}(i,2) > 270 & S_mar{k}(i,2) <= 360;
                margNW{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else margNW{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) >= SFW & S_mar{k}(i,2) <= 90;
                marsNE{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else marsNE{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) >= SFW & S_mar{k}(i,2) > 90 & S_mar{k}(i,2) <= 180;
                marsSE{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else marsSE{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) >= SFW & S_mar{k}(i,2) > 180 & S_mar{k}(i,2) <= 270;
                marsSW{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else marsSW{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) >= SFW & S_mar{k}(i,2) > 270 & S_mar{k}(i,2) <= 360;
                marsNW{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else marsNW{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) >= NPW & S_mar{k}(i,2) <= 90;
                mar99NE{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else mar99NE{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) >= NPW & S_mar{k}(i,2) > 90 & S_mar{k}(i,2) <= 180;
                mar99SE{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else mar99SE{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) >= NPW & S_mar{k}(i,2) > 180 & S_mar{k}(i,2) <= 270;
                mar99SW{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else mar99SW{k}(1,i) = 0;
            end
            if S_mar{k}(i,3) >= NPW & S_mar{k}(i,2) > 270 & S_mar{k}(i,2) <= 360;
                mar99NW{k}(1,i) = S_mar{k}(i,1) - S_mar{k}(i-1,1);
            else mar99NW{k}(1,i) = 0;
            end 
    end
end

% sum up all the values of hours etc. in each vector in each, this is the
% total number of gale hours in January according to MATLAB time in each
% years

for k = 1:years;
    OCT50(1,k) = sum(oct_cell_50{k})/one_hour;
    OCTG(1,k) = sum(oct_cell_gale{k})/one_hour;
    OCTS(1,k) = sum(oct_cell_storm{k})/one_hour;
    OCT99(1,k) = sum(oct_cell_99{k})/one_hour;
    OCTNE50(1,k) = sum(oct50NE{k})/one_hour;
    OCTSE50(1,k) = sum(oct50SE{k})/one_hour;
    OCTSW50(1,k) = sum(oct50SW{k})/one_hour;
    OCTNW50(1,k) = sum(oct50NW{k})/one_hour;
    OCTNEG(1,k) = sum(octgNE{k})/one_hour;
    OCTSEG(1,k) = sum(octgSE{k})/one_hour;
    OCTSWG(1,k) = sum(octgSW{k})/one_hour;
    OCTNWG(1,k) = sum(octgNW{k})/one_hour;
    OCTNES(1,k) = sum(octsNE{k})/one_hour;
    OCTSES(1,k) = sum(octsSE{k})/one_hour;
    OCTSWS(1,k) = sum(octsSW{k})/one_hour;
    OCTNWS(1,k) = sum(octsNW{k})/one_hour;
    OCTNE99(1,k) = sum(oct99NE{k})/one_hour;
    OCTSE99(1,k) = sum(oct99SE{k})/one_hour;
    OCTSW99(1,k) = sum(oct99SW{k})/one_hour;
    OCTNW99(1,k) = sum(oct99NW{k})/one_hour;
    NOV50(1,k) = sum(nov_cell_50{k})/one_hour;
    NOVG(1,k) = sum(nov_cell_gale{k})/one_hour;
    NOVS(1,k) = sum(nov_cell_storm{k})/one_hour;
    NOV99(1,k) = sum(nov_cell_99{k})/one_hour;
    NOVNE50(1,k) = sum(nov50NE{k})/one_hour;
    NOVSE50(1,k) = sum(nov50SE{k})/one_hour;
    NOVSW50(1,k) = sum(nov50SW{k})/one_hour;
    NOVNW50(1,k) = sum(nov50NW{k})/one_hour;
    NOVNEG(1,k) = sum(novgNE{k})/one_hour;
    NOVSEG(1,k) = sum(novgSE{k})/one_hour;
    NOVSWG(1,k) = sum(novgSW{k})/one_hour;
    NOVNWG(1,k) = sum(novgNW{k})/one_hour;
    NOVNES(1,k) = sum(novsNE{k})/one_hour;
    NOVSES(1,k) = sum(novsSE{k})/one_hour;
    NOVSWS(1,k) = sum(novsSW{k})/one_hour;
    NOVNWS(1,k) = sum(novsNW{k})/one_hour;
    NOVNE99(1,k) = sum(nov99NE{k})/one_hour;
    NOVSE99(1,k) = sum(nov99SE{k})/one_hour;
    NOVSW99(1,k) = sum(nov99SW{k})/one_hour;
    NOVNW99(1,k) = sum(nov99NW{k})/one_hour;
    DEC50(1,k) = sum(dec_cell_50{k})/one_hour;
    DECG(1,k) = sum(dec_cell_gale{k})/one_hour;
    DECS(1,k) = sum(dec_cell_storm{k})/one_hour;
    DEC99(1,k) = sum(dec_cell_99{k})/one_hour;
    DECNE50(1,k) = sum(dec50NE{k})/one_hour;
    DECSE50(1,k) = sum(dec50SE{k})/one_hour;
    DECSW50(1,k) = sum(dec50SW{k})/one_hour;
    DECNW50(1,k) = sum(dec50NW{k})/one_hour;
    DECNEG(1,k) = sum(decgNE{k})/one_hour;
    DECSEG(1,k) = sum(decgSE{k})/one_hour;
    DECSWG(1,k) = sum(decgSW{k})/one_hour;
    DECNWG(1,k) = sum(decgNW{k})/one_hour;
    DECNES(1,k) = sum(decsNE{k})/one_hour;
    DECSES(1,k) = sum(decsSE{k})/one_hour;
    DECSWS(1,k) = sum(decsSW{k})/one_hour;
    DECNWS(1,k) = sum(decsNW{k})/one_hour;
    DECNE99(1,k) = sum(dec99NE{k})/one_hour;
    DECSE99(1,k) = sum(dec99SE{k})/one_hour;
    DECSW99(1,k) = sum(dec99SW{k})/one_hour;
    DECNW99(1,k) = sum(dec99NW{k})/one_hour;
    JAN50(1,k) = sum(jan_cell_50{k})/one_hour;
    JANG(1,k) = sum(jan_cell_gale{k})/one_hour;
    JANS(1,k) = sum(jan_cell_storm{k})/one_hour;
    JAN99(1,k) = sum(jan_cell_99{k})/one_hour;
    JANNE50(1,k) = sum(jan50NE{k})/one_hour;
    JANSE50(1,k) = sum(jan50SE{k})/one_hour;
    JANSW50(1,k) = sum(jan50SW{k})/one_hour;
    JANNW50(1,k) = sum(jan50NW{k})/one_hour;
    JANNEG(1,k) = sum(jangNE{k})/one_hour;
    JANSEG(1,k) = sum(jangSE{k})/one_hour;
    JANSWG(1,k) = sum(jangSW{k})/one_hour;
    JANNWG(1,k) = sum(jangNW{k})/one_hour;
    JANNES(1,k) = sum(jansNE{k})/one_hour;
    JANSES(1,k) = sum(jansSE{k})/one_hour;
    JANSWS(1,k) = sum(jansSW{k})/one_hour;
    JANNWS(1,k) = sum(jansNW{k})/one_hour;
    JANNE99(1,k) = sum(jan99NE{k})/one_hour;
    JANSE99(1,k) = sum(jan99SE{k})/one_hour;
    JANSW99(1,k) = sum(jan99SW{k})/one_hour;
    JANNW99(1,k) = sum(jan99NW{k})/one_hour;
    FEB50(1,k) = sum(feb_cell_50{k})/one_hour;
    FEBG(1,k) = sum(feb_cell_gale{k})/one_hour;
    FEBS(1,k) = sum(feb_cell_storm{k})/one_hour;
    FEB99(1,k) = sum(feb_cell_99{k})/one_hour;
    FEBNE50(1,k) = sum(feb50NE{k})/one_hour;
    FEBSE50(1,k) = sum(feb50SE{k})/one_hour;
    FEBSW50(1,k) = sum(feb50SW{k})/one_hour;
    FEBNW50(1,k) = sum(feb50NW{k})/one_hour;
    FEBNEG(1,k) = sum(febgNE{k})/one_hour;
    FEBSEG(1,k) = sum(febgSE{k})/one_hour;
    FEBSWG(1,k) = sum(febgSW{k})/one_hour;
    FEBNWG(1,k) = sum(febgNW{k})/one_hour;
    FEBNES(1,k) = sum(febsNE{k})/one_hour;
    FEBSES(1,k) = sum(febsSE{k})/one_hour;
    FEBSWS(1,k) = sum(febsSW{k})/one_hour;
    FEBNWS(1,k) = sum(febsNW{k})/one_hour;
    FEBNE99(1,k) = sum(feb99NE{k})/one_hour;
    FEBSE99(1,k) = sum(feb99SE{k})/one_hour;
    FEBSW99(1,k) = sum(feb99SW{k})/one_hour;
    FEBNW99(1,k) = sum(feb99NW{k})/one_hour;
    MAR50(1,k) = sum(mar_cell_50{k})/one_hour;
    MARG(1,k) = sum(mar_cell_gale{k})/one_hour;
    MARS(1,k) = sum(mar_cell_storm{k})/one_hour;
    MAR99(1,k) = sum(mar_cell_99{k})/one_hour;
    MARNE50(1,k) = sum(mar50NE{k})/one_hour;
    MARSE50(1,k) = sum(mar50SE{k})/one_hour;
    MARSW50(1,k) = sum(mar50SW{k})/one_hour;
    MARNW50(1,k) = sum(mar50NW{k})/one_hour;
    MARNEG(1,k) = sum(margNE{k})/one_hour;
    MARSEG(1,k) = sum(margSE{k})/one_hour;
    MARSWG(1,k) = sum(margSW{k})/one_hour;
    MARNWG(1,k) = sum(margNW{k})/one_hour;
    MARNES(1,k) = sum(marsNE{k})/one_hour;
    MARSES(1,k) = sum(marsSE{k})/one_hour;
    MARSWS(1,k) = sum(marsSW{k})/one_hour;
    MARNWS(1,k) = sum(marsNW{k})/one_hour;
    MARNE99(1,k) = sum(mar99NE{k})/one_hour;
    MARSE99(1,k) = sum(mar99SE{k})/one_hour;
    MARSW99(1,k) = sum(mar99SW{k})/one_hour;
    MARNW99(1,k) = sum(mar99NW{k})/one_hour;
end

% add all data to a cell to stop having to write it out constantly 

hours_cell = {OCT50 OCTG OCTS OCT99 NOV50 NOVG NOVS NOV99 DEC50 DECG DECS DEC99 JAN50 JANG JANS JAN99 FEB50 FEBG FEBS FEB99 MAR50 MARG MARS MAR99};

october_cell = {OCTNE50 OCTSE50 OCTSW50 OCTNW50 OCTNEG OCTSEG OCTSWG OCTNWG OCTNES OCTSES OCTSWS OCTNWS OCTNE99 OCTSE99 OCTSW99 OCTNW99};

november_cell = {NOVNE50 NOVSE50 NOVSW50 NOVNW50 NOVNEG NOVSEG NOVSWG NOVNWG NOVNES NOVSES NOVSWS NOVNWS NOVNE99 NOVSE99 NOVSW99 NOVNW99};

december_cell = {DECNE50 DECSE50 DECSW50 DECNW50 DECNEG DECSEG DECSWG DECNWG DECNES DECSES DECSWS DECNWS DECNE99 DECSE99 DECSW99 DECNW99};

january_cell = {JANNE50 JANSE50 JANSW50 JANNW50 JANNEG JANSEG JANSWG JANNWG JANNES JANSES JANSWS JANNWS JANNE99 JANSE99 JANSW99 JANNW99};

feburary_cell = {FEBNE50 FEBSE50 FEBSW50 FEBNW50 FEBNEG FEBSEG FEBSWG FEBNWG FEBNES FEBSES FEBSWS FEBNWS FEBNE99 FEBSE99 FEBSW99 FEBNW99};

march_cell = {MARNE50 MARSE50 MARSW50 MARNW50 MARNEG MARSEG MARSWG MARNWG MARNES MARSES MARSWS MARNWS MARNE99 MARSE99 MARSW99 MARNW99};

% vector of years studied for plots

plot_years = [1949:2016];

% add nao timeseries

oct_nao_SB = csvread('OCT_NAO.csv');
nov_nao_SB = csvread('NOV_NAO.csv');
dec_nao_SB = csvread('DEC_NAO.csv');
jan_nao_SB = csvread('JAN_NAO.csv');
feb_nao_SB = csvread('FEB_NAO.csv');
mar_nao_SB = csvread('MAR_NAO.csv');
oct_nao_PC = csvread('OCT_NAO_pc.csv');
nov_nao_PC = csvread('NOV_NAO_pc.csv');
dec_nao_PC = csvread('DEC_NAO_pc.csv');
jan_nao_PC = csvread('JAN_NAO_pc.csv');
feb_nao_PC = csvread('NAO_FEB_pc.csv');
mar_nao_PC = csvread('MAR_NAO_pc.csv');
