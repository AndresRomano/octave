%  Proyecto: Parte 1. Traslación y rotación con elementos matriciales
%  Autor: Andres Romano
%  Fecha: 30 de setiembre de 2021
%  Ultima modificaciÃ³n: 4 de octubre de 2021    
clear
clc
%*******************************************************************************
% PARAMETROS:

Origen     = [ 0 ; 0];
Alfa_gra = 21;             % Angulo de rotacion en grados
Vector_d = [ 26 ; 26 ];     % Vector de traslacion
Centro_rot = Origen;          % Punto centro de rotacion

P = [ 4 ; 7 ]; 
Nparte  = 4;                 % Cantidad de partes a dividir los invervalos
%*******************************************************************************
Alfa_rad = Alfa_gra * (pi / 180); % Convierte grados en radianes
%-------------------------------------------------------------------------------
% Calculo directo de posiciones finales de los movimientos

P_rot = Rotacion2D( P, Centro_rot, Alfa_rad );
P_r_tra = Traslacion2D( P_rot, Vector_d );
%-------------------------------------------------------------------------------
% Genera un vector con los puntos relevantes, el de partida y los transformados
vec_tx = [ P(1) P_rot(1) P_r_tra(1) ];
vec_ty = [ P(2) P_rot(2) P_r_tra(2) ];
%-------------------------------------------------------------------------------
[ vr_x , vr_y ] = Rotacion2DTrack(P, Centro_rot, Alfa_rad, Nparte)
%-------------------------------------------------------------------------------
[ vt_x , vt_y ] = Traslacion2DTrack(P_rot, Vector_d, Nparte);
%-------------------------------------------------------------------------------
% Se construye ahora vector que concatena los dos anteriores
%-------------------------------------------------------------------------------
vec_track_x = [P(1) vr_x vt_x];
vec_track_y = [P(2) vr_y vt_y];
%-------------------------------------------------------------------------------
figure()
plot(P(1),P(2), 'mo-', 'markersize', 10,'linewidth', 3); grid minor;
title("Parte a)P = [ 4 ; 7 ];", "fontSize", 18);
axis([0,20, 0,20])
axis("square")
%-------------------------------------------------------------------------------
figure()
plot(P_rot(1),P_rot(2), 'mo-', 'markersize', 10,'linewidth', 3); grid minor;
title("Parte b) Rotacion de P en alfa = 21°", "fontSize", 18);
axis([0,5, 0,10])
axis("square")
%-------------------------------------------------------------------------------
figure()
plot(P_r_tra(1),P_r_tra(2), 'mo-', 'markersize', 10,'linewidth', 3); grid minor;
title("Parte c) Traslacion P rotado en Alfa a distancia d = 26", "fontSize", 18);
axis([0,40, 0,40])
axis("square")

%-------------------------------------------------------------------------------
figure()
plot(vec_track_x, vec_track_y, 'go-', 'markersize', 10,'linewidth', 3); grid minor;
%-------------------------------------------------------------------------------
% Superpone graficos con los puntos principales del trayecto
hold on
plot(vec_tx, vec_ty, 'ro', 'markersize', 16,'linewidth', 3); 
title("Parte d) trayectoria conjunta de Rotacion y traslacion", "fontSize", 18);
axis([0,40, 0,40])
axis("square")
%-------------------------------------------------------------------------------