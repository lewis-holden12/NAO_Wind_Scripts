percentage_change = [7.803856428; -0.719189293; 1.417672267; -3.295950423; -1.081869868; 4.202843981; 0.917749341; 5.230992125; -0.640342793; -1.263272354; 2.945531569; 5.445345298; 5.219135481]
latitude = [54.6636; 54.2278; 57.2051; 60.1395; 56.3774; 55.3722; 50.3544; 54.0851; 52.7943; 58.2138; 56.5; 51.3937; 52.2524]


longitude = [-6.224426; -10.0069; -2.2037; -1.18299; -2.86051; -7.2289; -4.11986; -3.20545; -2.66329; -6.31772; -6.8796; -10.2444; -4.53524]

X = [ones(size(latitude)) latitude longitude latitude.*longitude];
[b,bint,r] = regress(percentage_change, X)

scatter3(latitude, longitude, percentage_change, 'filled', 'r')
hold on
latitudefit = min(latitude):0.01:max(latitude);
longitudefit = min(longitude):0.01:max(longitude);
[LATITUDEFIT,LONGITUDEFIT] = meshgrid(latitudefit,longitudefit);
YFIT = b(1) + b(2)*LATITUDEFIT + b(3)*LONGITUDEFIT + b(4)*LATITUDEFIT.*LONGITUDEFIT;
mesh(LATITUDEFIT,LONGITUDEFIT,YFIT)
view(155,10)
xlabel('Latitude')
ylabel('Longitude')
zlabel('% Change in NDJ 99.5th Magnitude - Pre/Post 1986')
set(gca, 'fontsize', 12)
set(gca, 'fontweight', 'bold')

