function B = CalcularActividad2(transmi, recep, dist)
% PARTE A
RxW= recep /1000; %Paso los mW a W
B = -(1/dist)*log(RxW/transmi);
disp(['Parte a):'])
disp(['Formula de factor de absoción: -(1/x)*log(E(x)/Eo)'])
disp(['x= ', num2str(dist), 'Km', ', ', 'Eo=', num2str(transmi), 'W', ', ', 'E(x=', num2str(dist), 'Km) = ', num2str(recep), 'mW'])
disp(['En este caso: -(1/', num2str(dist), 'KM)*log(', num2str(RxW),'W/', num2str(transmi), 'W)'])
disp(['Resultado: = ',num2str(B),' KM^-1'])
% PARTE B
disp([' '])
G=10*log10(RxW/transmi);
disp(['Parte b)'])
disp(['Perdida de la potencia a los 100Km.'])
disp(['Formula: G=10*log10(PotReceptor/PotEmisor)'])
disp(['En este caso: G=10*log10(', num2str(RxW), '/', num2str(transmi), ')'])
disp(['Resultado: L[dB]= ', num2str(G), 'dB'])

% PARTE C
 disp([' '])
 dist2 = dist/2;
 disp(['Parte c):'])
 disp(['Potencia de la señal a mitad de camino.'])
 disp(['Formula: E(x)=Eo*e^-factorDeAbsorción*x'])
 disp(['x= ', num2str(dist2), 'W', ', ', 'Eo=', num2str(transmi), 'W', ', ', 'factorAbsorcion= ', num2str(B), 'KM^-1'])
 disp(['En nuestro caso: ', num2str(transmi),'W', '*', 'e^((-', num2str(B), 'KM^-1)', '*', num2str(dist2),'Km)'])
 C = transmi*e^(-B*dist2);
 disp(['Resultado: L[dB]= ', num2str(C), 'W'])
 % PARTE D
 disp([' '])
 disp(['Parte d):'])
  % graficas de la parte D
 
 disp([' '])
 
 figure(2)
clear
Vector_X = [0,1,2,3,4,5,6,7,8,9,10];
Vector_Y =[B];
plot(Vector_X, Vector_Y);
title('Elongación en función de distancia');
xlabel('Distancia (Km)');
ylabel('Frecuencia (Hz)');
endfunction