clear
valor =input('Indique el voltaje de entrada: ', 's');
Tx=str2num(valor);
valor =input('Indique el voltaje de salida: ', 's');
Rx=str2num(valor);
disp(['Tx= ',num2str(Tx),'mV'])
disp(['Rx= ',num2str(Rx),'mV'])
G=20*log10(Rx/Tx);
if(Rx>Tx)%Si el voltaje de salida es mayor al de entrada
disp(['G[dB]=',num2str(G),'dB'])%ganancia
elseif(Rx<Tx)%si el voltaje de Salida es menor al de entrada
disp(['L[dB]=',num2str(G),'dB'])%perdida
elseif(Rx==Tx)%si son iguales
disp(['G[dB]=',num2str(G),'dB'])%ganancia de 0
else
disp(['ERROR!'])
endif