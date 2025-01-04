function A = CalcularActividad1(GiB, RT, Kbps)

  A = GiB * RT;% Calcula la cantidad de datos reenviados, Ej: 4GiB * 0,5 = 2GiB.
  B = GiB + A;%Suma la cantidad de datos originales con los retransmitidos.
  C = (B * 2^30) *8;%Convierte los datos de "GiB" a "B" y luego a "b".
  C2 = (C/10^3)/Kbps;%Pasa los "b" a "Kb" y lo divide entre los "Kbps".
  C3 = C2 / 3600;%El resultado anterior es en segundos, aquí se pasan a horas.
  disp(['Parte a) El volumen de datos reenviados es ',num2str(A),' GiB'])
  disp(['Parte b) El estimado de datos transmitidos es ',num2str(B),' GiB'])
  disp(['Parte c) El Tiempo insumido en la transmisión es: '])
  disp([num2str(C2),' s', ' (Segundos)'])%Tiempo en segundos
  disp([num2str(C3),' h', ' (Horas)'])%Tiempo en horas
 
endfunction