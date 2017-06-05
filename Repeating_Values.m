%----------SCRIPT TO FIND REPEATING VALUES IN MAT DATEs-------

% FIND THE REPEATING VALUES THAT ARE THE PROBLEM

logical_dates = zeros(length(MAT_dates),1);
 
for k = 2:length(MAT_dates);
    if MAT_dates(k,1) == MAT_dates(k-1,1);
        logical_dates(k) = 1;
    end
end

log = logical(logical_dates);

% Vals contains the indices of all locations where the value of MAT Dates
% is repeated

vals = find(log);