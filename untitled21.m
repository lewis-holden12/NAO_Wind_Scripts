p_oct = csvread('P_oct.csv');
p_nov = csvread('P_nov.csv');
p_dec = csvread('P_dec.csv');
p_jan = csvread('P_jan.csv');
p_feb = csvread('P_feb.csv');

% october 95%

p_vals_oct = zeros(1,20)

for k = 1:20;
    for i = 1:17;
        if p_oct(i,k) < 0.05;
            p_vals_oct(k) = p_vals_oct(k) + 1
        end
    end
end

% november 95%

p_vals_nov = zeros(1,20)

for k = 1:20;
    for i = 1:17;
        if p_nov(i,k) < 0.05;
            p_vals_nov(k) = p_vals_nov(k) + 1
        end
    end
end

% december 95%

p_vals_dec = zeros(1,20)

for k = 1:20;
    for i = 1:17;
        if p_dec(i,k) < 0.05;
            p_vals_dec(k) = p_vals_dec(k) + 1
        end
    end
end

% january 95%

p_vals_jan = zeros(1,20)

for k = 1:20;
    for i = 1:17;
        if p_jan(i,k) < 0.05;
            p_vals_jan(k) = p_vals_jan(k) + 1
        end
    end
end

% feb 95%

p_vals_feb = zeros(1,20)

for k = 1:20;
    for i = 1:17;
        if p_feb(i,k) < 0.05;
            p_vals_feb(k) = p_vals_feb(k) + 1
        end
    end
end

