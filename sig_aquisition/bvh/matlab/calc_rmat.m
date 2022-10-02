function rmat = calc_rmat(r, p, y)
%CALC_RMAT calculate rotation matrix in ZXY (rpy) order
cosR = cos(r);
sinR = sin(r);

cosY = cos(y);
sinY = sin(y);

cosP = cos(p);
sinP = sin(p);

rmat = [cosR*cosY-sinR*sinP*sinY, -sinR*cosP, cosR*sinY+sinR*sinP*cosY;
    sinR*cosY+cosR*sinP*sinY, cosR*cosP, sinR*sinY-cosR*sinP*cosY;
    -cosP*sinY, sinP, cosP*cosY];   %direct rotation matrix 
end

