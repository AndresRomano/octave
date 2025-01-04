% Resuelve problemas de radioenlaces
% Jose Sasias - Desarrollado para Curso de Redes 2020
%
clear all
clc

% Parametros globales
%-------------------------------------------------------------------------------
% Coordenadas de los puntos sobre los que se pondrán las antenas (en metros)
xA = 0;  yA=60;
xB = 30000;  yB=60;

f  = 2.5;  % Expresada en GHz
hA = 6.5;     hB = 6.5;  % Alturas de antenas a 6.5 metros

yObst = 36; % Altura máxima de los obstáculos
% Los obstaculos se encuentran a 24 metros de la linea de vista
% y a mitad de trayecto, 60m - 24m = 36m
%-------------------------------------------------------------------------------

X_A = [xA, xB];   Y_A = [yA, yB];  Yobs = [yObst, yObst];

% Determina coordenadas de punto medio de la linea entre antenas

[xC, yC] = medioPunto2D(xA,(yA+hA), xB,(yB+hB));

% Calcula distancia entre los puntos A y B
d_AB = distPunto2D(xA,yA, xB,yB)

% Coordenadas de tope de antenas
xTA=xA; yTA=(yA+hA);
xTB=xB; yTB=(yB+hB);

% Calcula la elipse de la zona de fresnel para el radioenlace
n_zona = 1;
[Xeli, Ysup, Yinf] = ElipseRF(xTA,yTA , xTB,yTB, f, n_zona);

% Representa graficamente

figure();

% Trazar linea de base (A,B)
plot(X_A,Y_A,'color','c','linewidth',1);
hold on

plot(Xeli,Ysup,'color','b','linewidth',2);
plot(Xeli,Yinf,'color','b','linewidth',2);

% Trazar linea de vista LoS (A,B)
Xv = [xA, xB];
Yv = [(yA+hA) , (yB+hB)];
plot(Xv,Yv,'color','r','linewidth',2);

% Trazar linea de nivel de obstáculos
plot(X_A,Yobs,'color','g','linewidth',2);

% Grafica de antenas
XaA=[xA, xA]; YaA=[yA, (yA+hA)];
plot(XaA,YaA,'color','m','linewidth',4);

XaB=[xB, xB]; YaB=[yB, (yB+hB)];
plot(XaB,YaB,'color','m','linewidth',4);

% Representa puntos en azul sobre extremos y linea de antenas
plot(xC, yC,'bo','linewidth',5);
plot(xA, (yA+hA),'bo','linewidth',4);
plot(xB, (yB+hB),'bo','linewidth',4);

grid on;
title("RADIOENLACE Y ZONA DE FRESNEL");
xlabel("Distancia [m]");
ylabel("Altura [m]");

text (xA+1, yA+1, "punto A");
text (xB+1, yB+1, "punto B");
text (xC+0.5, yC+0.5, "Linea de Vista (LoS)");
text (xC+5, yObst+0.1, "Nivel de obstaculos");
%-------------------------------------------------------------------------------
%-------------------------------------------------------------------------------
clear
xA = 0;  yA=60;
xB = 30000;  yB=60;

f  = 2;  % Expresada en GHz
hA = 6.5;     hB = 6.5;  % Alturas de antenas a 6.5 metros

yObst = 36; % Altura máxima de los obstáculos

obstruc = 20; % Porcentaje de obstrucci�n
Radmi = (1-(obstruc/100));
R1 = yObst/Radmi; % Altura m�xima de los obstaculos/Radmisible
xB2 = xB/1000; % se pasa la distancia de las antenas de m a Km
F2= (75*xB2)/R1^2; % se calcula la frecuencia con obstrucci�n
f = F2; % La frecuencia anterior toma el valor de la frecuencia con obstrucci�n

X_A = [xA, xB];   Y_A = [yA, yB];  Yobs = [yObst, yObst];

% Determina coordenadas de punto medio de la linea entre antenas

[xC, yC] = medioPunto2D(xA,(yA+hA), xB,(yB+hB));

% Calcula distancia entre los puntos A y B
d_AB = distPunto2D(xA,yA, xB,yB)

% Coordenadas de tope de antenas
xTA=xA; yTA=(yA+hA);
xTB=xB; yTB=(yB+hB);

% Calcula la elipse de la zona de fresnel para el radioenlace
n_zona = 1;
[Xeli, Ysup, Yinf] = ElipseRF(xTA,yTA , xTB,yTB, f, n_zona);

% Representa graficamente

figure(2);

% Trazar linea de base (A,B)
plot(X_A,Y_A,'color','c','linewidth',1);
hold on

plot(Xeli,Ysup,'color','b','linewidth',2);
plot(Xeli,Yinf,'color','b','linewidth',2);

% Trazar linea de vista LoS (A,B)
Xv = [xA, xB];
Yv = [(yA+hA) , (yB+hB)];
plot(Xv,Yv,'color','r','linewidth',2);

% Trazar linea de nivel de obstáculos
plot(X_A,Yobs,'color','g','linewidth',2);

% Grafica de antenas
XaA=[xA, xA]; YaA=[yA, (yA+hA)];
plot(XaA,YaA,'color','m','linewidth',4);

XaB=[xB, xB]; YaB=[yB, (yB+hB)];
plot(XaB,YaB,'color','m','linewidth',4);

% Representa puntos en azul sobre extremos y linea de antenas
plot(xC, yC,'bo','linewidth',5);
plot(xA, (yA+hA),'bo','linewidth',4);
plot(xB, (yB+hB),'bo','linewidth',4);

grid on;
title("RADIOENLACE Y ZONA DE FRESNEL CON 20% de obstrucci�n");
xlabel("Distancia [m]");
ylabel("Altura [m]");

text (xA+1, yA+1, "punto A");
text (xB+1, yB+1, "punto B");
text (xC+0.5, yC+0.5, "Linea de Vista (LoS)");
text (xC+5, yObst+0.1, "Nivel de obstaculos");

