% Funcion para calculo de la elipse de radioenlace
% frec [GHz], coordenadas en metros

function [Xeli, Ysup, Yinf] = ElipseRF(x1,y1 , x2,y2, frec, n_zona)
  
  D = distPunto2D(x1,y1, x2,y2);
  
  % Calcula radio de Fresnel en zona n
  D_km = D/1000;
  rn = 5 * sqrt(3) * sqrt( (n_zona*D_km)/frec );

  % Determina el centro de la elipse
  [xC, yC] = medioPunto2D(x1,y1, x2,y2);
   
  % Calcula el angulo de inclinacion
  tan_phi = (y2 - y1) / (x2 -x1);
  phi = atan(tan_phi);
  
  % Ajusta parametros geometricos de elipse
  c = D/2;   b = rn;   a = sqrt(b^2 + c^2);
  
  % Trabaja en un sistema de referencia centrado en la elipse
  Xref = [-a:0.1:a]; % vector de puntos en la extensión de la elipse
  Yref_sup = +b * sqrt( 1 - ((Xref.^2)/a^2) );
  Yref_inf = -b * sqrt( 1 - ((Xref.^2)/a^2) );
  
  % Aplica ecuaciones de traslacion + rotacion
  Xeli = xC + (Xref * cos(phi) - Yref_sup * sin(phi));
  Ysup = yC + (Xref * sin(phi) + Yref_sup * cos(phi));
  Yinf = yC + (Xref * sin(phi) + Yref_inf * cos(phi));
  
  printf("Foco(A)=(%d,%d) [m] Foco(B)=(%d,%d) [m] \n", x1,y1,x2,y2);
  printf("Distancia: ( Foco(A), Foco(B) ) = %d [m] \n", D);
  
  printf("Parametros de Elipse a=%d [m] b=%d [m] c=%d [m] \n", a, b, c);
  
  printf("Radio de Fresnel rn=%d [m] n=%d \n", rn, n_zona);
  
  printf("Inclinacion phi=%d [rad] phi=%d [gra] \n", phi, phi*(180/pi));
  
endfunction
