# Recibe como entrada un Punto del plano P=[x y] y un vector v=[vx vy]
# Retorna las coordenadas del punto resultante de la traslacion.

function Punto_T = Traslacion2D( Punto, Vector )
  Punto_T(1) = Punto(1) + Vector(1);
  Punto_T(2) = Punto(2) + Vector(2);
endfunction
