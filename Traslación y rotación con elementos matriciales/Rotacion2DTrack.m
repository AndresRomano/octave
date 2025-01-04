# Realiza un trazado de la trayectoria, a partir del punto de partida
# el vector de traslacion y la cantidad de partes a segmentar.
# Retorna la cantidad de elementos

function [ vec_track_x, vec_track_y ] = Rotacion2DTrack( Punto, Centro, Angulo_rad, Nparte )
  
  pos = 1;
  Ap = Angulo_rad / Nparte;          % Segmento de ángulo
  
  % Rotar el punto Px segunto Angulo_rad, alrededor del origen
  Px = Punto;
  Ai = Ap;
  
  P_rot = Rotacion2D( Punto, Centro, Angulo_rad );

  while (abs(Ai) < abs(Angulo_rad))
    
    Pi = Rotacion2D( Px, Centro, Ai );
    Ai = Ai + Ap;

    % Actualiza vectores de trayecto
    vec_track_x(pos) = Pi(1);
    vec_track_y(pos) = Pi(2);
    pos = pos + 1;
    
  endwhile

  % Agrega el punto final del tramo
    vec_track_x(pos) = P_rot(1);
    vec_track_y(pos) = P_rot(2);
    %pos = pos + 1;
endfunction
