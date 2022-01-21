function distancep2p = p2p(point1,point2)

x1 = point1(1,1);
y1 = point1(1,2);

x2 = point2(1,1);
y2 = point2(1,2);

deltax = x1-x2;
deltay = y1-y2;
distancep2p = sqrt(deltax^2 +deltay^2);
