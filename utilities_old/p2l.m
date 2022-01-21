% Calcola la minima distanza tra un punto e una retta
% point to line
function distancep2l = p2l(m,q, point)

% equazione della retta in forma Y = m*X+q
% points : array 1x2. (x,y)   x = points(1,1)
%                             y = points(1,2)

xp = point(1,1);
yp = point(1,2);

distancep2l = abs(yp - (m*xp +q))/ sqrt(1+m^2);