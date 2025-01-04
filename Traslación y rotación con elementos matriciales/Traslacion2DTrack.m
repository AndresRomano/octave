# Realiza un trazado de la trayectoria, a partir del punto de partida
# el vector de traslacion y la cantidad de partes a segmentar.
# Retorna la cantidad de elementos

function [ vec_track_x, vec_track_y ] = Traslacion2DTrack(Punto, Vector, Nparte)
  pos = 1;
  % Inicia vectores de coordenadas de puntos de trayecto
  vec_track_x(pos) = Punto(1);
  vec_track_y(pos) = Punto(2);
  pos = pos + 1;

  P_tra = Traslacion2D( Punto, Vector );
  %-------------------------------------------------------------------------------
  Vp(1) = Vector(1)/Nparte;
  Vp(2) = Vector(2)/Nparte;

  Vi = Vp;

  while ( abs(Vi(1)) < abs(Vector(1)) )
    
    % Trasladar el punto P segun Vector
    Pi = Traslacion2D( Punto, Vi);
    Vi = Vi + Vp;

    % Actualiza vectores de trayecto
    vec_track_x(pos) = Pi(1);
    vec_track_y(pos) = Pi(2);
    pos = pos + 1;

  endwhile

  % Agrega el punto final del tramo
    vec_track_x(pos) = P_tra(1);
    vec_track_y(pos) = P_tra(2);
    %pos = pos + 1;  
endfunction
