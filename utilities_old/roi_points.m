% Elimina i punti [x,y] nel vettore POINTS che giacciono al di sotto di una 
% retta espressa con l'equazione Y = m*X+q, entro una certa tolleranza h 
% (per distinguere un vigneto basso dalle erbacce di altezza ridotta)

function [x_roi, y_roi] = roi_points(m,q, points, tol)

% equazione della retta in forma Y = m*X+q
% points : array nx2. (xi,yi)   x = points(:,1)
%                               y = points(:,2)

x_roi = points(:,1);
y_roi = points(:,2);
n = size(points,1);
X = x_roi; % valori delle ascisse da x(1) e x(2).
Y = m*X +q; % ransac line

%rimuovo i punti al di sotto della retta e le erbacce
% rimuovo quelli troppo distanti dal centro - filari esterni
[xmin, imin] = min(x_roi);
ymin = y_roi(imin);
[xmax, imax] = max(x_roi);
ymax = y_roi(imax);

for i =1:n
    if y_roi(i)< Y(i) ...
            || p2l(m,q,[x_roi(i),y_roi(i)])< tol ... % punti inliers alla retta del terreno
            || p2p([xmin,ymin],[x_roi(i),y_roi(i)])< 1.5 ... % filare secondario a sinistra
            || p2p([xmax,ymax],[x_roi(i),y_roi(i)])< 1.5 ... % filare secondario a destra
            || abs(x_roi(i))<0.5 || abs(x_roi)% eventuali corpi estranei nella parte centrale del filare   
        x_roi(i) = nan;
        y_roi(i) = nan;
    end
end

x_roi(isnan(x_roi)) = [];
y_roi(isnan(y_roi)) = [];